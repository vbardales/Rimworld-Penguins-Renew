# the Penguins mod 1.6

Port of **Peso penguin's the Penguins mod** to RimWorld 1.6.

**I am not the author of this mod.** The animals, the artwork and the balance are theirs — all I
did was the work needed to make it run on 1.6, repair what the port turned up, and write the
French. Credit goes to them; mistakes in the port are mine.

Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=3477589277 — posted 7 May
2025, declares 1.5 and nothing further, never updated. The page is still online; the mod is
abandoned, not withdrawn.

## What the mod does

Two penguins for the cold end of the world. Eight defs, ten textures and one optional patch — no
assembly, no dependency, no DLC, no research.

| | king penguin | emperor penguin |
|---|---|---|
| body size | 0.35 | 1.35 |
| market value | 260 | 875 |
| comfortable | −65 °C to 15 °C | −65 °C to 15 °C |
| food | carnivore | carnivore, and a predator up to prey size 1.0 |
| trainability | None | Advanced |
| wildness | 0.15 | 0.15 |
| social | herd animal, nuzzles every ~12 h | neither |
| eggs | one every 12 days, hatches in 5 | one every 20 days, hatches in 15 |
| life expectancy | 30 years | 50 years |
| pack animal | no | yes |
| traders | `AnimalCommon` | `AnimalUncommon` |

Both spawn wild on sea ice, ice sheet, tundra, boreal forest and cold bog — all five biomes still
exist in 1.6; Odyssey added biomes without removing any.

Their fertilized eggs are the cold-weather kind: safe from −30 °C to 10 °C, where a vanilla
chicken egg wants 0 °C to 50 °C. That was the author's own choice and it is kept.

Available in English and French.

Content mod: removing it mid-save destroys any penguin already in the colony.

## What changed in the 1.6 port

### Wildness became a stat, and here it mattered

Both defs declared this, inside `<race>`:

```xml
<wildness>0.15</wildness>
```

Wildness is no longer a field of `RaceProperties`; it is the `Wildness` `StatDef`, defined in
`Core/Defs/Stats/Stats_Pawns_General.xml`. RimWorld does not stop for an XML element that matches
no field — it logs one line and carries on with the field unset.

Unset means the stat's `defaultBaseValue`, which is `-1` (Core's own comment: *"so we can catch
missing wildness stats on animals"*), clamped by `StatWorker` to the stat's `minValue` of `0`.
Both penguins were therefore coming out at wildness **0** — as tame as the tamest thing in the
game, taming on the first attempt and never reverting to the wild — when the def had asked for
0.15.

It is now `<Wildness>0.15</Wildness>` under `statBases`, as vanilla's own birds write it. This is
also read downstream: Giddy-Up's caravan-speed calculation multiplies by
`WildnessFactor.Evaluate(def.GetStatValueAbstract(StatDefOf.Wildness))`.

The repository's `scripts/Fix-Wildness.ps1` did the move; `scripts/Check-XmlFields.ps1` then
confirmed by reflection that nothing else in the mod names a field 1.6 no longer has.

### The mod redefined three of Core's abstract egg bases

It declared `<ThingDef Abstract="True" Name="EggBase">`, `Name="EggUnfertBase"` and
`Name="EggFertBase"` — the names Core uses for the abstract parents of **every egg in the game**.

Two abstract defs sharing a `Name` is not an error, and that is the problem.
`XmlInheritance.GetBestParentFor` resolves a `ParentName` to the node from the mod with the
highest `loadOrder` at or below the def asking for it. So this mod's eggs got these copies —
intended — and so did the eggs of **every mod loaded after it**, which was not.

The copies were not faithful. `EggFertBase` sets `CompProperties_TemperatureRuinable` to −30 °C /
+10 °C where Core's is 0 °C / +50 °C, so any later mod's fertilized eggs would silently have been
ruined by room temperature and safe in a freezer.

`EggBase` and `EggUnfertBase` were copies of Core's with nothing changed but two omissions
(`allowedArchonexusCount`, and the base egg colour the penguin eggs set for themselves anyway), so
they are gone and the eggs inherit Core's directly. Only the temperature range was deliberate; it
lives on as `Penguins_EggFertBase`, parented on Core's `EggBase`.

This differs from how the same fault was handled in *Fullzoon's Cookies*, where the copies were
deleted outright: there nothing inherited from them. Here the penguin eggs do, and the cold range
is content worth keeping.

### The Giddy-Up patch had never worked, in any version

`Patches/GiddyUpPatch.xml` was dead three times over.

- Its xpath asked for `ThingDef[defName = "King_penguin"]`. The def is `king_penguin`. RimWorld
  `defName`s are case-sensitive, so this had never matched anything — not in 1.5, not before.
- It guarded with `PatchOperationFindMod` on a mod called `Giddy-up! Core`. That guard compares
  `ModMetaData.Name` by exact string (`ModLister.HasActiveModWithName`), and the 1.6 mod is
  *Giddy-Up 2 - Continued*, `MemeGoddess.GiddyUp`.
- It added a mod extension of class `GiddyUpCore.DrawingOffsetPatch`. The 1.6 assembly defines no
  such type; the shape is now `GiddyUp.DrawingOffset`, four `Vector3` fields instead of four
  comma-separated strings.

It was also aimed at the wrong penguin. `GiddyUp.Setup` marks an animal mountable by default when
`race.baseBodySize > 1.2f`, unless it carries a `GiddyUp.Mountable` or `NotMountable` extension.
The king penguin is 0.35 and can never be a mount; the emperor is 1.35 and is one by default — and
it is the one with pack textures.

The patch is rewritten against Giddy-Up 2, on `emperor_penguin`. The author's `x` and `z` offsets
are carried over. Their `y` was `-1`; Giddy-Up 2 ships `0.00` for the `y` of every animal it
offsets itself and settles draw order in its render nodes instead, so it is `0` here too.

The guard now tests one of Giddy-Up's own defs rather than its display name:

```xml
<Operation Class="PatchOperationConditional">
  <xpath>Defs/ConceptDef[defName="GUC_Animal_Handling"]</xpath>
```

A display name belongs to whoever is maintaining the fork this month; a `defName` from the mod's
own version-independent `Defs/` folder has survived three maintainers. The extension class itself
stays inside `<value>`, which is an `XmlContainer` and is not resolved until the operation
applies — a `modExtensions` entry whose class cannot be found fails the whole def it was added to,
penguin included.

**This is the one thing static checking cannot confirm.** It needs a look in-game with Giddy-Up 2
installed.

### The emperor penguin's pack was drawn from behind

`Textures/.../emperor_penguinPack.png` shipped with no facing suffix, alongside `_north` and
`_south`. `Graphic_Multi.Init` reads a suffix-less file only as a last resort, when all four
facings are missing; with `_north` present it never looked. Missing `_east` then fell back to
`array[0]`, which is north — so the emperor penguin carrying a caravan load, seen from either
side, was drawn wearing the **back** of its pack.

The file is the east view — bag in profile, strap curving round the bird. It is now named
`emperor_penguinPack_east.png`. Nothing was drawn; one file was renamed.

As a side effect the pack stops being drawn rotated: `ShouldDrawRotated` is
`MatEast == MatNorth || MatWest == MatNorth`, which was true only because east *was* north.

### Two labels typed twice

The king penguin's `ThingDef` was labelled `king penguin penguin`, and both its eggs carried the
raw `defName`: `king_penguin egg (unfert.)`, underscore and all. The emperor's were correct.

## The sounds had to go, and why

The mod shipped four `.ogg` files and four `SoundDef`s named `AEXP_Pawn_Penguin_Angry`, `_Call`,
`_Death` and `_Wounded`.

`AEXP_` is **Vanilla Animals Expanded**'s own prefix. The four audio files are **byte-identical**
to VAE's, at the same relative path (`Sounds/Pawns/Penguin/Pawn_Penguin_*.ogg`), under VAE's own
`defName`s. VAE is alive, declares 1.6, and its Steam page states **CC BY-NC-ND 4.0** — a named
licence with No Derivatives.

That is the one case in this repository's rules where the answer is not "publish with credit": an
explicit prohibition. So the four files and their `SoundDef`s are **not** in this port. Two
further consequences of removing them are welcome ones — the duplicate `defName`s no longer
collide with VAE, and neither does the shared sound path.

The penguins are not left mute. They use Core's own waterfowl voices, sized to the bird:
`Pawn_Duck_*` for the king penguin and `Pawn_Goose_*` for the emperor, all four slots each. Both
sets are in Core, so this adds no DLC or mod dependency.

**The textures are a different matter and were checked separately.** No texture in this mod is
byte-identical to any file in either VAE mod, and they do not read as the same art: VAE's penguin
is drawn in Oskar Potocki's heavy black outline, this one is flatter and thinner-lined, and the
dessicated sprites differ in proportion (90 × 112 here against VAE's 73 × 177). They are kept,
byte for byte.

## What did not change

Every stat, tool, life stage, draw size, biome weight, trade tag, egg interval and market value is
as Peso penguin left it. So is `About/Preview.png`, their own in-game showcase, and every texture
file.

Three things were noticed and deliberately left alone:

- **The dessicated corpse ships a dead duplicate.** `Dessicated_Penguin__south.png` — two
  underscores — cannot load, and it is byte-identical to `Dessicated_Penguin_east.png`, so it is
  not a lost view. Renaming it to `_south` would not add art; it would only turn
  `ShouldDrawRotated` **off** for the corpse, because a distinct south texture breaks the
  `MatEast == MatNorth` equality that currently makes a dead penguin lie down. The file stays as
  shipped.
- **The emperor penguin's head butchers into an industrial component.** A `butcherBodyPart` on
  its adult life stage yields `ComponentIndustrial` from `HeadAttackTool`. That is odd for a bird,
  but it is a balance decision, not a port breakage, and it is the author's.
- **`alternateGraphics` on the emperor penguin is inert.** One entry, at 100 % chance, pointing at
  the same `texPath` as `bodyGraphicData`. `Verse.AlternateGraphic` copies the base graphic and
  swaps the path, so it swaps it for itself. It costs nothing and it is theirs.

## The defNames were kept

`emperor_penguin`, `king_penguin` and the four egg names carry no author prefix, which is exactly
the kind of name another penguin mod would want, so they were checked rather than assumed:

- **Core and every DLC** — nothing.
- **All subscribed Workshop mods.** The only definitions of these names anywhere are the source
  mod's own. Vanilla Animals Expanded ships a penguin, but it is `AEXP_Penguin` with
  `AEXP_EggPenguin*` eggs — no collision. (The `AEXP_Pawn_Penguin_*` sound names did collide;
  they are gone, see above.)
- **This repository** — the penguins were inside *Nelim's Animal Ark*, which is why they have been
  taken out of it; see below.

No collision, so no rename. A rename is permanent in a way a port is not: it would take every
penguin already tamed out of every existing save.

## Compatibility

- The original cannot run alongside this: `Pesopenguin.thePenguinsmod` is declared in
  `<incompatibleWith>`. Because the `defName`s match, swapping one for the other in an existing
  save keeps every bird already tamed.
- **Nelim's Animal Ark** shipped these two penguins from 2026-08-30 until 2026-09-06. It no longer
  does, for the same reason: same `defName`s, so the two could not be installed together.
- Vanilla Animals Expanded coexists fine. It has its own penguin under its own names.

## Repository layout

```
Penguins/
  Mod/     <- what goes on the Workshop; the NTFS junction into RimWorld/Mods points here
  Art/     <- files the game never loads, never published
```

`Art/Make-ModIcon.ps1` cut an `About/ModIcon.png` out of the mod's own sprite. That icon was
removed on 2026-09-11 - a port does not take its identity from the art it carries - and the mod
ships without one. The script is kept.

## Verification

Checked with the repository's static checks, against RimWorld 1.6 alone:

```bash
pwsh -File scripts/Check-XmlFields.ps1   -ModPath Penguins/Mod
pwsh -File scripts/Check-DefRefs.ps1     -ModPath Penguins/Mod -Brief
pwsh -File scripts/Check-DefInjected.ps1 -TransMod Penguins/Mod
```

Every element maps to a 1.6 field, every def reference and `ParentName` resolves, and all 48
French keys land on something the injector can reach.

Static checking cannot confirm the Giddy-Up patch, which needs the mod installed, nor the pack
texture, which needs an emperor penguin carrying something. Both want a look in-game.

## Credits

- **Peso penguin** — the penguins, their artwork, their balance, the original mod. Their Workshop
  account is *Neal the gull*; `Peso penguin` is the name in the mod's own `About.xml`, so that is
  the name credited.

See [ATTRIBUTION.md](ATTRIBUTION.md) for the licence position and what exactly was carried over.

The port work was done with the help of an AI assistant (Claude, by Anthropic), under human
direction and in-game testing.
