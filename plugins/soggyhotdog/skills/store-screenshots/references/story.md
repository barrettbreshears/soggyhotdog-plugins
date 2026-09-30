# Choosing the screens and writing the words

A listing is read in about three seconds, mostly from the first two or three images in search
results. Each image makes one point, and the set tells one story.

## How many, and in what order

Five to eight images. The App Store takes up to ten, Google Play up to eight phone screenshots, but
a tight set beats a long one.

1. **The payoff.** The screen where the app delivers its main value, full of believable content.
   This image alone should say what the app is for.
2. **How it works.** The core feature that produces that payoff.
3. **What is different.** The thing competitors do not do, or do worse.
4. **Depth.** Secondary features, personalization, the power-user view.
5. **Reach.** Widgets, watch, sync, sharing, integrations, if the app has them.
6. **Trust or close** (optional). Privacy, offline, no account needed: things that are true of the
   product. A words-only page (`add_words_page`) works well here.

Leave out: splash screens, login and sign-up, onboarding carousels, settings, permission prompts,
empty states and paywalls. Avoid two images of nearly the same screen.

## Headlines

Up to 60 characters is the hard limit; aim for three to six words, about 30 characters, because they
have to read at thumbnail size.

- **Say the benefit, not the feature.** "Plan a week of meals in minutes", not "AI Meal Planner".
- **Start with a verb or the outcome.** Track, plan, find, never miss, all in one place.
- **Use the words the app's users use**, not internal names.
- **Be specific.** "Every allergen flagged before you cook" beats "Eat safely".
- **One voice across the set:** the same case (sentence case is the safe default), the same
  punctuation (no trailing periods), the same person.
- **Nothing the product cannot back up.** No ratings, awards, "#1", user counts, prices, or "free"
  unless it is. The stores reject these, and soggyhotdog is told not to invent them either.

## Supporting lines

Optional, up to 90 characters. Use one when the headline needs the how or the proof ("Scan a label
and see what is safe for your whole family"). Skip it when the headline says it all; a set where
every image has two lines reads as clutter.

## Using the ideas

`get_project` gives each page headline and supporting-line ideas written from its screen. They are a
good starting point, especially for what each screen shows. Rewrite them to the app's own voice, make
them consistent across the set, and check each against the rules above.

## Other languages

Write the originals in the listing's main language. `make_sizes_and_languages` translates the words
for you. If the repo already has marketing copy in a language (`fastlane/metadata/<locale>/`), use its
terms with `set_translations` before making that language, so the images match the listing text.
