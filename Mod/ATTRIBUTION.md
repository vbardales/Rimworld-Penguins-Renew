# the Penguins mod — attribution

A 1.6 port of **the Penguins mod**, by **Peso penguin**
([3477589277](https://steamcommunity.com/sharedfiles/filedetails/?id=3477589277)).

## Status: public

The source mod is **dead** — posted 7 May 2025, declaring 1.5 and nothing further, never updated
since — and **no licence is declared anywhere**, checked at the four places one could be:

- no `LICENSE` or `COPYING` file in the mod;
- no mention in its `About.xml`;
- no linked repository — `<url>` is absent entirely;
- nothing in the body of the description on its Steam page.

That last check is the one that matters, and it was done properly: the description was read out of
the raw `<div class="workshopItemDescription" id="highlightContent">`, not out of an extractor's
markdown, and searched for prohibitions as well as permissions — `prohibit`, `forbid`,
`redistribut`, `do not`, alongside `licence`, `permission`, `free`. It contains none of them. It is
the species blurb and a list of biomes, and that is all. (The "This item has been removed from the
community" string in the page source is the hidden Steam template banner, `style="display: none"`,
present on every Workshop page.)

This is the usual convention for ports on the RimWorld Workshop: republished with **credit by
name** and **removal on request, without argument**. The `<author>` field reads
`Peso penguin - 1.6 adapted by Nelim`, and the removal clause is in the description.

Their Workshop account is named **Neal the gull**; `Peso penguin` is the name written in the mod's
own `About.xml`, so that is the name credited.

## Where it came from

These two penguins were inside **Nelim's Animal Ark**, the private pack of abandoned animal mods,
from 2026-08-30 until 2026-09-06. They came out for the same reason the dalmatian did: the pack
and this mod both define `emperor_penguin` and `king_penguin` and cannot be installed together, and
dead-and-unlicensed is now a reason to publish rather than to keep back.

## What was carried over

Eight defs and ten textures. No C#, no dependency, no DLC, no research.

| def | type | what it is |
|---|---|---|
| `king_penguin` | `ThingDef` | the animal, on `BigBirdThingBase` |
| `king_penguin` | `PawnKindDef` | its spawn entry, on `BigBirdKindBase` |
| `emperor_penguin` | `ThingDef` | the animal, on `BigBirdThingBase` |
| `emperor_penguin` | `PawnKindDef` | its spawn entry, on `BigBirdKindBase` |
| `king_penguinUnfertilized` | `ThingDef` | its egg |
| `king_penguinFertilized` | `ThingDef` | its egg, with `CompProperties_Hatcher` |
| `emperor_penguinUnfertilized` | `ThingDef` | its egg |
| `emperor_penguinFertilized` | `ThingDef` | its egg, with `CompProperties_Hatcher` |

Their stats, tools, life stages, draw sizes, biome weights, trade tags, egg intervals and market
values are Peso penguin's, unchanged. So are the ten textures, byte for byte, and
`About/Preview.png`, which is their own in-game showcase.

**The mod ships no `About/ModIcon.png`.** One existed for a few days: a 64 × 64 square of their
own south-facing emperor penguin, scaled to 128 px, because the full 58 × 114 sprite reads as a
thin vertical smudge at the ~32 px the mod list actually draws.

It was removed on 2026-09-11. An icon cut from the source mod's art makes the upstream author's
work carry the port's identity, and the icon is the one file of a port that is supposed to speak
for the port rather than for the mod it carries. RimWorld loads a mod that has none.
`Art/Make-ModIcon.ps1` is kept: the script is port work and falls under the MIT grant, the art it
crops does not.

## What was NOT carried over, and why

**Four sound files and four `SoundDef`s, because they are Vanilla Animals Expanded's.**

The mod shipped `Sounds/Pawns/Penguin/Pawn_Penguin_Angry.ogg`, `_Call`, `_Death` and `_Wounded`,
declared as `AEXP_Pawn_Penguin_Angry`, `_Call`, `_Death` and `_Wounded`.

- `AEXP_` is the prefix **Vanilla Animals Expanded** uses for its own defs.
- The four `.ogg` files are **byte-identical** (MD5) to the files of the same names in both
  *Vanilla Animals Expanded* (`2871933948`) and *Vanilla Animals Expanded — Ice Sheet*
  (`1895364782`), at the same relative path.
- The `SoundDef`s carry VAE's `defName`s verbatim, which means they were also **duplicate defs**
  whenever VAE was installed.
- VAE is **alive** — it declares 1.4, 1.5 and 1.6 — and its Steam page states
  **CC BY-NC-ND 4.0**, read from the description body the same way as above.

Both halves of this repository's rule point the same way. The source is alive in 1.6, and the
licence is an explicit named prohibition with No Derivatives — the `Forbidden` case, the one that
never ships, as on TeaTimeRodent. So they are not here.

The penguins are not left mute: the four life-stage slots on each now point at Core's own
waterfowl, sized to the bird — `Pawn_Duck_*` for the king penguin at body size 0.35,
`Pawn_Goose_*` for the emperor at 1.35. Both sets live in `Core/Defs/SoundDefs/`, so nothing new
is depended on. Removing the copies also ends the duplicate `defName`s and the shared sound path.

**The textures were checked separately, and they are not VAE's.** No file in this mod is
byte-identical to any file in either VAE mod. Nor do they read as the same art: VAE's penguin is
drawn in Oskar Potocki's heavy black outline over a white-to-grey gradient body, this one is
flatter, thinner-lined and differently coloured, and even the dessicated sprite — the closest of
them in subject — is 90 × 112 against VAE's 73 × 177, a different drawing of the same skeleton.
They are kept, byte for byte. This is recorded rather than assumed because of what the audio
turned out to be.

`About/PublishedFileId.txt` was also dropped, for the obvious reason: it names Peso penguin's
Workshop item.

## What changed in the port

**The real breakage is the one this repository has hit before, and here it bit.** Both defs
declared `<wildness>0.15</wildness>` inside `<race>`. Wildness stopped being a field of
`RaceProperties` and became a `StatDef`; that element now matches no field, and RimWorld does not
stop for an element that matches no field — it logs one line and carries on with the field unset.

Unlike the dalmatian, which asked for 0 and got 0, these two asked for 0.15. Unset means the
`Wildness` stat's `defaultBaseValue` of `-1` (Core's own comment: *"so we can catch missing
wildness stats on animals"*), clamped by `StatWorker` to the stat's `minValue` of `0`. Both
penguins were therefore loading at wildness **0** — taming on the first attempt, never reverting
to the wild, as tame as anything in the game. It is now `<Wildness>0.15</Wildness>` under
`statBases`, written the way vanilla's own birds write it.

`scripts/Check-XmlFields.ps1` then confirmed by reflection that this was the only element in the
mod naming a field 1.6 no longer has.

**The mod redefined three of Core's abstract egg bases.** `EggBase`, `EggUnfertBase` and
`EggFertBase` — the abstract parents of every egg in the game — were declared again under their
own names, with the mod's own contents.

That is legal and that is what makes it dangerous. `XmlInheritance.GetBestParentFor` resolves a
`ParentName` to the node from the mod with the **highest `loadOrder` at or below** the def asking
for it. The penguin eggs therefore got these copies, as intended — and so did the eggs of every
mod loaded after this one, which was not intended by anybody. The copies were not faithful:
`EggFertBase` set `CompProperties_TemperatureRuinable` to −30 °C/+10 °C where Core's is
0 °C/+50 °C. Any other mod's fertilized eggs, inheriting this, would have been ruined by room
temperature and preserved in a freezer, silently.

`EggBase` and `EggUnfertBase` differed from Core's only by two omissions — `allowedArchonexusCount`
and the base egg colour, which the penguin eggs set for themselves anyway — so they are deleted
and the eggs inherit Core's directly. The temperature range was the one deliberate change, and it
survives as `Penguins_EggFertBase`, parented on Core's `EggBase`.

The treatment differs from *Fullzoon's Cookies*, where the same fault was fixed by deleting the
copies outright. There, nothing inherited from them. Here the penguin eggs do, and the cold range
is content, not an accident. It also could not simply be re-declared on each egg over Core's base:
`RecursiveNodeCopyOverwriteElements` **appends** `<li>` elements rather than replacing them, so
that would leave each egg carrying two `CompProperties_TemperatureRuinable`.

**The Giddy-Up patch had never worked, in any version of the game.** Three independent faults:

- `<xpath>*/ThingDef[ defName = "King_penguin"]</xpath>`. The def is `king_penguin`. `defName`s
  are case-sensitive, so this matched nothing in 1.5 either.
- The `PatchOperationFindMod` guard named `Giddy-up! Core`. `ModLister.HasActiveModWithName`
  compares `ModMetaData.Name` by exact string equality, and the 1.6 mod is called
  *Giddy-Up 2 - Continued* (`MemeGoddess.GiddyUp`).
- The value added was `<li Class="GiddyUpCore.DrawingOffsetPatch">` with `northOffsetCSV` and
  friends. Reflecting over Giddy-Up 2's `GiddyUpCore.dll` for 1.6: no such type. The shape is now
  `GiddyUp.DrawingOffset`, a `DefModExtension` with four `Vector3` fields, applied by
  `GiddyUpCore.Core.MountedRiderRenderNodeUtility` through `GetOffsetByRotation`.

And it was on the wrong penguin. `GiddyUp.Setup` marks an animal mountable by default when
`race.baseBodySize > 1.2f`, overridable only by a `GiddyUp.Mountable` or `GiddyUp.NotMountable`
extension. The king penguin is 0.35 and cannot be a mount; the emperor is 1.35 and is one out of
the box — and it is the penguin with pack textures. The rewritten patch targets `emperor_penguin`.

The author's `x` and `z` offsets are carried over unchanged. Their `y` was `-1`, meaning "draw the
rider behind" in the old CSV form; Giddy-Up 2 ships `0.00` for the `y` of all ~200 animals it
offsets itself and settles draw order in its render nodes instead, so `-1` would have been out of
family. It is `0` here.

The guard now tests `Defs/ConceptDef[defName="GUC_Animal_Handling"]` — one of Giddy-Up's own defs,
from its version-independent `Defs/` folder, which has outlived three maintainers — rather than a
display name, which belongs to whoever is maintaining the fork this month. That is the lesson from
Fullzoon's Cookies. A guard is still needed and cannot be dropped: the extension class sits inside
`<value>`, an `XmlContainer` resolved only when the operation applies, and a `modExtensions` entry
whose class cannot be found fails the entire def it was added to — which would take the emperor
penguin with it.

**The emperor penguin's pack was drawn from behind.** `emperor_penguinPack.png` shipped with no
facing suffix, next to `_north` and `_south`. `Graphic_Multi.Init` reads a suffix-less file only
as a last resort, when all four facings are missing; `_north` was present, so it never looked. The
missing `_east` then fell back to `array[0]` — north — so an emperor penguin carrying a caravan
load showed the back of its pack from both sides. The file is unmistakably the east view: bag in
profile, strap curving round the bird. It is renamed `emperor_penguinPack_east.png`. Nothing was
drawn.

**Two labels were typed twice.** `king penguin penguin` on the `ThingDef`, and both king penguin
eggs labelled with the raw `defName`, underscore included.

## What did not change

Every stat, every tool, the life stages and their draw sizes, the biome weights, the egg intervals
and hatch times, the trade tags, the market values — and all eight `defName`s, so a save moves
between the two mods without losing a bird. The original is declared in `<incompatibleWith>`.

Three oddities were noticed and left alone, because they are the author's design and not port
breakage:

- The emperor penguin's `butcherBodyPart` yields a `ComponentIndustrial` from its head.
- Its `alternateGraphics` has one entry at 100 % chance pointing at the same `texPath` as
  `bodyGraphicData`, so it swaps the graphic for itself. `Verse.AlternateGraphic` copies the base
  and overrides the path; the override is the same path.
- `Dessicated_Penguin__south.png` — two underscores — cannot load. It is byte-identical to
  `Dessicated_Penguin_east.png`, so it is a dead duplicate rather than a lost view. Renaming it
  would not add a facing; it would turn `ShouldDrawRotated` **off** for the corpse, since that
  test is `MatEast == MatNorth || MatWest == MatNorth` and it holds today only because east *is*
  north. A dead penguin currently lies down, and should keep doing so.

**The defNames were checked rather than assumed**, since none of them carries an author prefix:

- **Core and every DLC** — nothing.
- **Every subscribed Workshop mod.** The only definitions of `emperor_penguin`, `king_penguin` or
  the four egg names anywhere are the source mod's own. Vanilla Animals Expanded does ship a
  penguin, but under `AEXP_Penguin` with `AEXP_EggPenguinFertilized` and
  `AEXP_EggPenguinUnfertilized`, so the two coexist. *Zoology: Realistic Animal Overhaul*
  references the `AEXP_Pawn_Penguin_*` sounds but defines none of them.
- **This repository** — only Nelim's Animal Ark, which has been emptied of them, and
  `ReequilibrageAnimaux`, whose patches address the penguins by `defName` and go on working.

No collision, so no rename. That is the right way round to decide it: a rename is permanent in a
way a port is not, and it would take every penguin already tamed out of every existing save.

## Adoption

If I do not answer within a reasonable time after being contacted, anyone may freely update this
or any other of my mods, including publishing a continuation of it. All credit must be preserved.
