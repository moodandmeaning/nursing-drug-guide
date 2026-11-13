# Clinical scenario bank (Study mode)

Hand-written, tap-to-answer ward questions with EN/HE explanations. Target ~150 (done: 165 in batches 1-5); extra batches 6-8 added on request.
Each batch is a JS array in `tools/data/scenariosN.js` (format documented at the top of `scenarios1.js`);
merge all batches into `index.html` with:

    python tools/merge-scenarios.py

Rules: no free typing (mc / sata / tf / order only); every `drugs` entry must be an exact `genericEn`
from MEDS; facts must agree with that drug's own card; Hebrew uses ״ (gershayim) in abbreviations.

| Batch | Theme | Status |
|---|---|---|
| 1 | Hold/give parameters, high-alert drugs, antidotes, key monitoring | [x] 32 items |
| 2 | Electrolytes, IV fluids & diuretics (K, Na, Mg, Ca; loop/thiazide/K-sparing) | [x] 32 items |
| 3 | Anticoagulation & bleeding (DOACs, LMWH, antiplatelets, thrombolytics, iron, ESAs) | [x] 33 items |
| 4 | Antibiotics, antivirals & antifungals: allergy, sepsis timing, levels, C. diff, interactions | [x] 34 items |
| 5 | Diabetes, steroids, thyroid; pain & sedation; psych & neuro drug safety | [x] 34 items |
| 6 | Cardiac & vasoactive: pressors, arrest/bradycardia, antiarrhythmics, hypertensive emergency, CV teaching | [x] 32 items |
| 7 | Respiratory: inhalers, asthma/COPD, steroids, theophylline, antihistamines, smoking cessation | [x] 31 items |
| 8 | GI: PPIs, antiemetics, laxatives, bowel prep, liver (lactulose, rifaximin, terlipressin), IBD, tube meds | [x] 32 items |
| 9 | Oncology, immunology & transplant: cytotoxic safety, vesicants, neutropenia, TLS, methotrexate, biologics, tacrolimus | [x] 32 items |
