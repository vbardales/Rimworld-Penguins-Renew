# Functional scenarios

Written 2026-10-14 for version 1.0.1. Values are read from `Mod/Defs/` and `Mod/Patches/`, not from the README.
All scenarios are **in-game** and run at `playTests`; none has run yet. "Optional" scenarios need the named mod
loaded. Language scenarios run once in English and once in French.

| # | Behaviour | Preconditions | Actions | Expected result |
|---|---|---|---|---|
| 1 | Both species exist | Mod loaded, new game, dev mode | Open the Spawn tool, search `penguin` | `king_penguin` and `emperor_penguin` spawn as animals; no red error in the log about either def |
| 2 | King penguin stats | Scenario 1 | Inspect a spawned king penguin | Body size 0.35, market value 260, carnivore, comfortable -65 C to 15 C, trainability None, herd animal, lifespan 30 years |
| 3 | Emperor penguin stats | Scenario 1 | Inspect a spawned emperor penguin | Body size 1.35, market value 875, carnivore, pack animal, trainability Advanced, lifespan 50 years |
| 4 | Wildness is 0.15 | Scenario 1 | Open the animal's stat page, read Wildness; try taming a wild one | Both read 0.15 (not 0); taming takes real attempts and a tamed animal can revert to the wild |
| 5 | Wild spawning | New game on a sea ice map, then a tundra map | Wait or use Spawn/Debug "Spawn wild animal" for the biome | Wild groups of either species appear on sea ice, ice sheet, tundra, boreal forest and cold bog; none on a temperate map |
| 6 | Eggs, king penguin | A tame female king penguin with a male, in a pen | Wait for laying (12 days) | A king penguin egg appears; fertilized egg hatches in 5 days into a king penguin |
| 7 | Eggs, emperor penguin | Same with emperor penguins | Wait for laying (20 days) | An emperor penguin egg appears; fertilized egg hatches in 15 days into an emperor penguin |
| 8 | Cold-weather egg tolerance | A fertilized penguin egg, then a chicken egg for comparison | Hold both at -20 C, then at 20 C | The penguin egg is safe from -30 C to 10 C (spoils at 20 C); chicken egg keeps the vanilla range, so other mods' eggs are unchanged |
| 9 | Nuzzling | Two tame king penguins and a colonist | Observe | King penguins nuzzle colonists (about every 12 hours on average); emperors do not |
| 10 | Training | A tame emperor penguin, then a tame king penguin | Open the training tab | Emperor offers training up to Advanced; king offers none |
| 11 | Pack rendering | A tame emperor penguin carrying items in a caravan or hauling | Rotate the view through north, east, south, west | Pack textures show on all four facings; side view is the east texture (no missing-texture square) |
| 12 | Sounds | Both species, close camera | Wound one; listen to calls | King penguin uses the base game duck call and wound sound, emperor the goose ones; no sound from another mod is needed |
| 13 | Language, English | Game language English | Read labels, descriptions, tool names, eggs, life stages | Readable English, no raw keys or underscores; "king penguin" not "king penguin penguin" |
| 14 | Language, French | Game language French | Same | Defs show their French names (manchot royal, manchot empereur), eggs, tools and life stages; no English fallback for the 48 injected entries |
| 15 | Existing save | A save made without the mod | Add the mod, load the save | Loads without errors; wild penguins can appear in a cold biome when new groups spawn |
| 16 | Mod removal warning | A colony holding a penguin | Read the README / description | Content-mod removal warning is present (removing the mod destroys existing penguins) |
| 17 | Giddy-Up 2 present (optional) | Giddy-Up 2 for 1.6 loaded | Mount a tamed emperor penguin | A rider sits on the emperor with the offsets of `Patches/GiddyUpPatch.xml` in all four facings; log shows no error; the king penguin is not mountable |
| 18 | Giddy-Up 2 absent (optional) | Giddy-Up not loaded | Load the game | No log line from the penguin patch and the emperor has no drawing-offset extension |
| 19 | ADS 2 present (optional) | A Dog Said... Animal Prosthetics 2 loaded after this mod | Open the health tab of a penguin, list surgeries | Both species offer ADS 2's medieval replacement and simple prosthetic surgeries (categories 1 and 2); bionics are not offered |
| 20 | ADS 2 absent (optional) | ADS 2 not loaded | Load the game | No log line from `Compat_ADogSaidAnimalProsthetics2.xml` |
| 21 | Incompatibility | Original Penguins mod (`Pesopenguin.thePenguinsmod`) and this mod both active | Open the mod list | The game flags the conflict declared in `About.xml` |
| 22 | Settings | Mod options menu, Main buttons bar | Look for a Penguins entry | None: no settings page and no hidden shortcut exist (`settings_audit: not_applicable`) |
| 23 | Clean log | Any of the above | Read `Player.log` after a new game and a load | No error or exception mentioning `penguin`, `king_penguin`, `emperor_penguin` or this mod |

Automated, out of game, current files: `Check-XmlFields`, `Check-DefRefs` (with and without DLC data),
`Check-DefInjected`, `Check-ConfigErrors`, `Check-TypeRefs`. They prove the XML maps to real fields and references,
not behaviour; scenarios 1-23 do that.

## Playtest verdicts, 2026-10-17

Played by Pickle tickets (a session never launches the game). Revisions: `5f90ff4` initial pass, `d7d4ef6` for the log re-read. Evidence in `Tests/Pickle/Evidence/` (gitignored); one line per run in `docs/runs/history.md`.

| # | Verdict | Basis |
| --- | --- | --- |
| 1 | played, green | `01-defs`: both races, both kinds, four eggs exist, no error |
| 2, 3 | not applicable | stats are values written in XML, proved by `Check-XmlFields` and `Check-ConfigErrors`; a scenario would repeat them (`Tests/Pickle/README.md`) |
| 4 | rewritten after a red run, ticket 20261018-181952-578-b645 pending | `06-wildness-and-pack`: effective Wildness of both adults is 0.15 (taming attempts not played); first run failed because the pawn stat step reads player pawns only |
| 5 | played, green | `01-defs`: the five cold biomes list both penguins |
| 6, 7, 8, 9, 10 | not applicable | laying, hatching, egg temperature, nuzzling and training are vanilla comps that the mod only gives numbers to; the numbers are offline-checked |
| 11 | played, green; owner accepted the art, 2026-10-18 | the three pack textures are shipped and the pack is drawn on four facings (straps visible facing South on an enlarged capture); the sack hangs behind the back, partly outside the body, and Virginie keeps the original author's art as is |
| 12 | not applicable | the mod ships no audio: it names vanilla duck and goose sound defs, resolved by `Check-DefRefs` |
| 13, 14 | played, green | `02-visuals` language scenarios in English and French |
| 15 | not applicable | loading a save is the game's own behaviour (AUDIT.md, "On ne teste pas le jeu"); the save and reload of `03-persistence` is green |
| 16 | read, green | README.md, section "What the mod does": "Content mod: removing it mid-save destroys any penguin already in the colony." The Steam description is written at `writeDocs` |
| 17 | unverified | no Giddy-Up 2 for 1.6 installed |
| 18, 20 | played, green | passes without optional mods: no log line from either patch |
| 19 | played, green | pass 2: both penguins offered categories 1 and 2, not 3 |
| 21 | played, green | pass 3: both mods load, the original's wildness error is the documented symptom |
| 22 | not applicable | no settings, verified in the sources |
| 23 | played, green | `Player.log` of `d7d4ef6`: no error of this mod |

The `@review` captures of `02-visuals` taken on `5f90ff4` proved nothing (the emperor a dark speck at default zoom, the chick not in frame): the scenarios now centre the camera on the animal at root size 6 and are replayed.
