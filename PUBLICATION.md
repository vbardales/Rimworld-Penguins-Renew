# PUBLICATION.md: the Penguins mod Renew (unofficial)

Written 2026-10-16 at `playTests[1.0.0]`, ahead of `shootGallery`. Gallery plan only for now: nothing here has been staged or captured. The other sections of this file (messages to post, DLC, adult-content answer) come at `writeDocs`.

## Gallery plan

Series title: **A day on the Penguin shore.** One story, one place (the Sanctuary of Nelim, `SanctuaryBacklot`), one day that moves from dawn to dusk. Nelim is the protagonist and the only colonist; the penguins are her guests. The penguins are cold-climate animals, so the day is cold and a little misty: `I set the weather to` a gentle snowfall or fog, temperature low (step to be confirmed), and Nelim wears a parka.

Place: `water-garden` (pond, west bank, x 143-158, z 168-176; keep clear of the burrow-looking hole at (149, 173)). Rhythm: one hour per image (`I set the hour to N`), the day told in order. Penguins are not nocturnal, so every image stays in daylight until dusk.

### Who is in the frame (Nelim)

- Body, face, eyes: fixture defaults, dark brown eyes. Face set by `Nelim's Sanctuary: Nelim has her own face` (BrowNormal, MouthSmirkSmile) then `facial expression is "normal+blink"` in one call (GALERIE.md, "Configuration d'un pion"). Not verified in game.
- Hair (chosen, scripted): `Princess` (long, loose), colour rgb (70, 45, 35), dark brown, so it reads against the white fog and the penguins' white fronts. Set in the feature Background (`hairstyle is`, `hair colour is rgb`). Not verified in game.
- Outfit (chosen, scripted): `Apparel_Parka` dyed teal rgb (30, 140, 150), over her default trousers, set in the Background (`wears ... dyed rgb`). No cap. Palette rule: the king penguin's orange cheek patch is the only orange accent. Not verified in game.
- Expressions, per image, limited to face parts already listed as safe without VEFA (GALERIE.md: `LidGeek`, `LidNormal`, `LidSharp`, `MouthNormal`, `BrowNormal`, `BrowTanuki`, `BrowThick`; no face kits). Not verified in game:
  1 neutral: `normal+blink`.
  2 smile: `MouthSmirkSmile`, `BrowTanuki`.
  3 calm: `LidNormal`, `MouthNormal`.
  4 laughing: `MouthSmirkSmile`, `BrowTanuki`, sets the scene in the same frame as the chicks.
  5 concerned: `BrowThick`, `MouthNormal`.
  6 tired: `LidGeek`, `MouthNormal`.
  A part that fails to resolve (`No ... valid:`) is replaced by the nearest listed default; the image is then reread.
- Other pawns: none. Nelim is the only human in the frame; the penguins carry the story. No guest pawn added. Reason: every extra face and hair needs its own unverified part set.

Mods chosen for this series (only what the frames need; nothing else loaded):
- Sanctuary (`SanctuaryBacklot`): place and map.
- Penguins mod (this mod): the animals.
- Animal Prosthetics 2 (ADS 2): the peg-leg image 5 only.
- Facial Animation + VEFA: face parts above.
- `TorchLamp` (vanilla): lantern in image 6.

Not used: body and apparel mods from GALERIE.md (not needed for the chosen look).

### Images

Image 0 is the Preview (`Art/Gallery/0-preview.png`, byte-for-byte `About/Preview.png`), no subtitle.

| # | File | Hour | Place | Subject and composition | What it says | Animals facing |
|---|---|---|---|---|---|---|
| 1 | `1-dawn.jpg` | 7 | `water-garden`, west bank | Wide shot. Nelim off-centre at the left, back three-quarter, looking at the pond. Two king penguins and an emperor walk out of the mist at the right, mid-ground. Fog. | They have just arrived. The two species are shown together. | three-quarter |
| 2 | `2-emperor.jpg` | 9 | same bank | Tight shot. An emperor penguin front-on, centred slightly right, filling two thirds of the frame. Nelim standing at the left edge, smiling at him (no crouch step exists; standing is what is scripted). | The emperor is the tallest and the star. | front |
| 3 | `3-the-egg.jpg` | 11 | same bank, edge by the grass (no nest set; decided) | Nelim standing at the bank, holding a fertilized king penguin egg (`carries the item`, no kneel step). A king penguin watches from the right, side-on. No straw, no egg box: nothing is staged. | Eggs exist, and they hatch. | side |
| 4 | `4-growing-up.jpg` | 13 | same bank | Three animals in a row seen from the front, chick, juvenile, adult (`AnimalBabyTiny`, `AnimalJuvenile`, `AnimalAdult`) of the king penguin, Nelim laughing at the far end. | The three life stages. | front |
| 5 | `5-the-peg-leg.jpg` | 16 | same bank | Health tab of the emperor open (an inspection tab, kept in the story place), beside Nelim, concerned. ADS 2 pass. No bed, no injury: no step exists, the tab does not need one. | The mod works with Animal Prosthetics 2. | side |
| 6 | `6-dusk.jpg` | 18 | same bank | Wide, low light, a lit lamp (`TorchLamp`, vanilla) by Nelim; the three penguins lined up beside her, heading the same way. | The pack at the end of the day. | three-quarter, back |
| 7 | `7-king-penguin-info.jpg` | n/a | `window-backdrop-for-height` | Full-screen information card ("i") of the king penguin, cropped 5 px to each side of the window. | The species data and stats. | n/a |

Images 1 to 4 and 6 carry a subtitle. Images 0 (Preview), 5 (Health tab open, an interface window) and 7 (information card) do not: a scene with no interface window is subtitled (`GALLERY.md`, "Sous-titres").

Open points before writing the scenarios:

- Cold weather: `Fog` is scripted (the weather def exists in Core); `SnowGentle` exists too and a temperature step is not needed. Read the capture.
- Image 5: the Health tab is opened by the `ITab_Pawn_Health` type name (not verified); the ADS 2 operations should list on an unhurt emperor, else read the capture and fall back to the Stats tab.
- Facing: whether a pawn or animal can be given a rotation by a step; if not, front-on comes from where the camera and the animal's walk path put it. Read each capture.
- Mod list for the single pass map: `Tests/Pickle/wsl-deps.gallery.map` (Sanctuary base map and its PickleTools, penguins, ADS 2, body and Facial Animation mods of GALERIE.md). Nothing staged ships with the mod; credit them in THANKS.

## Gallery subtitles

One short English sentence per scene, burned in at the bottom with `scripts/Add-Subtitle.ps1` from `Art/Gallery-clean/` into `Art/Gallery/`. An image absent from this table gets no subtitle.

| index | file | line |
|---|---|---|
| 1 | `1-dawn.jpg` | Two kings and an emperor walk out of the morning mist. |
| 2 | `2-emperor.jpg` | The emperor is the tallest of them all, and he knows it. |
| 3 | `3-the-egg.jpg` | Nelim holds a fertilized egg, and a chick will hatch in time. |
| 4 | `4-growing-up.jpg` | From fluffy chick to full-grown king, they grow up fast. |
| 6 | `6-dusk.jpg` | At dusk the whole flock follows Nelim home. |
