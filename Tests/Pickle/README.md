# The Penguins mod Renew Pickle suite

Development only. Nothing under `Tests/` is part of the Workshop payload. Written 2026-10-15 at `writeTests[1.0.0]`.
**Nothing here has been run**: no scenario has an in-game result, and `STATUS.md` says so.

## Scope

The offline checks (`Check-XmlFields`, `Check-DefRefs`, `Check-DefInjected`, `Check-ConfigErrors`, `Check-TypeRefs`
of the protocols repository) own everything provable without a game: the XML fields, the references and parents,
the 48 French paths, the stat and balance values. A Pickle scenario that would only repeat one of those was not
written; the stats of `TEST_SCENARIOS.md` 2 and 3 are in that case.

Pickle is limited to what needs a running game: whether the mod loads without error, whether the defs that share a
name between a ThingDef and a PawnKindDef (`king_penguin`, `emperor_penguin`) resolve, what the game kept of the
biome lists, the labels each language actually draws, the animals drawn at each life stage, a save and reload, the
surgeries ADS 2 really offers, and the documented symptom beside the declared-incompatible original.

Because of the shared defNames, the suite uses only the typed `def ... of type ...` form. No local C# step is
written: every step is built in Pickle or a call into PickleTools (InspectTabs, DefFieldSteps, ScreenshotStudio).

## Passes

| Pass | Map | Features | Language | What it establishes |
| --- | --- | --- | --- | --- |
| 1. Without optional mods | `wsl-deps.sans-facultatifs.map` | `01`, `02`, `03` | English, then French | The mod stands alone: defs, biome lists, drawing at every life stage, labels, save and reload |
| 2. A Dog Said 2 | `wsl-deps.avec-ads2.map` | `05` | English | Both penguins are offered the categories 1 and 2 surgeries and not the bionic one, in the declared order |
| 3. The original mod | `wsl-deps.incompat-original.map` | `04` | English | The documented silent-override symptom still holds |

Pass 3 is replayed when the original changes, not at every release.

### Not written, and why

- **Giddy-Up 2** (`Patches/GiddyUpPatch.xml`, scenarios 17 and 18 of `TEST_SCENARIOS.md`): no Giddy-Up for 1.6 is in
  the Workshop folder (only the Owlchemist French pack, folders 1.4 and 1.5), the staging script stops on a mod it
  cannot find, and neither its package id nor the class `GiddyUp.DrawingOffset` is verified here. No map is written
  with a guessed id. The scenarios are written, in the Pass 4 of this table, once the mod is installed.
- **Nocturnal Animals, Dogs mate, Better Crossbreeding**: no patch exists for them (reasons in `STATUS.md`), so
  there is nothing to test.
- **Scenarios 4 and 11 (written 2026-10-17, `06-wildness-and-pack.feature`)**: 4 reads the effective Wildness stat of a
  spawned animal with Pickle's pawn stat step; 11 proves only that the three pack textures are shipped by the mod
  (TextureOwner). The pack drawn on the animal stays manual: no step puts items in an animal's inventory.
  Scenario 16 (README warning) has no Pickle step: a repository file is not game state; read by the session.
- **Eggs laid and hatched, nuzzling, training, the pack seen from four sides, sounds**: no shared step exists to
  observe them, and each would need a local C# step. They stay manual scenarios of `TEST_SCENARIOS.md` (the pack
  drawing of 11, 12, 6, 7, 9, 10) until a second mod needs the same step, at which point it moves to PickleTools. Unverified in `STATUS.md`.
- **Gallery captures**: written at `shootGallery`, in the Sanctuary, never here.

## Launching

From the collection root, once `scripts/Pickle-Status.ps1` says the machine is free, by filing a request with
`Submit-PickleRun.ps1` (see `PICKLE.md`), never by calling the launcher directly:

```powershell
-Mod PenguinsRenew -DepMap wsl-deps.sans-facultatifs.map -Filter 'the Penguins mod Renew - Pickle tests,!@french'  -Language English
-Mod PenguinsRenew -DepMap wsl-deps.sans-facultatifs.map -Filter 'the Penguins mod Renew - Pickle tests,!@english' -Language French
-Mod PenguinsRenew -DepMap wsl-deps.avec-ads2.map -Filter '05-animal-prosthetics' -Language English
-Mod PenguinsRenew -DepMap wsl-deps.incompat-original.map -Filter '04-incompatible-original' -Language English
```

Add `-EvidenceDir PenguinsRenew/Tests/Pickle/Evidence/<date>-<pass>-<language>` to each, so the report is copied
into the mod before the shared folder is overwritten. Do not run the Windows game, do not stage by hand, and do
not switch language inside a scenario. The scenarios use the `test-colony` fixture shipped with Pickle.
