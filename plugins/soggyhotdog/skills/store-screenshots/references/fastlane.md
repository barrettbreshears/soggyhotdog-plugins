# Delivering into fastlane

`get_downloads` with `layout: fastlane` returns a zip laid out the way fastlane reads it:

```
screenshots/en-US/iphone-6-9_01_home.png        App Store, read by deliver
screenshots/en-US/ipad-13_01_home.png           deliver tells iPhone from iPad by pixel size
screenshots/ja/iphone-6-9_01_home.png           deliver calls Japanese "ja"
metadata/android/en-US/images/phoneScreenshots/01_home.png   Google Play, read by supply
metadata/android/ja-JP/images/phoneScreenshots/01_home.png   supply calls it "ja-JP"
```

Unzipped into the project's `fastlane/` folder, both tools find them. Both upload in filename order,
which is shipping order.

## Before unzipping

deliver uploads every image in a locale folder, so leftovers get uploaded too. Check first:

```bash
ls fastlane/screenshots/*/ fastlane/metadata/android/*/images/phoneScreenshots/ 2>/dev/null
```

If there are screenshots there, tell the user and, with their okay, move them aside rather than
deleting them:

```bash
mv fastlane/screenshots "fastlane/screenshots-before-$(date +%Y-%m-%d)"
```

For Android, move each `phoneScreenshots` folder the same way. Leave everything else in `metadata/`
(descriptions, titles, other images) alone.

## Download and unzip

Use the `curl` and `unzip` commands `get_downloads` returns. The links last an hour; ask again if one
has expired. Then check the result:

```bash
find fastlane/screenshots fastlane/metadata/android -name '*.png' | sort
```

## Uploading (only when the user asks)

```bash
bundle exec fastlane deliver --skip_binary_upload --skip_metadata --overwrite_screenshots
bundle exec fastlane supply --skip_upload_apk --skip_upload_aab --skip_upload_metadata --skip_upload_changelogs --skip_upload_images
```

Drop `bundle exec` if the project has no `Gemfile`. If the project has its own lane for screenshots
in `fastlane/Fastfile`, prefer that.

## No fastlane

Use the default layout, unzip into `store-screenshots/` at the repository root, and tell the user
each folder is one device and language, ready to drag into App Store Connect's media manager or the
Play Console's store listing.
