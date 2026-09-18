#
# Copyright (C) 2026 The LineageOS Project
# Copyright (C) 2026 Project Infinity-X
#
# SPDX-License-Identifier: Apache-2.0
#

# AOSP base inheritance. core_64_bit + full_base MUST come before vendor/device
# makefiles, otherwise you end up with a 256 MB system image of 16 binaries.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
# WiFi-only tablet: full_base.mk (generic_no_telephony) instead of
# full_base_telephony.mk.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Virtual A/B + vendor_ramdisk + compression.
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Sounds
$(call inherit-product-if-exists, frameworks/base/data/sounds/AllAudio.mk)

# Project Infinity-X common add-ons
$(call inherit-product, vendor/infinity/config/common.mk)

# Device-specific
$(call inherit-product, device/lenovo/TB375FC/device.mk)

# Vendor blobs
ifneq ($(wildcard vendor/lenovo/TB375FC/tb375fc-vendor.mk),)
$(call inherit-product, vendor/lenovo/TB375FC/tb375fc-vendor.mk)
else
$(call inherit-product-if-exists, vendor/lenovo/TB375FC/TB375FC-vendor.mk)
endif
$(call inherit-product-if-exists, vendor/lenovo/TB375FC/TB375FC-overlays.mk)

# Tablet wifi-only base
$(call inherit-product, vendor/infinity/config/common_full_tablet_wifionly.mk)

PRODUCT_DEVICE := TB375FC
PRODUCT_NAME := infinity_TB375FC
PRODUCT_BRAND := Lenovo
PRODUCT_MODEL := TB375FC

# PRC SKU identity
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.config.lgsi.hw.version=TB375FC \
    ro.vendor.config.lgsi.ota.model=TB375FC_PRC
PRODUCT_MANUFACTURER := Lenovo
PRODUCT_CHARACTERISTICS := tablet

PRODUCT_GMS_CLIENTID_BASE := android-lenovo-rev2

# Maintainer
INFINITY_MAINTAINER := MuktoX
