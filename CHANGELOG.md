# Changelog

All notable changes to this mod are documented here.

## [Unreleased] — 2026-09-13

- Detached the local repository, preserving the existing GitHub history.
- Added the required unofficial notices and final GitHub source link.
- Replaced the upstream showcase with a generated colony illustration and added the penguin mascot icon. Original artwork and prompts are retained under Art/.
- Added reproducible presentation tooling and functional validation scenarios.
- Final in-game validation remains pending.

## [1.0.0] — 2026-09-06

First release. Port of Peso penguin's **the Penguins mod** to RimWorld 1.6.

### Fixed

- `emperor_penguin`, `king_penguin`: `<wildness>0.15</wildness>` under `<race>` replaced by
  `<Wildness>0.15</Wildness>` under `<statBases>`. Wildness stopped being a field of
  `RaceProperties` and became a `StatDef`; the old element matches no field, so the loader logged
  one line and carried on with it unset. Unset is the stat's `defaultBaseValue` of `-1`, clamped
  by `StatWorker` to its `minValue` of `0` — so both penguins were coming out at wildness 0, as
  tame as the tamest animal in the game, when they had asked for 0.15.
- `Items_Resource_Eggs.xml`: the mod's own `EggBase`, `EggUnfertBase` and `EggFertBase` abstract
  defs removed or renamed. Those are the names Core uses for the abstract parents of every egg in
  the game, and `XmlInheritance.GetBestParentFor` resolves a `ParentName` to the node from the
  highest-loading mod at or below the def asking for it — so **every mod loaded after this one**
  was inheriting these copies instead of Core's. They were not faithful copies: `EggFertBase` set
  `CompProperties_TemperatureRuinable` to −30 °C/+10 °C where Core's is 0 °C/+50 °C, so any other
  mod's fertilized eggs would silently have been ruined by room temperature. `EggBase` and
  `EggUnfertBase` changed nothing and are gone; the cold range is kept as `Penguins_EggFertBase`,
  parented on Core's `EggBase`.
- `Patches/GiddyUpPatch.xml`: rewritten for Giddy-Up 2. It had never fired, in any version, for
  three separate reasons — its xpath asked for a `ThingDef` named `King_penguin` when the def is
  `king_penguin` and `defName`s are case-sensitive; its `PatchOperationFindMod` guard named
  `Giddy-up! Core`, and `ModLister.HasActiveModWithName` compares display names exactly; and it
  added a mod extension of class `GiddyUpCore.DrawingOffsetPatch`, which the 1.6 assembly no
  longer defines. It was also on the wrong animal: `GiddyUp.Setup` makes an animal mountable by
  default at `race.baseBodySize > 1.2f`, which is the emperor at 1.35 and never the king at 0.35.
  It now targets `emperor_penguin` with a `GiddyUp.DrawingOffset`, guarded on
  `Defs/ConceptDef[defName="GUC_Animal_Handling"]` rather than on a display name.
- `Textures/.../emperor_penguinPack.png` renamed to `emperor_penguinPack_east.png`. It is the east
  view of the pack, shipped with no facing suffix; `Graphic_Multi.Init` reads a suffix-less file
  only when all four facings are missing, so with `_north` present it never loaded, and the pack
  seen from either side was drawn using the view of its back.
- `king_penguin`: label `king penguin penguin` corrected to `king penguin`.
- `king_penguinUnfertilized`, `king_penguinFertilized`: labels carried the raw `defName` —
  `king_penguin egg (unfert.)` — and now read `king penguin egg (unfert.)`. The emperor's were
  already correct.

### Removed

- `Sounds/Pawns/Penguin/*.ogg` (four files) and `Defs/SoundDefs/Pawn_Animal_Penguin.xml` (four
  `SoundDef`s: `AEXP_Pawn_Penguin_Angry`, `_Call`, `_Death`, `_Wounded`). `AEXP_` is **Vanilla
  Animals Expanded**'s prefix, the four audio files are byte-identical to VAE's at the same
  relative path, and the `defName`s are VAE's own. VAE is alive, declares 1.6, and its Steam page
  states **CC BY-NC-ND 4.0** — a named No-Derivatives licence, which is the one case where this
  repository does not republish. Removing them also ends a duplicate-`defName` conflict with VAE
  and a shared sound-content path.
- `About/ModIcon.png`, a 64 × 64 crop of the mod's own south-facing emperor penguin scaled to
  128 px, added earlier in this same unreleased version. An icon cut from the source mod's art
  makes the upstream author's work carry the port's identity, and the icon is the one file of a
  port that is supposed to speak for the port rather than for the mod it carries. The mod ships
  without one; RimWorld does not require it. `Art/Make-ModIcon.ps1` is kept.
- `About/PublishedFileId.txt`: it names Peso penguin's Workshop item.

### Changed

- The four life-stage sound slots on each penguin now point at Core's own waterfowl voices,
  sized to the bird: `Pawn_Duck_*` for the king penguin, `Pawn_Goose_*` for the emperor. Both
  sets are in Core, so this adds no dependency.
- `packageId` changed from `Pesopenguin.thePenguinsmod` to `nelim.penguins`.
- `<supportedVersions>` set to 1.6.

### Added

- `Languages/French/`, 48 keys. Both species are *manchots*, not *pingouins* — the flightless
  southern birds are manchots in French and both of these are *Aptenodytes*. Life stages are keyed
  by index, `lifeStages.0.label` and so on, which is how the game's own French keys the cassowary
  and the emu: these life stages carry no label of their own to key by.
- `<incompatibleWith>Pesopenguin.thePenguinsmod</incompatibleWith>`: the `defName`s are unchanged,
  so the two mods cannot load together.

### Unchanged

- Every stat, tool, life stage, draw size, biome weight, egg interval, hatch time, trade tag and
  market value. The balance was not touched anywhere.
- The fertilized eggs' −30 °C/+10 °C safe range, which was the author's deliberate change to
  Core's 0 °C/+50 °C and the only part of their egg bases worth keeping.
- All eight `defName`s, so a save moves between the two mods without losing a bird. Checked
  against Core, every DLC, every subscribed Workshop mod and this repository: nothing else defines
  any of them.
- Every texture, byte for byte, and `About/Preview.png`, Peso penguin's own.
- `Dessicated_Penguin__south.png`, the dead duplicate. Two underscores, so it cannot load, and it
  is byte-identical to `Dessicated_Penguin_east.png`, so nothing is lost. Renaming it would not
  add a view; it would turn `ShouldDrawRotated` off for the corpse, because a distinct south
  texture breaks the `MatEast == MatNorth` equality that currently lets a dead penguin lie down.
- The emperor penguin's `butcherBodyPart`, which yields a `ComponentIndustrial` from its head, and
  its inert single-entry `alternateGraphics`. Both are odd and both are the author's.
