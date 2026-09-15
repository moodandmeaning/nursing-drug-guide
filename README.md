# Bilingual Nursing Drug Guide

A single-page, searchable medication reference for nursing students, with every entry
in **English and Hebrew** side by side. Installable as an app on iOS and Android.

**Live app:** https://moodandmeaning.github.io/nursing-drug-guide/

## Install on your phone (works offline after the first open)

- **iPhone / iPad (Safari):** open the live app link, tap the **Share** button, then
  **Add to Home Screen**. It gets an app icon and opens full-screen with no browser bars.
- **Android (Chrome):** open the link, then **Install app** from the menu (or the prompt).
- The layout is locked to a fixed size (no accidental pinch/double-tap zoom) so it behaves
  like a native app once installed.

## What's in it

`index.html` is a self-contained web page (no build step, no server). Open it in any
browser, or host it anywhere that serves static files. `manifest.webmanifest` and
`sw.js` make it an installable, offline-capable Progressive Web App.

- **431 medications** across 21 drug classes (cardiovascular, emergency/vasoactive,
  diuretics, anticoagulants, endocrine/diabetes, respiratory, GI, pain & nervous
  system, psychiatric, antibiotics, antivirals/antifungals, immunosuppressants,
  chemotherapy, hematology, musculoskeletal, genitourinary, eye/skin/topical,
  antidotes, vitamins, anesthesia, fluids & electrolytes).
- Each entry, in both languages: generic and brand names (Israeli brand names where
  they differ — e.g. furosemide is **Fusid**, not Lasix), route(s) of administration,
  drug class (insulins and other diabetes drugs note their acting duration), mechanism
  of action, indications, contraindications, electrolyte changes, side effects, nursing
  monitoring, patient teaching (what to tell the patient), and — where one exists —
  the antidote / reversal agent. About a third of drugs also carry a memory trick
  (wordplay, an acronym, a nickname) shown right under the brand names — added only
  where a genuinely memorable one exists, not forced onto every entry. Antibiotics also
  state their **Gram coverage** (Gram-positive / Gram-negative / broad spectrum, with
  standard qualifiers like MRSA or Pseudomonas where relevant).
- Search bar (matches name, brand, or class in either language; press `/` to focus it).
  It also recognizes **diagnoses** (the same ~156-entry curated list used in Patients
  mode, abbreviation-aware) — typing "SVT" or "congestive heart failure" surfaces
  medications relevant to that diagnosis (by category) alongside any literal name match,
  with a small note confirming which diagnosis it matched. When a diagnosis match is
  active, results are grouped under **First-line / Second-line / Third-line** headings
  (clinical priority per diagnosis) before the usual class headings underneath each one;
  a plain name/class search shows the usual single class-grouped list.
- **Category filter** (the 21 body-system groups, including a **★ Starred** option and a
  separate, independent **🕑 Review Later** option — star and review-later are two
  unrelated lists, a drug can be in either, both, or neither), plus a live result count.
  Within the filtered list, drugs are grouped under scrollable **class headings** (e.g.
  "Beta blocker", "Loop diuretic" — ~150 specific classes) instead of one flat
  alphabetical list, so browsing reads like a textbook organized by topic; a specific
  class like "beta blocker" is also always reachable by typing it into the search bar.
  Within each heading, drugs are ordered by clinical commonality (common, first-line
  drugs first), not alphabetically.
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
- **Patients mode** (toggle at the top, for clinicals): open a tab per patient,
  any number of them, and track each one's diagnoses and medications
  independently — the same medication can be added to several patients at
  once. Diagnoses are picked from a curated bilingual list of ~156 common
  clinical diagnoses (search-as-you-type, and abbreviation-aware — typing
  "CHF", "T2DM", "UTI", etc. finds the matching diagnosis) or typed freely if
  not on it. Each diagnosis chip gets its own **℞ dropdown**, scrollable,
  listing every medication in that diagnosis's relevant drug categories (not
  a clinical guideline — the full medication search is always there too for
  anything else) — add every diagnosis first, then go back and open each
  one's dropdown to pick its medications; the dropdown stays open so you can
  pick several in a row. This dropdown and Browse's diagnosis search are
  ordered by **line of treatment** (first-line drugs before second-/third-line,
  with headings marking each group), with clinical commonality as the
  tiebreaker; Browse mode's plain list and the general medication search are
  ordered by clinical commonality alone (common, first-line drugs first)
  rather than alphabetically. Every drug card also gets a quick **"+"**
  button to add it straight to a patient without leaving Browse mode. When a
  medication has more than one route of administration, picking it for a
  patient shows a route dropdown so you can record how *that* patient is
  getting it. Each medication on a patient can also carry an optional
  free-text note (why they're getting it) — hidden by default as a small
  "+ Add note" link, shown in smaller text than the drug name once you write
  one, tap it again to edit. Everything is saved on the device only (no
  accounts, no server) — a **Share** button per patient generates a link that
  imports that patient's data (including any chosen route and notes) into
  the app on any other device, for handing off to a classmate or moving
  between your own devices.
- **Missing medication log** (toggle at the top): if a drug you need isn't in
  the guide yet, log its name (plus an optional note) here so it can be added
  later. Saved on the device only; a **Copy list** button exports everything
  as plain text to paste elsewhere.
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
list is the `CATS` array just above it. Just below `CATS` are four more lookups:
`DIAGNOSES` (the curated diagnosis list), `DIAGNOSIS_ABBREVS` (abbreviation → full-phrase
matches for the diagnosis search), `DIAGNOSIS_CATS` (diagnosis id → relevant `CATS`
category ids, powering each diagnosis's suggested-medications dropdown — give any new
diagnosis an entry here or it just won't suggest anything), `DIAGNOSIS_LINES`
(diagnosis id → `{ category: line }`, tagging each of that diagnosis's `DIAGNOSIS_CATS`
categories 1/2/3 for first-/second-/third-line — a category left untagged quietly
defaults to line 2 via `treatmentLine()`; drives the line-of-treatment ordering above),
`MED_FREQ` (generic name →
commonality tier, 1 = very common/first-line, 3 = less common/specialized, no entry =
tier 2 — drives the ordering of Browse mode, the diagnosis dropdowns, and the Patients-mode
medication search; it's a judgment call, not real prescribing data), and `GRAM_COVERAGE`
(generic name → [English, Hebrew] Gram-coverage text, antibiotics only — objective
microbiology, not a judgment call).
