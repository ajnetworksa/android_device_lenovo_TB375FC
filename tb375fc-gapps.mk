#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# ─────────────────────────────────────────────────────────────────────────────
# MindTheGapps Compatibility — Lenovo TB375FC (MT6897)
# ─────────────────────────────────────────────────────────────────────────────
#
# System, product, and system_ext use ext4 (see BoardConfig.mk) so the
# MindTheGapps recovery installer can write APKs at flash time.
#
# Install instructions:
#   1. Boot TWRP or LineageOS Recovery
#   2. Flash lineage-*-TB375FC*.zip
#   3. Flash MindTheGapps-*-arm64-*.zip (arm64 / Android 16 build)
#      → https://github.com/MindTheGapps/16.0.0-arm64/releases/latest
#   4. Reboot system — Play Store appears on first boot
#

# ── Google Client ID ──────────────────────────────────────────────────────────

# Tells Play Services which OEM licensing bucket to use. The value
# android-lenovo-rev2 is registered for Lenovo tablets with GMS certification.
PRODUCT_GMS_CLIENTID_BASE := android-lenovo-rev2

# ── Setup Wizard ──────────────────────────────────────────────────────────────

# Lock SUW to landscape on first boot. This 12.7" panel reports landscape as
# its natural orientation; SUW without this lock tries portrait and clips UI.
PRODUCT_SYSTEM_PROPERTIES += \
    ro.setupwizard.rotation_locked=true

# Skip enterprise device enrollment prompt (not relevant for consumer tablets).
PRODUCT_SYSTEM_PROPERTIES += \
    ro.setupwizard.enterprise_mode=1

# ── GMS / Play Integrity ──────────────────────────────────────────────────────

# Play Services crash reporting endpoint.
PRODUCT_SYSTEM_PROPERTIES += \
    ro.error.receiver.system.apps=com.google.android.gms

# ── Notification / Ringtone Defaults ─────────────────────────────────────────

# GMS initialises these on first boot from /product/media/audio; the SUW
# ringtone picker presents them. Values match stock Lenovo A16 defaults.
PRODUCT_SYSTEM_PROPERTIES += \
    ro.config.ringtone=Titania.ogg \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Argon.ogg

# ── Widevine ─────────────────────────────────────────────────────────────────

# Widevine L1 APEX + liboemcrypto.so are installed via the vendor blob tree
# (tb375fc-vendor.mk). ro.vendor.mtk_widevine_drm_l1_support=1 is set in
# tb375fc-stock-vendor-props.mk and gates the MTK L1 path in the DRM HAL.
