// Copyright 2019 jem@seethis.link
// Licensed under the MIT license (http://opensource.org/licenses/MIT)

#include <unistd.h>

#include "debug.h"
#include "udev_helpers.h"
#include "virtual_input.h"
#include "device_manager.h"
#include "event_mapper.h"
#include "settings_loader.h"
#include "event_codes.h"
#include "stats.h"

#include "core/error.h"
#include "core/flash.h"
#include "core/flash.h"
#include "core/macro.h"
#include "core/matrix_interpret.h"
#include "core/mouse.h"
#include "core/settings.h"
#include "hid_reports/hid_reports.h"
#include "key_handlers/key_hold.h"
#include "key_handlers/key_mouse.h"

static volatile bool g_running = false;
static volatile bool m_should_stop = false;

void kp_mainloop_stop(void) {
    g_running = false;
    m_should_stop = true;
}

void kp_init_all(void) {
    hardware_init();
    init_error_system();
    settings_load_from_flash();
    keyboards_init();
    // g_runtime_settings.mode = TRANS_MODE_BLE;
    reset_hid_reports();
}

void load_config(const char* file_name) {
    int rc;
    FILE *config = fopen(file_name, "rb");
    uint8_t *storage_pos = g_virtual_storage;

    if (config == NULL) {
        KP_LOG_ERROR("couldn't open config file '%s': %s", file_name, strerror(errno));
        exit(EXIT_FAILURE);
    }

    rc = fread(storage_pos, 1, SETTINGS_SIZE, config);

    if (rc != SETTINGS_SIZE) {
        KP_LOG_ERROR("configuration file error reading <settings section>, "
                     "expected %d bytes but got %d", SETTINGS_SIZE, rc);
        exit(EXIT_FAILURE);
    }

    storage_pos += rc;

    {
        const int per_device_storage_size = KEY_MAP_SIZE + sizeof(virtual_device_header_t);
        uint32_t section_size;
        uint32_t size = 0;

        rc = fread(storage_pos, 1, sizeof(uint32_t), config);
        if (rc != sizeof(uint32_t)) {
            KP_LOG_ERROR("configuration file error reading <section_size>, "
                            "expected %ld bytes but got %d",
                            sizeof(uint32_t), rc);
            exit(EXIT_FAILURE);
        }
        section_size = *((uint32_t*)storage_pos);
        storage_pos += rc;

        for (int i=0; size < section_size; ++i) {
            rc = fread(storage_pos, 1, per_device_storage_size, config);
            if (rc != per_device_storage_size) {
                KP_LOG_ERROR("configuration file error reading <keymap table %d>, "
                             "expected %d bytes but got %d",
                             i, per_device_storage_size, rc);
                exit(EXIT_FAILURE);
            }
            size += per_device_storage_size;
            storage_pos += rc;
        }
    }

    {
        int pos = storage_pos - g_virtual_storage;
        int free_space = VIRTUAL_STORAGE_SIZE - pos;
        rc = fread(storage_pos, 1, free_space, config);
        if (rc == free_space) {
            KP_LOG_ERROR("configuration file too big");
            exit(EXIT_FAILURE);
        }
        if (rc == 0) {
            KP_LOG_ERROR("configuration file error reading <layout data>");
            exit(EXIT_FAILURE);
        }
    }

    fclose(config);
}

int kp_mainloop(int argc, const char **argv){
    int rc;
    bool should_sleep;
    const char *config_file = argv[1];
    const char *stats_file = argv[2];

    KP_ASSERT(argc == 3);

    load_config(config_file);
    stats_load(stats_file);
    load_virtual_device_settings();

    kp_init_all();

    create_virtual_keyboard();
    create_virtual_mouse();

    device_manager_init();
    device_manager_enumerate();

    g_running = true;
    should_sleep = false;

    KP_DEBUG_PRINT(1, "starting kp_mainloop\n");
    while (g_running) {
        bool busy = false;

        rc = device_manager_poll(should_sleep);

        if (rc == -EINTR) { // received a signal, which indicates we should close
            break;
        } else if (rc == -EIO) { // fatal error
            break;
        }

        handle_mouse_events();

        interpret_all_keyboard_matrices();

        busy |= macro_task();
        busy |= mouse_key_task();

        send_hid_reports();

        busy |= sticky_key_task();
        busy |= hold_key_task(false);

        send_hid_reports();

        should_sleep = !busy;
    }

    stats_save(NULL);

    device_manager_free();

    kp_virtual_keyboard_close();
    kp_virtual_mouse_close();

    if (m_should_stop) {
        return 1;
    } else {
        return 0;
    }
}
