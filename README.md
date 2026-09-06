# Bilingual Nursing Drug Guide

A single-page, searchable medication reference for nursing students, with every entry
in **English and Hebrew** side by side. Installable as an app on iOS and Android.

**Live app:** https://moodandmeaning.github.io/nursing-drug-guide/

## Install on your phone (works offline after the first open)

- **iPhone / iPad (Safari):** open the live app link, tap the **Share** button, then
  **Add to Home Screen**. It gets an app icon and opens full-screen with no browser bars.
- **Android (Chrome):** open the link, then **Install app** from the menu (or the prompt).

## What's in it

`index.html` is a self-contained web page (no build step, no server). Open it in any
browser, or host it anywhere that serves static files. `manifest.webmanifest` and
`sw.js` make it an installable, offline-capable Progressive Web App.

- **371 medications** across 21 drug classes (cardiovascular, emergency/vasoactive,
  diuretics, anticoagulants, endocrine/diabetes, respiratory, GI, pain & nervous
  system, psychiatric, antibiotics, antivirals/antifungals, immunosuppressants,
  chemotherapy, hematology, musculoskeletal, genitourinary, eye/skin/topical,
  antidotes, vitamins, anesthesia, fluids & electrolytes).
- Each entry, in both languages: generic and brand names, route(s) of administration,
  drug class (insulins and other diabetes drugs note their acting duration), mechanism
  of action, indications, contraindications, electrolyte changes, side effects, nursing
  monitoring, and — where one exists — the antidote / reversal agent.
- Search bar (matches name, brand, or class in either language; press `/` to focus it).
- Drug-class filter dropdown (including a **★ Starred** option that shows only the
  drugs you've starred) and a live result count.
- **Display-language switch** (Both / EN / עברית): show every field in just one
  language while generic and brand names stay bilingual. The choice is saved on
  the device.
- **Study mode** (toggle at the top): an auto-graded spaced-repetition quiz built
  from the drug data. Every prompt is **one question, four options, one correct
  answer** — covering drug class, route of administration, indications,
  contraindications, electrolyte changes, monitoring, antidote, brand ↔ generic,
  and English ↔ Hebrew. For the
  longer topics the question asks for a single item ("Which is a contraindication
  to warfarin?") and the wrong options are real items from other drugs. Answer →
  see correct/wrong → Next; right answers are spaced out, wrong ones come back
  sooner (Leitner 5-box scheduler). A **Matching** format (tap-to-pair, 5 name
  cards at a time) is also available. Pick a deck (all, one drug class, or your
  own starred set — star drugs from any Browse card) and how many new cards per
  day. Progress, stars, and a day streak are saved on the device (offline, per
  browser). Keyboard: 1–4 to answer, Enter for Next.
- Light/dark theme toggle and the display-language switch. Hebrew renders
  right-to-left throughout.
- Fonts (Frank Ruhl Libre + Assistant) load from Google Fonts when online; everything
  else is embedded in the single file.

## Disclaimer

This is a **study aid**, not a clinical reference. Brand names and dosing conventions
vary by country. Always verify against a current drug reference and your facility's
protocol before administering any medication.

## Editing

All medication data lives in the `MEDS` array inside the `<script>` block near the
bottom of `index.html`. Each entry has matching `...En` / `...He` fields. The category
list is the `CATS` array just above it.
