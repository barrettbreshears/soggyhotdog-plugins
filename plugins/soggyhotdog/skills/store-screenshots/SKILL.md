---
name: store-screenshots
description: Make App Store and Google Play screenshots for the mobile app in this repository with soggyhotdog. Use when the user asks for store screenshots, App Store or Play Store images, listing or marketing screenshots, or wants existing ones refreshed with new screens or translated. Reads the project to learn the app, gets clean raw screens, writes the headlines, makes and checks the images, and puts the finished files where fastlane expects them.
---

# Store screenshots with soggyhotdog

soggyhotdog designs and renders the images. Everything around it that needs the repository is your job:
understanding the app, getting great raw screens, writing sharp words, judging every result, and
delivering the files to the right place. Do the reading yourself; only ask the user what the project
cannot tell you.

## Ground rules

- **Credits are money.** Every image made costs one credit (changes and remakes too; failures are
  refunded). Before the first spend, call `get_account` and tell the user what the set will cost and
  what they have. One yes covers making the set and a reasonable number of fixes; ask again before
  anything bigger, and always before `make_sizes_and_languages` or `update_listing`.
- **Never upload to the stores** (fastlane `deliver` or `supply`, Transporter, App Store Connect,
  Play Console) unless the user explicitly asks.
- **Never overwrite screenshots already in the repo** without asking. Move old ones aside instead.
- **Demo data only** in captures: no real names, emails, messages, locations or anything personal.
- If a tool says the account's plan does not include agents, or that it is out of credits, stop and tell the user.
- `get_project` returns a `next` field. When unsure what to do, do that.

## 1. Connect

Call `get_account`. If the soggyhotdog tools are not available, the plugin's server is not signed
in: in Claude Code the user runs `/mcp`, chooses soggyhotdog and signs in; in Codex they sign in
from the plugin's page. Wait for them, then continue.

Call `list_projects`. If this app already has a project (same name), reuse it rather than starting
over, and skip to the step it is on.

## 2. Learn the app from the repository

Follow [references/project-context.md](references/project-context.md) to find:

- **Platform**: `ios`, `android` or `both`.
- **Name**, and the **bundle id or application id**.
- **What it does**: two to four plain sentences on who it is for, the problem, and the main thing it
  does. Store metadata first, then the README, then the code. This is what every headline is written
  from, so make it specific.
- **Brand colors**: up to five hex colors, primary first. Leave them out if nothing is clear; they are
  then read off the screenshots.
- **App Store link**, if the app is published.
- **Languages** the app ships in, and whether it supports **iPad**.

Tell the user in a few lines what you found and the look you propose, and let them correct it in one
reply.

## 3. Choose the look and create the project

Call `list_looks` and pick the one that suits the app's category and brand, or write
`look_description` in a sentence or two (colors, background, type, mood). If the user described a
look, use their words.

Call `create_project` with `what_it_does`, `name`, `platform`, `look` or `look_description`,
`brand_colors`, and `app_store_url` if there is one. If it reports that the App Store listing already
has screenshots, ask the user: keep that design and put today's screens into it (`update_listing`,
one credit per store image), or make a new set.

## 4. Get the raw screens

Raw means the app's own UI, full screen, portrait, from a real device or simulator: no frames, no
captions, no marketing images. In order of preference:

1. **Captures already in the repo.** Look in `fastlane/screenshots/`, `fastlane/metadata/android/*/images/`,
   `screenshots/`, `docs/`, and UI test or Maestro output. Check they are raw and full resolution.
2. **Capture fresh ones** with the capture-screenshots skill.
3. **Ask the user** for files.

Choose and order the screens with [references/story.md](references/story.md): usually five to eight,
strongest first. Name the files in shipping order (`01-home.png`, `02-plan.png`, ...).

Upload with `get_upload_link`, then run the `curl` it returns with every file in one request, in
order (up to ten). For iPad captures of the same pages, ask for a second link with
`form_factor: tablet` and send them in the same order; for a `both` project, Android captures go with
`form_factor: android`.

## 5. Write the words

Poll `get_project` every 15 to 20 seconds until every page has `screen_read: true` and headline
ideas, usually within a minute. Then write a headline and, where it helps, a supporting line for each
page, following [references/story.md](references/story.md). Use the ideas as raw material, not as
the answer. Save them all with one `set_words` call.

## 6. Make the set and check every image

Confirm the cost, then call `make_images`. The first page renders first and the rest follow in its
look. Poll `get_project` every 20 to 30 seconds until no page is `reading`, `waiting` or `making`.

Then call `view_image` for every page and check it hard:

- The headline and supporting line are spelled exactly as set, fully visible, and readable at
  thumbnail size.
- The app screen is the real one: sharp, not stretched, nothing invented or garbled on it.
- The device is right for the store (an iPhone for the App Store).
- Nothing important in the UI is covered.
- The pages look like one set.

Fix with `change_image`, one specific visual instruction at a time ("Make the background deep navy
so the white headline stands out", "Make the phone larger and move it lower"). A wording problem is
fixed with `set_words` and then `remake_image`. After two attempts at the same fix, show the user and
ask. If an earlier version was better, `choose_version` goes back to it for free.

Show the user the finished set (the `image.url` links from `get_project`, or describe each page)
and get their yes. Then call `approve_images`.

## 7. Sizes and languages (only if wanted)

Offer what fits the app: iPad (`ipad-13`) only if it supports iPad, Android (`pixel-9`) if it ships
on Google Play, and languages it is localized into (soggyhotdog makes `EN`, `DE`, `FR`, `ES`, `JA`
and `PT-BR`). Call `make_sizes_and_languages` without `confirm` for the price, get the user's yes, then
call it again with `confirm: true`. If the repo already has marketing copy in a language (for example
`fastlane/metadata/de-DE/`), use it for `set_translations` first so the headlines match the listing.

Poll `get_project` until nothing is being made.

## 8. Deliver the files

If the repo has a `fastlane/` folder, call `get_downloads` with `layout: fastlane` and follow
[references/fastlane.md](references/fastlane.md): check for existing screenshots, move them aside
with the user's okay, then download and unzip into `fastlane/`. Otherwise call `get_downloads` with
the default layout, download, and unzip into `store-screenshots/` at the repository root.

Finish with a short report: where the files are, how many, the credits used, and the command that
would upload them. Offer to run it; do not run it unasked.

## Later: updating a set

When the app's screens change, reuse the project. `get_upload_link` with a `page_id` replaces that
page's screen, and every image already made of it is updated for free. New pages go through the
normal upload and `make_images`.
