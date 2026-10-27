---
mod: the Penguins mod Renew (unofficial)
packageId: nelim.penguins
repo: Rimworld-Penguins-Renew
remote: https://github.com/vbardales/Rimworld-Penguins-Renew.git
visibility: public
detached: yes
workflow_stage: playTests[1.0.0]
licence: silent
licence_at: "2026-09-13: source mod 3477589277 declares only 1.5, no licence in four places (files, About.xml, linked repository, Steam description); not an authorisation"
upstream_mod_remotes: N/A
settings_audit: not_applicable
localization: complete
translation_en: complete
translation_fr: complete
dependencies: none
workshop: 3811404080
published: unverified
tested_on: "2026-10-16 Pickle 1.6: initial pass at 5f90ff4 (EN, FR, ADS 2, original) green; 01-defs EN at d7d4ef6 green after the eggUnfertilizedDef fix"
remaining:
  - "2026-10-15: unverified: Giddy-Up 2 Pickle pass not written, no 1.6 Giddy-Up installed"
  - "2026-10-18: 06-wildness-and-pack: 9/9 green in substance. Ticket 2a85 at 6def4b5: 7/9, three pack textures shipped, four pack captures read (pack drawn on all four facings; the sack hangs behind the back, partly outside the body, Virginie keeps the original art; scenario 11 green), two wildness scenarios red from the pawn stat step. Fixed with the thing-at-cell step, ticket b645 green 2/2 (Tests/Pickle/Evidence/2026-10-18-wildness). Juvenile emperor drawn at 2.25 on her request (dc55fe4, code change: `code_review_sha` to redo at the end of playTests), checked by ticket 1766 (02-visuals EN facing South) green 7/7. No assertion of the drawn Pack texture (NPT did not write it). Run folder 2026-10-17-wildness-pack no longer exists (Inbox triaged 2026-10-19)"
  - "2026-10-14: unverified: Giddy-Up 2 optional integration class and guard (no 1.6 Giddy-Up installed)"
  - "2026-10-18: 02-visuals green 7/7 facing South at current code (now Tests/Pickle/Evidence/king-small-crops, run 20261019-231707-311-f468, 2026-10-23, 7/7; earlier red aaf1 was the unreachable size 6 and a missing `!@french` filter, not a mod defect). Six captures opened (8.d): adult emperor, juvenile emperor and adult king readable; emperor baby a small dot; king juvenile and king baby specks at whole-map zoom, drawing not judgeable, no close crop for king"
  - "2026-10-19: ticket 20261019-114915-495-1d82 (02-visuals king juvenile and baby, c32021b) ended exit 0 but 3 scenarios Skipped, no steps, no capture: proves nothing, run deleted. Skip cause: ticket filed without -DepMap, PickleTools not staged, @requires unmet. Refiled 20261019-231707-311-f468 (-DepMap wsl-deps.sans-facultatifs.map, filter 02-visuals,!@french, English): 7/7 green, exit 0 (2026-10-23). King crops read 2026-10-27 from the full-size originals: juvenile king is a ~8x14 px figure (dark back, white belly, orange-brown head patch), readable as a penguin but detail not judgeable; baby king not found at the juvenile cell, no crop. Zoom cannot go below root size 11. Virginie refused to accept it unjudged (2026-10-27): new paused scenario `::stands still` (02-visuals, animal held on its cell facing South, interface hidden), ticket 20261027-202228-328-1d05 filed, waiting RUN_DONE, evidence to Tests/Pickle/Inbox/king-still-crops; then crop from the originals and judge. Evidence/ holds seven folders, 1.0 MB; Inbox and Parked empty, no archive folder of this mod"
  - "2026-10-16: feature: gallery plan in PUBLICATION.md and shoot script Tests/Pickle/Mod/Pickle/Features/gallery-penguin-shore.feature written, not run (shootGallery). Unverified in game: hairstyle Princess, Apparel_Parka dye, ITab_Pawn_Health, cell (90, 140). No step for kneel or crouch (Nelim stands)"
code_review_sha: 2f517791c440fa451d4b7985fa8d5237f1062909
protocols_read_sha: 43dd90d4b7873c500347fba1be01275a48d5795b
updated: 2026-10-17
---
---

# the Penguins mod 1.6 (unofficial) — status

## ModIcon source trim — 2026-10-15

Badge mode run on owner's explicit request (2026-10-15): `Art/ModIcon-source.png` transparent border cropped in place, 1254x1254 to 1049x1071 (original stays in git, commit e387ad6). ModIcon.png, ModIcon.ico, Preview.png, Preview.ico, `Art/Gallery/0-preview.png` regenerated; Preview QA passes.

## Tests written — 2026-10-14

- Functional scenarios: `TEST_SCENARIOS.md`, 23 in-game scenarios (7.a), figures read from defs. None run.
- Automated and XML checks replayed at ae20da9 on current files, all exit 0: `Check-XmlFields` (6 files), `Check-DefRefs` (with and without Core data), `Check-DefInjected` (48 keys, 0 errors), `Check-ConfigErrors`, `Check-TypeRefs` (7.b, 7.c). No C# build or unit suite applies to source-free content mod; no artificial test created (7.e).
- Pickle suites (7.d), written 2026-10-15, not run: `Tests/Pickle/` (5 features, 11 scenario blocks, 3 passes: without optional mods in English and French, ADS 2, declared-incompatible original). Shared and PickleTools steps only, no local C#; `Check-Steps.ps1 -ModRoot PenguinsRenew` resolves all 85 step lines. Tested revision for 7.f: c16f12e35b357b8f27435ec020d3fe94c1787c1d. Not written, reasons in `Tests/Pickle/README.md`: Giddy-Up 2 (no 1.6 build installed), eggs laid and hatched, nuzzling, training, pack facings and sounds (no shared step, manual scenarios).
- Target version fixed at 1.0.0 (2026-10-14): no 1.0.0 ever released, no tag exists, former 1.0.1 label wrong; CHANGELOG merged into one `[1.0.0] — unreleased` section.

## Translation audit — 2026-10-14

Re-run at ae20da9: `Check-DefInjected.ps1` resolves 48 paths, 0 errors; `FRENCH_REVIEW.md` generated by `Make-FrenchReview.ps1`. New ADS 2 patch adds only defNames to lists, no player-facing text, so no key added. Sources: three Defs files, three French DefInjected files; English comes from Defs. Four French egg descriptions reworded (article, full sentences) on reviewer proposal of 2026-10-14; English `How it end up in rimworld. but nobody knows.` of emperor penguin left untouched: upstream text, no upstream to propose to, Virginie has not decided. French review (6.g): Virginie, 2026-10-14, relecture OK on FRENCH_REVIEW.md generated at 72bd674, including reworded egg descriptions; `translation_fr: complete`. Session never marks own French as reviewed. In-game display unverified until `playTests`.

## Dependencies and integrations — 2026-10-14

Verified in sources (XML and patches), revision at commit introducing this section.

- **Mandatory dependencies:** none. No DLC, no assembly, no LoadFolders. About.xml declares `incompatibleWith` `Pesopenguin.thePenguinsmod` and `loadBefore` `SamBucher.ADogSaidAnimalProsthetics2`.
- **Giddy-Up 2 (optional):** `Patches/GiddyUpPatch.xml`, guarded by `PatchOperationConditional` on `ConceptDef GUC_Animal_Handling`. No Giddy-Up for 1.6 installed here (only Owlchemist French pack, 1.4/1.5), so guard def and class `GiddyUp.DrawingOffset` unverified in this checkout.
- **A Dog Said... Animal Prosthetics 2 (optional, applied):** `Patches/Compat_ADogSaidAnimalProsthetics2.xml`, both penguins in ADS_Cat1 and ADS_Cat2 (analogues Duck, Goose, Emu, Ostrich, all in Cat1 and Cat2, none in Cat3). Read against 3238353862, folder 1.6.
- **Nocturnal Animals (not applied):** mod hand-lists defNames; its 1.6 bird patch names only Cassowary. Penguins stay diurnal like analogues Duck, Goose, Ostrich, which it does not list.
- **Dogs mate (not applied):** 1.6 groups cover Canidae, Felidae, Rodentia, Mammalia only, no bird group, so no group can hold penguin.
- **Better Crossbreeding (not applied):** king x emperor pairing declined by owner (Virginie, 2026-10-17): no hybrid race, no patch.
- DLC and `supportedVersions`: 1.6 only, no `LoadFolders.xml`.

## Historical audit

2026-09-13 audit (former vocabulary) kept in `docs/runs/2026-09-13-historical-audit.md`; dated evidence, superseded by sections above.

## Session state — 2026-10-16

Audit replayed to `playTests[1.0.0]`. Initial Pickle pass green at 5f90ff4, `eggUnfertilizedDef` defect fixed and verified at d7d4ef6, code review done (`code_review_sha`). Open: the 23 in-game scenarios of `TEST_SCENARIOS.md` and Giddy-Up 2. Session code `Pe`. Gallery plan and shoot script written for `shootGallery`, nothing captured.