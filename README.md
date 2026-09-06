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
- Each entry, in both languages: generic and brand names, drug class (insulins and
  other diabetes drugs note their acting duration), mechanism of action, indications,
  contraindications, electrolyte changes, side effects, nursing monitoring, and —
  where one exists — the antidote / reversal agent.
- Search bar (matches name, brand, or class in either language; press `/` to focus it).
- Drug-class filter chips and a live result count.
- Light/dark theme toggle. Hebrew renders right-to-left throughout.
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
