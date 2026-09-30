# soggyhotdog for coding agents

Plugins for Claude Code and OpenAI Codex that make App Store and Google Play screenshots for the app
you are working on. Ask for store screenshots and your agent:

1. reads the project to learn what the app does, its name and brand colors,
2. finds raw screens in the repo, or captures clean ones from the iOS Simulator or an Android emulator,
3. writes the headlines,
4. makes the set with [soggyhotdog](https://soggyhotdog.com) and checks every image,
5. adds iPad, Android and other languages if you want them,
6. puts the files in `fastlane/`, ready for `deliver` and `supply`.

It needs a paid soggyhotdog plan. Every image made is one credit, and the agent tells you what a step
costs before it spends anything. It never uploads to the stores unless you ask.

## Claude Code

```
/plugin marketplace add barrettbreshears/soggyhotdog-plugins
/plugin install soggyhotdog@soggyhotdog
```

Then run `/mcp`, choose soggyhotdog, and sign in with your soggyhotdog account. Ask for store
screenshots, or run `/soggyhotdog:store-screenshots`.

## Codex

```
codex plugin marketplace add barrettbreshears/soggyhotdog-plugins
```

Then open Plugins in Codex, choose soggyhotdog from the soggyhotdog marketplace, install it and sign
in. Ask for store screenshots.

## Any other MCP client

Add `https://soggyhotdog.com/mcp` as a remote MCP server and sign in when asked. You get the tools
without the skills. See [soggyhotdog.com/agents](https://soggyhotdog.com/agents).

## What is inside

```
plugins/soggyhotdog/
  .claude-plugin/plugin.json      Claude Code manifest
  .codex-plugin/plugin.json       Codex manifest
  .mcp.json                       the soggyhotdog MCP server
  skills/store-screenshots/       the whole job, start to finish
  skills/capture-screenshots/     clean raw captures from a simulator or emulator
```

## License

MIT
