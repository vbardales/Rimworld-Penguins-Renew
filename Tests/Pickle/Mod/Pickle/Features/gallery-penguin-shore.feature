# Gallery series "A day on the Penguin shore" (PUBLICATION.md, "Gallery plan"). One scenario = one image,
# in story order. Nelim is the only human; the penguins are her guests. The day runs from dawn to dusk
# on the Sanctuary of Nelim (fixture "Nelims-tribe"), and every frame is daylight.
#
# Not run. Written at playTests[1.0.0] as the shoot script for shootGallery; nothing here has an in-game result.
# Unverified in game: life-stage numbers, facing words, the face parts (GALERIE.md, "Configuration d'un pion").
# Missing steps (none shared yet): crouch and kneel poses (images 2 and 3), so Nelim stands; laying an animal on a
# bed and injuring it, so image 5 shows the Health tab of an unhurt emperor. The tab type name of image 5 and the
# cell (90, 140) of image 7 are not verified in game.

@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.stagedecor
Feature: A day on the Penguin shore

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the alerts are hidden
    And I set the weather to "Fog"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Princess"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (70, 45, 35)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Parka" dyed rgb (30, 140, 150)

  # Image 1, 07:00. The two species arrive together out of the mist.
  Scenario: workshop-1-dawn: they have just arrived
    Given Nelim's Sanctuary: the floor of the sanctuary "water-garden" is bared
    And Nelim's Sanctuary: the animals are removed from the sanctuary "water-garden"
    And I set the hour to 7
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And Nelim's Pickle Tools: an adult animal of kind "king_penguin" named "Kiri" is spawned at (150, 170)
    And Nelim's Pickle Tools: an adult animal of kind "king_penguin" named "Mio" is spawned at (154, 172)
    And Nelim's Pickle Tools: an adult animal of kind "emperor_penguin" named "Ruu" is spawned at (158, 171)
    And Nelim's Pickle Tools: "Nelim" stands at (143, 168) facing East
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And I take a screenshot "1-dawn"

  # Image 2, 09:00. The emperor is the star: front-on, large in the frame, Nelim at the left edge.
  Scenario: workshop-2-emperor: the tallest of them all
    Given Nelim's Sanctuary: the floor of the sanctuary "water-garden" is bared
    And Nelim's Sanctuary: the animals are kept out of the sanctuary "water-garden"
    And I set the hour to 9
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And Nelim's Pickle Tools: an adult animal of kind "emperor_penguin" named "Ruu" is spawned at (152, 171)
    And Nelim's Pickle Tools: the animal "Ruu" stands at (152, 171) facing South
    And Nelim's Pickle Tools: "Nelim" stands at (145, 172) facing East
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmirkSmile"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowTanuki"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And I take a screenshot "2-emperor"

  # Image 3, 11:00. Nelim at the bank holding a fertilized egg; a king penguin watches from the side.
  # The kneeling pose has no step (NPT); she stands, which the egg and the penguin still carry.
  Scenario: workshop-3-the-egg: eggs exist, and they hatch
    Given Nelim's Sanctuary: the floor of the sanctuary "water-garden" is bared
    And Nelim's Sanctuary: the animals are kept out of the sanctuary "water-garden"
    And I set the hour to 11
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And Nelim's Pickle Tools: "Nelim" stands at (146, 174) facing East
    And Nelim's Pickle Tools: "Nelim" carries the item "king_penguinFertilized"
    And Nelim's Pickle Tools: an adult animal of kind "king_penguin" named "Mio" is spawned at (152, 176)
    And Nelim's Pickle Tools: the animal "Mio" stands at (152, 176) facing West
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And I take a screenshot "3-the-egg"

  # Image 4, 13:00. The three life stages of the king penguin, from the front. Nelim laughs at the far end.
  Scenario: workshop-4-growing-up: from chick to full-grown king
    Given Nelim's Sanctuary: the floor of the sanctuary "water-garden" is bared
    And Nelim's Sanctuary: the animals are kept out of the sanctuary "water-garden"
    And I set the hour to 13
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And Nelim's Pickle Tools: an animal of kind "king_penguin" named "Pip" is spawned at (147, 171) at life stage 0
    And Nelim's Pickle Tools: an animal of kind "king_penguin" named "Tobi" is spawned at (150, 171) at life stage 1
    And Nelim's Pickle Tools: an adult animal of kind "king_penguin" named "Mio" is spawned at (153, 171)
    And Nelim's Pickle Tools: the animal "Pip" stands at (147, 171) facing South
    And Nelim's Pickle Tools: the animal "Tobi" stands at (150, 171) facing South
    And Nelim's Pickle Tools: the animal "Mio" stands at (153, 171) facing South
    And Nelim's Pickle Tools: "Nelim" stands at (156, 171) facing West
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmirkSmile"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowTanuki"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And I take a screenshot "4-growing-up"

  # Image 5, 16:00. Same bank, the Animal Prosthetics 2 pass (wsl-deps.gallery.map). The Health tab of the emperor
  # is open and lists the ADS 2 operations; no injury or bed is staged (no step exists, and the tab does not need one).
  # Tab type name ITab_Pawn_Health: not verified in game.
  Scenario: workshop-5-the-peg-leg: the mod works with Animal Prosthetics 2
    Given Nelim's Sanctuary: the floor of the sanctuary "water-garden" is bared
    And Nelim's Sanctuary: the animals are kept out of the sanctuary "water-garden"
    And I set the hour to 16
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And Nelim's Pickle Tools: an adult animal of kind "emperor_penguin" named "Ruu" is spawned at (152, 171)
    And Nelim's Pickle Tools: the animal "Ruu" stands at (152, 171) facing West
    And Nelim's Pickle Tools: "Nelim" stands at (149, 171) facing East
    And Nelim's Pickle Tools: I select the thing of def "emperor_penguin" at (152, 171)
    And Nelim's Pickle Tools: I open the "ITab_Pawn_Health" inspect tab
    And Nelim's Pickle Tools: "Nelim" brows are "BrowThick"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And I take a screenshot "5-the-peg-leg"

  # Image 6, 18:00. Dusk: the pack heads home beside Nelim and her lantern.
  Scenario: workshop-6-dusk: the pack at the end of the day
    Given Nelim's Sanctuary: the floor of the sanctuary "water-garden" is bared
    And Nelim's Sanctuary: the animals are kept out of the sanctuary "water-garden"
    And I set the hour to 18
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (146, 169)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (146, 169) is lit
    And Nelim's Pickle Tools: an adult animal of kind "king_penguin" named "Kiri" is spawned at (149, 173)
    And Nelim's Pickle Tools: an adult animal of kind "king_penguin" named "Mio" is spawned at (151, 173)
    And Nelim's Pickle Tools: an adult animal of kind "emperor_penguin" named "Ruu" is spawned at (153, 173)
    And Nelim's Pickle Tools: the animal "Kiri" stands at (149, 173) facing North
    And Nelim's Pickle Tools: the animal "Mio" stands at (151, 173) facing North
    And Nelim's Pickle Tools: the animal "Ruu" stands at (153, 173) facing North
    And Nelim's Pickle Tools: "Nelim" stands at (146, 171) facing North
    And Nelim's Pickle Tools: "Nelim" lids are "LidGeek"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And I take a screenshot "6-dusk"

  # Image 7, no subtitle. The king penguin's information card, cropped to the window (GALERIE.md, interface rule).
  # A king penguin is spawned at the backdrop centre, selected, and its info card opened on the Stats tab.
  Scenario: workshop-7-king-penguin-info: the species card
    Given Nelim's Sanctuary: I am at the sanctuary "window-backdrop-for-height"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "window-backdrop-for-height"
    And Nelim's Pickle Tools: an adult animal of kind "king_penguin" named "Kiri" is spawned at (90, 140)
    And Nelim's Pickle Tools: I select the thing of def "king_penguin" at (90, 140)
    And Nelim's Pickle Tools: I open the info card of the selected thing on the "Stats" tab
    And I take a screenshot "7-king-penguin-info"
    And Nelim's Pickle Tools: I close the info card
