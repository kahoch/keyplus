PROJECT_NAME     := $(TARGET)
TARGETS          := nrf52840_xxaa
OUTPUT_DIRECTORY := $(BUILD_TARGET_DIR)

LINKER_SCRIPT  := $(NRF52_LINK_SCRIPT)

# $(OUTPUT_DIRECTORY)/nrf52840_xxaa.out: \
#   LINKER_SCRIPT  := $(NRF52_LINK_SCRIPT)

$(OUTPUT_DIRECTORY)/nrf52840_xxaa.out: \
  LINKER_SCRIPT  := $(NRF52_LINK_SCRIPT)

ASM_FILES += \
  $(SDK_ROOT)/modules/nrfx/mdk/gcc_startup_nrf52840.S \

# Source files common to all targets
SRC_FILES += \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_rtt.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_serial.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_uart.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_default_backends.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_frontend.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_str_formatter.c \
  $(SDK_ROOT)/components/boards/boards.c \
  $(SDK_ROOT)/components/libraries/util/app_error.c \
  $(SDK_ROOT)/components/libraries/util/app_error_handler_gcc.c \
  $(SDK_ROOT)/components/libraries/util/app_error_weak.c \
  $(SDK_ROOT)/components/libraries/util/app_util_platform.c \
  $(SDK_ROOT)/components/libraries/util/nrf_assert.c \
  $(SDK_ROOT)/components/libraries/atomic/nrf_atomic.c \
  $(SDK_ROOT)/components/libraries/balloc/nrf_balloc.c \
  $(SDK_ROOT)/components/libraries/memobj/nrf_memobj.c \
  $(SDK_ROOT)/components/libraries/ringbuf/nrf_ringbuf.c \
  $(SDK_ROOT)/components/libraries/strerror/nrf_strerror.c \
  $(SDK_ROOT)/external/fprintf/nrf_fprintf.c \
  $(SDK_ROOT)/external/fprintf/nrf_fprintf_format.c \
  $(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_uart.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_uart.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_uarte.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/prs/nrfx_prs.c \
  $(SDK_ROOT)/modules/nrfx/soc/nrfx_atomic.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_clock.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_rtc.c \
  $(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_clock.c \
  $(SDK_ROOT)/modules/nrfx/mdk/system_nrf52840.c \
  $(SDK_ROOT)/modules/nrfx/hal/nrf_nvmc.c \

# Include folders common to all targets
INC_FOLDERS += \
  $(SDK_ROOT)/components \
  $(SDK_ROOT)/components/libraries/strerror \
  $(SDK_ROOT)/components/toolchain/cmsis/include \
  $(SDK_ROOT)/components/libraries/util \
  $(SDK_ROOT)/components/libraries/balloc \
  $(SDK_ROOT)/components/libraries/ringbuf \
  $(SDK_ROOT)/components/libraries/bsp \
  $(SDK_ROOT)/components/libraries/log \
  $(SDK_ROOT)/components/libraries/experimental_section_vars \
  $(SDK_ROOT)/components/libraries/delay \
  $(SDK_ROOT)/components/libraries/atomic \
  $(SDK_ROOT)/components/boards \
  $(SDK_ROOT)/components/libraries/memobj \
  $(SDK_ROOT)/components/libraries/log/src \
  $(SDK_ROOT)/external/fprintf \
  $(SDK_ROOT)/modules/nrfx \
  $(SDK_ROOT)/modules/nrfx/hal \
  $(SDK_ROOT)/modules/nrfx/mdk \
  $(SDK_ROOT)/modules/nrfx/drivers/include \
  $(SDK_ROOT)/integration/nrfx/legacy \
  $(SDK_ROOT)/integration/nrfx \

# Libraries common to all targets
LIB_FILES += \


ifeq ($(USE_SOFTDEVICE), 0)
    SRC_FILES += \
    $(SDK_ROOT)/components/drivers_nrf/nrf_soc_nosd/nrf_nvic.c \
    $(SDK_ROOT)/components/drivers_nrf/nrf_soc_nosd/nrf_soc.c \

    INC_FOLDERS += \
    $(SDK_ROOT)/components/drivers_nrf/nrf_soc_nosd \
    #
endif

#######################################################################
#                             segger_rtt                              #
#######################################################################

SRC_FILES += \
  $(SDK_ROOT)/external/segger_rtt/SEGGER_RTT.c \
  $(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_Syscalls_GCC.c \
  $(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_printf.c \

INC_FOLDERS += \
  $(SDK_ROOT)/external/segger_rtt \

#######################################################################
#                               gpiote                                #
#######################################################################

SRC_FILES += \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_gpiote.c \

# Include folders common to all targets
INC_FOLDERS += \

# Libraries common to all targets
LIB_FILES += \



#######################################################################
#                              nrf_spim                               #
#######################################################################

SRC_FILES += \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_spim.c \

# Include folders common to all targets
INC_FOLDERS += \

# Libraries common to all targets
LIB_FILES += \

#######################################################################
#                               nrf_esb                               #
#######################################################################

SRC_FILES += \
  $(SDK_ROOT)/components/proprietary_rf/esb/nrf_esb.c \

# Include folders common to all targets
INC_FOLDERS += \
  $(SDK_ROOT)/components/proprietary_rf/esb \

# Libraries common to all targets
LIB_FILES += \

CFLAGS += -DESB_PRESENT
ASMFLAGS += -DESB_PRESENT

#######################################################################
#                              Bluetooth                              #
#######################################################################

ifeq ($(USE_SOFTDEVICE), 1)

    SRC_FILES += \
    $(SDK_ROOT)/components/ble/peer_manager/auth_status_tracker.c \
    $(SDK_ROOT)/components/ble/common/ble_advdata.c \
    $(SDK_ROOT)/components/ble/ble_advertising/ble_advertising.c \
    $(SDK_ROOT)/components/ble/common/ble_conn_params.c \
    $(SDK_ROOT)/components/ble/common/ble_conn_state.c \
    $(SDK_ROOT)/components/ble/ble_link_ctx_manager/ble_link_ctx_manager.c \
    $(SDK_ROOT)/components/ble/common/ble_srv_common.c \
    $(SDK_ROOT)/components/ble/peer_manager/gatt_cache_manager.c \
    $(SDK_ROOT)/components/ble/peer_manager/gatts_cache_manager.c \
    $(SDK_ROOT)/components/ble/peer_manager/id_manager.c \
    $(SDK_ROOT)/components/ble/nrf_ble_gatt/nrf_ble_gatt.c \
    $(SDK_ROOT)/components/ble/nrf_ble_qwr/nrf_ble_qwr.c \
    $(SDK_ROOT)/components/ble/peer_manager/peer_data_storage.c \
    $(SDK_ROOT)/components/ble/peer_manager/peer_database.c \
    $(SDK_ROOT)/components/ble/peer_manager/peer_id.c \
    $(SDK_ROOT)/components/ble/peer_manager/peer_manager.c \
    $(SDK_ROOT)/components/ble/peer_manager/peer_manager_handler.c \
    $(SDK_ROOT)/components/ble/peer_manager/pm_buffer.c \
    $(SDK_ROOT)/components/ble/peer_manager/security_dispatcher.c \
    $(SDK_ROOT)/components/ble/peer_manager/security_manager.c \
    \
    $(SDK_ROOT)/components/ble/ble_services/ble_bas/ble_bas.c \
    $(SDK_ROOT)/components/ble/ble_services/ble_dis/ble_dis.c \
    $(SDK_ROOT)/components/ble/ble_services/ble_hids/ble_hids.c \
    $(SDK_ROOT)/components/softdevice/common/nrf_sdh.c \
    $(SDK_ROOT)/components/softdevice/common/nrf_sdh_ble.c \
    $(SDK_ROOT)/components/softdevice/common/nrf_sdh_soc.c \
    \
    $(SDK_ROOT)/components/libraries/atomic_fifo/nrf_atfifo.c \
    $(SDK_ROOT)/components/libraries/atomic_flags/nrf_atflags.c \
    $(SDK_ROOT)/components/libraries/bsp/bsp.c \
    $(SDK_ROOT)/components/libraries/bsp/bsp_btn_ble.c \
    $(SDK_ROOT)/components/libraries/button/app_button.c \
    $(SDK_ROOT)/components/libraries/experimental_section_vars/nrf_section_iter.c \
    $(SDK_ROOT)/components/libraries/fds/fds.c \
    $(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage.c \
    $(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage_sd.c \
    $(SDK_ROOT)/components/libraries/pwr_mgmt/nrf_pwr_mgmt.c \
    $(SDK_ROOT)/components/libraries/scheduler/app_scheduler.c \
    $(SDK_ROOT)/components/libraries/sensorsim/sensorsim.c \
    $(SDK_ROOT)/components/libraries/timer/app_timer.c \
    $(SDK_ROOT)/components/libraries/crypto/nrf_crypto_rng.c \
    \
    $(SDK_ROOT)/external/utf_converter/utf.c \

    # Include folders common to all targets
    INC_FOLDERS += \
    $(SDK_ROOT)/components/softdevice/s140/headers \
    $(SDK_ROOT)/components/softdevice/s140/headers/nrf52 \
    $(SDK_ROOT)/components/softdevice/common \
    $(SDK_ROOT)/components/ble/ble_advertising \
    $(SDK_ROOT)/components/ble/ble_dtm \
    $(SDK_ROOT)/components/ble/ble_link_ctx_manager \
    $(SDK_ROOT)/components/ble/ble_racp \
    $(SDK_ROOT)/components/ble/ble_services/ble_ancs_c \
    $(SDK_ROOT)/components/ble/ble_services/ble_ans_c \
    $(SDK_ROOT)/components/ble/ble_services/ble_bas \
    $(SDK_ROOT)/components/ble/ble_services/ble_bas_c \
    $(SDK_ROOT)/components/ble/ble_services/ble_cscs \
    $(SDK_ROOT)/components/ble/ble_services/ble_cts_c \
    $(SDK_ROOT)/components/ble/ble_services/ble_dfu \
    $(SDK_ROOT)/components/ble/ble_services/ble_dis \
    $(SDK_ROOT)/components/ble/ble_services/ble_gls \
    $(SDK_ROOT)/components/ble/ble_services/ble_hids \
    $(SDK_ROOT)/components/ble/ble_services/ble_hrs \
    $(SDK_ROOT)/components/ble/ble_services/ble_hrs_c \
    $(SDK_ROOT)/components/ble/ble_services/ble_hts \
    $(SDK_ROOT)/components/ble/ble_services/ble_ias \
    $(SDK_ROOT)/components/ble/ble_services/ble_ias_c \
    $(SDK_ROOT)/components/ble/ble_services/ble_lbs \
    $(SDK_ROOT)/components/ble/ble_services/ble_lbs_c \
    $(SDK_ROOT)/components/ble/ble_services/ble_lls \
    $(SDK_ROOT)/components/ble/ble_services/ble_nus \
    $(SDK_ROOT)/components/ble/ble_services/ble_nus_c \
    $(SDK_ROOT)/components/ble/ble_services/ble_rscs \
    $(SDK_ROOT)/components/ble/ble_services/ble_rscs_c \
    $(SDK_ROOT)/components/ble/ble_services/ble_tps \
    $(SDK_ROOT)/components/ble/common \
    $(SDK_ROOT)/components/ble/nrf_ble_gatt \
    $(SDK_ROOT)/components/ble/nrf_ble_qwr \
    $(SDK_ROOT)/components/ble/peer_manager \
    $(SDK_ROOT)/components/libraries/sensorsim \
    $(SDK_ROOT)/components/libraries/scheduler \
    $(SDK_ROOT)/components/libraries/fds \
    $(SDK_ROOT)/components/libraries/fstorage \
    $(SDK_ROOT)/components/libraries/pwr_mgmt \
    $(SDK_ROOT)/components/libraries/atomic_fifo \
    $(SDK_ROOT)/components/libraries/atomic_flags \
    $(SDK_ROOT)/components/libraries/bsp \
    $(SDK_ROOT)/components/libraries/button \
    $(SDK_ROOT)/components/libraries/experimental_section_vars \
    $(SDK_ROOT)/components/libraries/stack_info \

    # Libraries common to all targets
    LIB_FILES += \

    CFLAGS += -DNRF_SD_BLE_API_VERSION=6
    CFLAGS += -DS140
    CFLAGS += -DSOFTDEVICE_PRESENT
    CFLAGS += -DSWI_DISABLE0

    ASMFLAGS += -DNRF_SD_BLE_API_VERSION=6
    ASMFLAGS += -DS140
    ASMFLAGS += -DSOFTDEVICE_PRESENT
    ASMFLAGS += -DSWI_DISABLE0

endif

#######################################################################
#                             AES crypto                              #
#######################################################################

# Files for AES crypto
SRC_FILES += \
  $(SDK_ROOT)/components/libraries/crypto/backend/nrf_hw/nrf_hw_backend_init.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_aes.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_aes_aead.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_chacha_poly_aead.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_ecc.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_ecdh.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_ecdsa.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_eddsa.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_hash.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_hmac.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_init.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_mutex.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_rng.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310/cc310_backend_shared.c \
  $(SDK_ROOT)/components/libraries/crypto/backend/cifra/cifra_backend_aes_aead.c \
  $(SDK_ROOT)/components/libraries/crypto/nrf_crypto_aes.c \
  $(SDK_ROOT)/components/libraries/crypto/nrf_crypto_init.c \

INC_FOLDERS += \
  $(SDK_ROOT)/components/libraries/crypto \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310 \
  $(SDK_ROOT)/components/libraries/crypto/backend/cc310_bl \
  $(SDK_ROOT)/components/libraries/crypto/backend/cifra \
  $(SDK_ROOT)/components/libraries/crypto/backend/mbedtls \
  $(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc \
  $(SDK_ROOT)/components/libraries/crypto/backend/nrf_hw \
  $(SDK_ROOT)/components/libraries/crypto/backend/nrf_sw \
  $(SDK_ROOT)/components/libraries/crypto/backend/oberon \
  $(SDK_ROOT)/components/libraries/crypto/backend/optiga \
  $(SDK_ROOT)/components/libraries/crypto \
  $(SDK_ROOT)/components/libraries/mutex \
  $(SDK_ROOT)/external/cifra_AES128-EAX \
  $(SDK_ROOT)/external/nrf_cc310/include \


CFLAGS += -DNRF_CRYPTO_MAX_INSTANCE_COUNT=1
ASMFLAGS += -DNRF_CRYPTO_MAX_INSTANCE_COUNT=1

LIB_FILES += \
  $(SDK_ROOT)/external/nrf_cc310/lib/cortex-m4/hard-float/libnrf_cc310_0.9.12.a \

#######################################################################
#                              USB files                              #
#######################################################################

SRC_FILES += \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_usbd.c \
  $(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_power.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_power.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_systick.c \

INC_FOLDERS += \
  $(SDK_ROOT)/components/libraries/timer \

#######################################################################
#                           compiler flags                            #
#######################################################################

# Optimization flags
OPT ?= -O3

# Uncomment the line below to enable link time optimization
#OPT += -flto

# ifeq ($(USE_BLUETOOTH), 1)
#     CFLAGS += -DBSP_DEFINES_ONLY
#     ASMFLAGS += -DBSP_DEFINES_ONLY
# endif

# C flags common to all targets
CFLAGS += $(OPT)
CFLAGS += -DBOARD_PCA10056
CFLAGS += -DCONFIG_GPIO_AS_PINRESET
CFLAGS += -DFLOAT_ABI_HARD
CFLAGS += -DNRF52840_XXAA
CFLAGS += -mcpu=cortex-m4
CFLAGS += -mthumb -mabi=aapcs
CFLAGS += -Wall -Werror
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
# keep every function in a separate section, this allows linker to discard unused ones
CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
CFLAGS += -fno-builtin -fshort-enums

# C++ flags common to all targets
CXXFLAGS += $(OPT)

# Assembler flags common to all targets
ASMFLAGS += -g3
ASMFLAGS += -mcpu=cortex-m4
ASMFLAGS += -mthumb -mabi=aapcs
ASMFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
ASMFLAGS += -DBOARD_PCA10056
ASMFLAGS += -DCONFIG_GPIO_AS_PINRESET
ASMFLAGS += -DFLOAT_ABI_HARD
ASMFLAGS += -DNRF52840_XXAA

# Linker flags
LDFLAGS += $(OPT)
LDFLAGS += -mthumb -mabi=aapcs -L$(SDK_ROOT)/modules/nrfx/mdk -T$(LINKER_SCRIPT)
LDFLAGS += -mcpu=cortex-m4
LDFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
# let linker dump unused sections
LDFLAGS += -Wl,--gc-sections
# use newlib in nano version
LDFLAGS += --specs=nano.specs

nrf52840_xxaa: CFLAGS += -D__HEAP_SIZE=8192
nrf52840_xxaa: CFLAGS += -D__STACK_SIZE=8192
nrf52840_xxaa: ASMFLAGS += -D__HEAP_SIZE=8192
nrf52840_xxaa: ASMFLAGS += -D__STACK_SIZE=8192

# Add standard libraries at the very end of the linker input, after all objects
# that may need symbols provided by these libraries.
LIB_FILES += -lc -lnosys -lm


.PHONY: default help

# Default target - first one defined
default: $(TARGET_HEX)


# Print all targets that can be built
help:
	@echo following targets are available:
	@echo		nrf52840_xxaa
	@echo		sdk_config - starting external tool for editing sdk_config.h
	@echo		flash      - flashing binary

# TEMPLATE_PATH := $(SDK_ROOT)/components/toolchain/gcc
# include $(TEMPLATE_PATH)/Makefile.common

# TEMPLATE_PATH := $(PROJ_PATH)
# include $(TEMPLATE_PATH)/Makefile.common

include $(KEYPLUS_PATH)/arch/arm/armgcc.mk

$(foreach target, $(TARGETS), $(call define_target, $(target)))

.PHONY: flash erase

# Flash the program
flash: default
	@echo Flashing: $(TARGET_HEX)
	nrfjprog -f nrf52 --program $(TARGET_HEX) --sectorerase
	nrfjprog -f nrf52 --reset

# Flash softdevice
flash_softdevice:
	@echo Flashing: s140_nrf52_6.1.1_softdevice.hex
	nrfjprog -f nrf52 --program $(SDK_ROOT)/components/softdevice/s140/hex/s140_nrf52_6.1.1_softdevice.hex --sectorerase
	nrfjprog -f nrf52 --reset


erase:
	nrfjprog -f nrf52 --eraseall

SDK_CONFIG_FILE := $(BOARD_DIR)/$(BOARD)/sdk_config.h
CMSIS_CONFIG_TOOL := $(SDK_ROOT)/external_tools/cmsisconfig/CMSIS_Configuration_Wizard.jar
sdk_config:
	java -jar $(CMSIS_CONFIG_TOOL) $(SDK_CONFIG_FILE)
