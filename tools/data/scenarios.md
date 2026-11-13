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
| 10 | Anesthesia & toxicology: sedation/induction, NMBs and reversal, malignant hyperthermia, LAST, poisonings and antidotes | [x] 33 items |
| 11 | Obstetric, urologic & musculoskeletal: oxytocin, PPH uterotonics, tocolysis, Rh IG, bladder/prostate drugs, gout, osteoporosis | [x] 31 items |
| 12 | Eye & skin, antiseptics, topical anaesthetics, vitamins (thiamine, B12, folate, vitamin D/K, refeeding) | [x] 31 items |
| 13 | Psychiatric: antidepressants, antipsychotics & depots, tardive dyskinesia, anxiolytics, hypnotics, alcohol/opioid use disorder, ADHD (all 48 psych drugs now covered) | [x] 33 items |
| 14 | Pain & neurology: NSAIDs, opioid combinations, buprenorphine, migraine, antiseizure drugs, muscle relaxants, dementia, Parkinson, myasthenia, ADHD, vertigo, cannabis (all 65 covered) | [x] 39 items |
| 15 | Cardiovascular, vasoactive, diuretic, anticoagulant & hematology remainder: CCBs, antiarrhythmics, beta blockers, RAAS, nitrates, lipids, HF drugs, GP IIb/IIIa, TPO agonists, combos | [x] 45 items |
| 16 | Endocrine remainder: insulin types and mixes, DPP-4, SGLT2, GLP-1/GIP, sulfonylureas, acarbose, steroids, hormones and contraception, thyroid, pituitary, calcium/bone (all 60 covered) | [x] 35 items |
| 17 | Antibacterial remainder: macrolides, penicillins/cephalosporins, carbapenems, aztreonam, aminoglycosides, colistin, teicoplanin, tigecycline, TB, quinolones, fosfomycin, fusidic acid (all 60 covered) | [x] 30 items |
| 18 | Antivirals, antifungals & antiparasitics remainder: HIV, hepatitis B/C, herpes/CMV, influenza, COVID-19, azoles, echinocandins, terbinafine, ivermectin, albendazole (all 33 covered) | [x] 27 items |
