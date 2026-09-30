# Reading the app from the repository

Find the answers in the project before asking the user anything. Search with the tools you have;
the paths below are where each framework keeps things.

## Which kind of project

| Sign | Project |
|---|---|
| `*.xcodeproj`, `*.xcworkspace`, `Package.swift` with an app target | Native iOS |
| `app/build.gradle(.kts)` or `android/app/build.gradle(.kts)` with `com.android.application` | Native Android |
| `pubspec.yaml` with `flutter:` | Flutter (both) |
| `app.json` or `app.config.(js|ts)` with an `expo` key | Expo (both) |
| `package.json` with `react-native`, plus `ios/` and `android/` | React Native (both) |
| `capacitor.config.(json|ts)` | Capacitor (both) |
| `composeApp/` or `shared/` with Kotlin Multiplatform | KMP (both) |

Platform for soggyhotdog is `ios`, `android` or `both`: what the app actually ships on, not what the
framework could build.

## Name and ids

- **iOS name**: `CFBundleDisplayName` in `Info.plist`, or `INFOPLIST_KEY_CFBundleDisplayName` in
  `project.pbxproj`. **Bundle id**: `PRODUCT_BUNDLE_IDENTIFIER` in `project.pbxproj`, or
  `app_identifier` in `fastlane/Appfile`.
- **Android name**: `android:label` in `AndroidManifest.xml`, usually `@string/app_name` in
  `res/values/strings.xml`. **Application id**: `applicationId` in `app/build.gradle(.kts)`.
- **Expo**: `expo.name`, `expo.ios.bundleIdentifier`, `expo.android.package`.
- **Flutter**: the `MaterialApp` or `CupertinoApp` `title`, and the native ids as above.
- **fastlane**: `fastlane/metadata/<locale>/name.txt` is the name as the App Store shows it.

## What it does

Best sources first:

1. `fastlane/metadata/en-US/description.txt`, `subtitle.txt`, `promotional_text.txt`, `keywords.txt`
2. `fastlane/metadata/android/en-US/full_description.txt`, `short_description.txt`, `title.txt`
3. The live App Store listing (below)
4. `README.md`, docs, marketing site copy in the repo
5. The code: main navigation, feature folders, model names

Write two to four sentences in plain words: who it is for, the problem, the main thing it does, and
what is different about it. No hype and no claims you cannot see in the product.

## App Store link

With the bundle id:

```bash
curl -s "https://itunes.apple.com/lookup?bundleId=<bundle id>" | python3 -c "import json,sys; r=json.load(sys.stdin)['results']; print(r[0]['trackViewUrl'] if r else 'not found')"
```

Not found can mean unpublished or not in the US store; try `&country=gb` or the country the app
launched in. soggyhotdog takes App Store links only. For an Android-only app, rely on `what_it_does`.

## Brand colors

Up to five, as `#rrggbb`, primary first. Skip grays, black, white and system colors.

- **iOS**: `**/Assets.xcassets/AccentColor.colorset/Contents.json` and other `*.colorset` folders.
  Components are `0` to `1` floats (multiply by 255) or `0xRR` hex strings. SwiftUI code may use
  `Color(red:green:blue:)` or named asset colors.
- **Android**: `res/values/colors.xml` (`colorPrimary`, brand-named colors), Compose
  `ui/theme/Color.kt` (`Color(0xFFRRGGBB)` means `#RRGGBB`), `themes.xml`.
- **Flutter**: `ColorScheme.fromSeed(seedColor: Color(0xFF...))`, `primaryColor`, a theme file.
- **React Native, Expo**: theme or tokens files, `tailwind.config.js` colors, `app.json` `primaryColor`.

If nothing is clear, leave colors out; soggyhotdog reads them off the screenshots.

## Languages

- **iOS**: `*.lproj` folders, or the languages in `Localizable.xcstrings`.
- **Android**: `res/values-<lang>/strings.xml`.
- **Flutter**: `lib/l10n/*.arb`. **Expo, React Native**: the i18n resource folder.
- **Store**: `fastlane/metadata/<locale>/` folders.

soggyhotdog makes English (`EN`), German (`DE`), French (`FR`), Spanish (`ES`), Japanese (`JA`) and
Brazilian Portuguese (`PT-BR`). Offer only the ones the app ships in.

## iPad

Supported when `TARGETED_DEVICE_FAMILY` in `project.pbxproj` includes `2` (for example `"1,2"`), or
Expo has `ios.supportsTablet: true`. If the app does not support iPad, do not make iPad images.
