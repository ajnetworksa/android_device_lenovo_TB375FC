# Lenovo Xiaoxin Pad Pro 12.7 (2025) - TB375FC

LineageOS 23.2 (Android 16) device tree for the Lenovo Xiaoxin Pad Pro 12.7 (2025), `TB375FC`, the PRC Wi-Fi variant. ODM is Wingtech; the internal project codename is `peridot`.

## Specifications

| Component | Detail |
|-----------|--------|
| SoC | MediaTek Dimensity 8300 (MT6897) |
| GPU | Mali-G615 MC10 |
| RAM / Storage | 8 GB / 128 GB, 8 GB / 256 GB, or 12 GB / 256 GB (UFS 4.0) |
| Display | 12.7" 3K (2944 x 1840) IPS LCD, 144 Hz (toggable, see Technical Notes) |
| Battery | ~10200 mAh |
| Connectivity | Wi-Fi 6E, Bluetooth 5.4 (MediaTek connsys), no cellular |
| Cameras | 13 MP rear, 8 MP front |
| Fingerprint | Goodix side-mounted |
| Stylus | Lenovo Tab Pen Plus (active Bluetooth stylus) |
| Stock OS | ZUI 16 (Android 14) / ZUI 17 (Android 16 / ZUXOS 1.5.10.060) |

---

## Features & Customizations

This device tree incorporates premium-tier, custom-tuned framework configurations, optimizations, and system integrations:

### 1. UI Aesthetics & Fluidity
*   **System-Wide Liquid Glass (Frosted Blur)**: Enabled SurfaceFlinger background-blur compositing engine at the GPU level (Mali-G615). Frosted glass visual depth is active on:
    *   Quick Settings panel background (`config_qsBlurRadius = 64px`)
    *   Notification shade overlay (`config_notificationShadeBlurRadius = 48px`)
    *   Lock screen background (`config_keyguardBlurRadius = 80px`)
    *   Material3 Dialogs and Bottom Sheets (`config_dialogCornerRadius = 32dp`)
    *   Recents overview thumbnails and freeform taskbar
    *   App drawer and Launcher3 folder background layers
*   **iOS-Style Scroll Physics**: Lowered deceleration friction (`config_scrollFriction = 0.008`) to match iOS scroll momentum and glide distance.
*   **3K Display HWUI Rendering Caches**: Boosted texture, layer, path, and text caches in `tb375fc-animations.mk` specifically for the 3K (2944x1840) screen resolution to eliminate frame drops during transitions.
*   **Touch Sampling Rate**: Configured touch reports at 360 Hz (`ro.vendor.touchpanel.report_rate=360`) for the NT36532 panel.

### 2. Charging & Battery Optimization
*   **Lockscreen Charging Ripples**: Pixel-style dynamic wave animation sweeps across the screen when power is connected.
*   **Battery Styles**: Exposed circular battery icon indicators and customization options in the status bar.
*   **LineageOS Charging Control**: Integrates schedule-based and threshold-capped charging rules (`config_chargingControlSupported=true`) to protect long-term battery lifespan.
*   **Smart Battery (Adaptive Battery)**: Auto-restricts background resource usage for inactive apps (`config_smartBatterySupported=true`).
*   **Deep Doze Sleep**: Custom auto-power modes enable aggressive device idle sleep cycles (`config_enableAutoPowerModes=true`) for outstanding standby battery backup.
*   **Dynamic Power Savings**: Integrates real-time scaling of power levels (`config_dynamicPowerSavingsSupported=true`).

### 3. Smart Custom ROM Features
*   **Pocket Mode**: Prevents accidental screen wakes and touches inside pockets/bags using the ambient proximity/light sensors.
*   **Volume Rocker Wake**: Wake the device screen directly using the physical volume up/down buttons.
*   **App Cloner (Multi-user)**: Supports up to 4 concurrent user accounts and cloned application profiles.
*   **One UI-Inspired Comfort Controls**:
    *   *Extra Dim*: Enables screen dimming far below the minimum hardware backlight level.
    *   *One-Handed Mode*: Swipe down on the navigation pill to pull down the top-half of the interface.
    *   *Haptic Intensity Sliders*: Exposes individual haptics customization for touch, notifications, and alarms.
*   **Persistent Clipboard**: Disabled AOSP's 60-minute clipboard auto-clear timeout; clipboard history keeps up to 20 clips indefinitely.
*   **Game Manager Service**: Integrates AOSP `GameManagerService` performance profiles and GameSpace dashboard configuration mapping.
*   **LineageOS LiveDisplay**: Fully supports custom screen color profiles, reader modes, and automatic night light controls.

### 4. System-Integrated Prebuilt Apps
We have pre-configured a set of highly optimized, open-source system applications that get installed with prebuilt permission policies so that they run seamlessly out-of-the-box:
*   **Saber (Notes)**: Set as the system default note-taking application (`config_enableDefaultNotes=true`). Allows instant launching directly on active stylus key presses.
*   **PocketPal AI**: An offline, on-device local LLM assistant client.
*   **SD Maid SE**: Serving as the integrated "Device Care" dashboard manager.
*   **WiFiAnalyzer**: Integrated network heat map inspector and intelligent Wi-Fi helper.
*   **Brave Browser**: A privacy-focused browser with built-in ad-blocking.
*   *Pre-granted Permissions*: FINE_LOCATION, FILE_ACCESS, and NOTIFICATIONS are pre-granted at boot for these apps via `configs/default-permissions-prebuilts.xml`.

---

## Build Process

### 1. Initialize & Sync Tree
```bash
repo init -u https://github.com/LineageOS/android.git -b lineage-23.2
```

Add the following local manifest configuration to `.repo/local_manifests/TB375FC.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="LosSantosPro/android_device_lenovo_TB375FC" path="device/lenovo/TB375FC" remote="github" revision="lineage-23.2" />
  <project name="LosSantosPro/android_vendor_lenovo_TB375FC" path="vendor/lenovo/TB375FC" remote="github" revision="lineage-23.2" />
  <project name="LineageOS/android_hardware_mediatek" path="hardware/mediatek" remote="github" revision="lineage-23.2" />
  <!-- Open-source Gaming Dashboard -->
  <project name="chaldeaprjkt/packages_apps_GameSpace" path="packages/apps/GameSpace" remote="github" revision="main" />
</manifest>
```

Run repo sync:
```bash
repo sync -c -j$(nproc) --force-sync --no-clone-bundle --no-tags
```

### 2. Download Prebuilt System App APKs
Before building, you must download the precompiled APK files and place them in the `device/lenovo/TB375FC/apps/` directory named exactly as follows (Refer to [apps/README.md](file:///d:/Devlopment/android_device_lenovo_TB375FC/apps/README.md) for download links):
*   `Saber.apk`
*   `PocketPalAI.apk`
*   `SDMaidSE.apk`
*   `WiFiAnalyzer.apk`
*   `Brave.apk`

### 3. Compile
Set up the build environment, select a target, and compile:
```bash
source build/envsetup.sh
lunch lineage_TB375FC-bp4a-userdebug
mka bacon
```
*Available target combos:*
*   `lineage_TB375FC-bp4a-userdebug` (Recommended for developer testing)
*   `lineage_TB375FC-bp4a-user` (Production-grade signed build)
*   `lineage_TB375FC-bp4a-eng` (Debug build with root access)

---

## Flashing & Installation (TWRP-less Recovery Method)

This device utilizes dynamic partitions and GKI (Generic Kernel Image) architecture. Because TWRP is not yet available, installation must be performed using **Lineage Recovery**:

### Prerequisites
*   Unlocked Bootloader (Perform unlock via standard Lenovo zui/fastboot steps).
*   ADB & Fastboot tools installed on your PC.

### Flashing Steps
1. Reboot the tablet into **Fastboot Mode** (Hold Power + Vol Down on boot, or run `adb reboot bootloader`).
2. Flash the compiled core images via Fastboot. **Crucial:** You must flash all three core boot partitions (`boot.img`, `vendor_boot.img`, and `init_boot.img`):
   ```bash
   fastboot flash boot boot.img
   fastboot flash vendor_boot vendor_boot.img
   fastboot flash init_boot init_boot.img
   ```
   > [!IMPORTANT]
   > The `init_boot.img` contains the first-stage ramdisk for GKI boot initialization. Leaving it unflashed or mismatched will result in immediate bootloops.
3. Reboot into recovery:
   ```bash
   fastboot reboot recovery
   ```
4. Perform data format: Select **Factory Reset** -> **Format data/factory reset** (Required to clear stock encryption and set up the ext4 partition structures).
5. Sideload the ROM: Select **Apply Update** -> **Apply from ADB** and execute:
   ```bash
   adb sideload lineage-23.2-XXXXXXXX-UNOFFICIAL-TB375FC.zip
   ```
6. Sideload GApps (Optional): Since we built the `system`, `product`, and `system_ext` partitions using **ext4** (read-write) instead of compressed read-only EROFS, the GApps package can be written directly by the recovery installer.
   *   Do **NOT** reboot yet.
   *   Select **Apply Update** -> **Apply from ADB** and execute:
   ```bash
   adb sideload MindTheGapps-16.0.0-arm64-XXXXXXXX.zip
   ```
7. Select **Reboot system now**.

---

## Debugging & Log Collection

If you encounter system issues, bootloops, or flashing errors, capture logs using these methods:

### 1. Flashing / Recovery Level (Installation failures)
If sideloading the ROM or GApps fails in Lineage Recovery:
* **While still in Recovery Mode**, connect your tablet to a PC.
* Run the following commands to retrieve recovery logs:
  ```bash
  adb pull /tmp/recovery.log
  adb pull /tmp/last_log
  ```
* These logs will explain why partition mounting failed, why dynamic partitions couldn't size, or why GApps extraction failed.

### 2. On-Device Logging (No PC required)
For capturing runtime application crashes, haptic glitches, or network bugs directly on the tablet:
* **Recommended App**: [MatLog (Material Logcat)](https://github.com/plusCubed/matlog/releases) is a lightweight, open-source on-device log viewer.
* Install the APK, open it, and grant the required `READ_LOGS` permission via ADB once (or if rooted, auto-grant):
  ```bash
  adb shell pm grant com.pluscubed.matlog android.permission.READ_LOGS
  ```
* Open MatLog, reproduce the issue, and export the log file.

### 3. PC-Based Log Extraction (System Runtime)
For full, high-fidelity system-level logging from a PC:
* **Logcat (Android System/Apps)**:
  ```bash
  adb logcat -d > logcat.txt
  ```
* **Kmsg / Dmesg (Kernel & Hardware Drivers)**:
  ```bash
  adb shell su -c dmesg > dmesg.txt
  ```
* **Pstore / Ramoops (Post-crash / Sudden reboot logs)**:
  If the device panics and automatically restarts, the last crash log is saved in RAM:
  ```bash
  adb shell su -c "cat /sys/fs/pstore/console-ramoops" > ramoops.txt
  ```

---

## Technical Notes

*   **Display Refresh Rates (144 Hz / 120 Hz)**: The hardware panel supports up to 144 Hz. By default, this ROM runs at the full 144 Hz for extreme smoothness with Dynamic Refresh Rate toggles exposed in Settings. However, note that the NVT touch controller cannot reliably scan the active pen/stylus at 144 Hz (due to tight frame budgets). If you use a stylus, it is recommended to toggle the display to 120 Hz or below in Settings to prevent stylus signal drops.
*   **Filesystem Selection**: To enable recovery-level GApps injection, we configure `ext4` filesystems for system-level images. GMS/Play Services and Google Core components will fail to flash if the partitions are EROFS. We continue to compile `vendor` and `odm` targets as `erofs` to optimize partition block density.
*   **Signing**: Builds are signed with test keys. Generate private keys for production releases.

## License

Apache-2.0. See file headers for details.
