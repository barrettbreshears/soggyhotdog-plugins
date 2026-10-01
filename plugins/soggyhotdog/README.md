# soggyhotdog

Make App Store and Google Play screenshots for the mobile app you are working on. Ask your agent for
store screenshots and it reads your project to learn what the app does, finds or captures clean raw
screens, writes the headlines, makes the set with [soggyhotdog](https://soggyhotdog.com), checks every
image, and puts the finished files where fastlane expects them.

You need a soggyhotdog account on a paid plan. Every image made, changed or remade uses one credit,
and the agent tells you what a step costs before it spends anything. It never uploads to the App Store
or Google Play unless you ask.

## How to use it

After installing, sign in to the soggyhotdog connection: in Claude Code run `/mcp` and choose
soggyhotdog; in Codex run `codex mcp login soggyhotdog`. Then ask for store screenshots in your own
words, or run the `store-screenshots` skill.

The plugin has two skills:

- **store-screenshots** does the whole job, start to finish.
- **capture-screenshots** captures clean raw screens from the iOS Simulator or an Android emulator.

## What it runs, sends and fetches

- **The soggyhotdog MCP server** at `https://soggyhotdog.com/mcp`, signed in with OAuth. It receives the
  tool calls the agent makes and nothing from your conversation.
- **Uploads**: the screenshots you choose are sent to `soggyhotdog.com` with `curl`, using a link that
  lasts an hour.
- **Downloads**: finished images are fetched with `curl` from `soggyhotdog.com` and from short-lived
  links on Cloudflare R2 (`r2.cloudflarestorage.com`).
- **App Store lookup**: the agent may read your app's public listing from `itunes.apple.com` to find
  its App Store link.
- **Local tools**, only with your approval: `xcrun simctl`, `xcodebuild`, `adb`, `emulator`, Gradle,
  Flutter, Expo or fastlane, to build the app, capture screens and place files in your project.

Nothing else leaves your machine. How soggyhotdog handles your data is in its
[Privacy Policy](https://soggyhotdog.com/privacy). Docs: [soggyhotdog.com/docs/agents](https://soggyhotdog.com/docs/agents).
Support: [support@soggyhotdog.com](mailto:support@soggyhotdog.com).
