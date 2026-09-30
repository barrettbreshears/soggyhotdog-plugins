---
name: capture-screenshots
description: Capture clean, full-resolution raw screenshots of the mobile app in this repository from the iOS Simulator or an Android emulator, with a tidy status bar and demo content, ready to become App Store or Google Play screenshots. Use when the user needs raw app screens for store images, or when store-screenshots finds none in the repo.
---

# Capturing raw app screens

Store images are only as good as the screens inside them. Aim for: the right device size, portrait,
a clean status bar, believable demo content, and nothing on screen that is not the app.

## Devices

| Store | Simulator or emulator | Pixels |
|---|---|---|
| App Store iPhone | the newest iPhone Pro Max (6.9 inch) | 1320 x 2868 or 1290 x 2796 |
| App Store iPad | iPad Pro 13-inch | 2064 x 2752 |
| Google Play phone | a Pixel phone image, portrait | 1080 x 2400 or larger |

Smaller devices work (soggyhotdog scales), but the largest gives the sharpest result.

## Use the project's own automation first

If it exists, it gives repeatable screens with the right data:

- **fastlane snapshot** (`fastlane/Snapfile`, a UI test target with `snapshot(...)` calls):
  `bundle exec fastlane snapshot`. Output lands in `fastlane/screenshots/<locale>/`.
- **fastlane screengrab** (`fastlane/Screengrabfile`): `bundle exec fastlane screengrab`.
- **Maestro** (`.maestro/` flows with `takeScreenshot`): `maestro test .maestro/<flow>.yaml`.

These can take several minutes and need a build. Tell the user before starting one.

## iOS Simulator

```bash
xcrun simctl list devices available | grep -E "iPhone.*Pro Max|iPad Pro"
xcrun simctl boot "<udid>" && open -a Simulator
```

Build and run the app on it with the project's usual tool:

- **Xcode project**: `xcodebuild -scheme "<Scheme>" -destination "platform=iOS Simulator,id=<udid>" -derivedDataPath build build`
  (use `-workspace <App>.xcworkspace` when there is one), then
  `xcrun simctl install booted build/Build/Products/Debug-iphonesimulator/<App>.app` and
  `xcrun simctl launch booted <bundle id>`.
- **Flutter**: `flutter run -d <udid>`. **Expo**: `npx expo run:ios --device "<name>"`.
  **React Native**: `npx react-native run-ios --simulator "<name>"`.

Make the status bar look like Apple's own marketing:

```bash
xcrun simctl status_bar booted override --time 9:41 --dataNetwork wifi --wifiMode active --wifiBars 3 \
  --cellularMode active --cellularBars 4 --batteryState charged --batteryLevel 100
xcrun simctl ui booted appearance light    # or dark; keep it the same for the whole set
```

Capture each screen:

```bash
mkdir -p raw-screenshots
xcrun simctl io booted screenshot --type=png raw-screenshots/01-home.png
sips -g pixelWidth -g pixelHeight raw-screenshots/01-home.png
```

When done: `xcrun simctl status_bar booted clear`.

## Android emulator

```bash
emulator -list-avds
emulator -avd "<name>" -no-snapshot-load &
adb wait-for-device && adb shell getprop sys.boot_completed   # 1 when ready
```

Install and launch: `./gradlew installDebug` then
`adb shell monkey -p <applicationId> -c android.intent.category.LAUNCHER 1`. Flutter:
`flutter run -d emulator-5554`. Expo: `npx expo run:android`.

Clean status bar with demo mode:

```bash
adb shell settings put global sysui_demo_allowed 1
adb shell am broadcast -a com.android.systemui.demo -e command enter
adb shell am broadcast -a com.android.systemui.demo -e command clock -e hhmm 0941
adb shell am broadcast -a com.android.systemui.demo -e command battery -e level 100 -e plugged false
adb shell am broadcast -a com.android.systemui.demo -e command network -e wifi show -e level 4 -e mobile show -e level 4
adb shell am broadcast -a com.android.systemui.demo -e command notifications -e visible false
```

Capture: `adb exec-out screencap -p > raw-screenshots/01-home.png`. When done:
`adb shell am broadcast -a com.android.systemui.demo -e command exit`.

## Getting to each screen

- **Deep links** are fastest when the app has them. Look for URL schemes (`CFBundleURLTypes` in
  `Info.plist`, `scheme` in Expo's `app.json`, intent filters in `AndroidManifest.xml`) and routes in
  the router. iOS: `xcrun simctl openurl booted "<scheme>://<route>"`. Android:
  `adb shell am start -W -a android.intent.action.VIEW -d "<scheme>://<route>" <applicationId>`.
- **Otherwise ask the user** to drive: "Put the app on the meal plan screen and say when." Take one
  screen per turn, and check each capture before moving on.
- Do not add code to the app to reach a screen without asking.

## What a good capture looks like

- **Believable demo content**: populated lists, realistic names and numbers, nothing personal. If the
  app has a demo account, seed data or preview mode, use it.
- **No developer clutter**: no Flutter debug banner (run in profile mode, or set
  `debugShowCheckedModeBanner: false`), no React Native LogBox or dev menu (use a release build), no
  test flags or debug overlays.
- **No interruptions**: no keyboard unless the screen is about typing, no permission dialogs, no
  system alerts, no toasts mid-fade.
- Portrait, the same appearance across the set, and the same device for every capture.

Name the files in shipping order (`01-...`, `02-...`) and tell the user where they are. If the
store-screenshots skill sent you here, go back to it and upload them.
