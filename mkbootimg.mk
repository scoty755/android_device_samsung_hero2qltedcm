LOCAL_PATH := $(call my-dir)

ifdef TARGET_PREBUILT_DTB
	BOARD_MKBOOTIMG_ARGS += --dt $(TARGET_PREBUILT_DTB)
	PREBUILT_MKBOOTIMG := $(PLATFORM_PATH)/mkbootimg
endif

INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.img
$(INSTALLED_BOOTIMAGE_TARGET): $(INSTALLED_RAMDISK_TARGET)
	@echo ----- Making recovery image ------
	$(hide) $(PREBUILT_MKBOOTIMG) \
		--kernel $(TARGET_PREBUILT_KERNEL) \
		--ramdisk $(PRODUCT_OUT)/ramdisk.img \
		--cmdline "$(BOARD_KERNEL_CMDLINE)" \
		--base $(BOARD_KERNEL_BASE) \
		--pagesize $(BOARD_KERNEL_PAGESIZE) \
		$(BOARD_MKBOOTIMG_ARGS) \
		-o $(INSTALLED_BOOTIMAGE_TARGET)

INSTALLED_RECOVERYIMAGE_TARGET := $(PRODUCT_OUT)/recovery.img
$(INSTALLED_RECOVERYIMAGE_TARGET): $(recovery_ramdisk)
	@echo ----- Making recovery image ------
	$(hide) $(PREBUILT_MKBOOTIMG) \
		--kernel $(TARGET_PREBUILT_KERNEL) \
		--ramdisk $(PRODUCT_OUT)/ramdisk-recovery.img \
		--cmdline "$(BOARD_KERNEL_CMDLINE)" \
		--base $(BOARD_KERNEL_BASE) \
		--pagesize $(BOARD_KERNEL_PAGESIZE) \
		$(BOARD_MKBOOTIMG_ARGS) \
		-o $(INSTALLED_RECOVERYIMAGE_TARGET)
	@echo ----- Made recovery image -------- $@
	$(hide) tar -C $(PRODUCT_OUT) -H ustar -c recovery.img > $(PRODUCT_OUT)/recovery.tar
	@echo ----- Made recovery image tar -------- $@.tar
