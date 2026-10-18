# Pass 1 (sans-facultatifs), English or French. Language-independent.
#
# TEST_SCENARIOS.md 4: the effective Wildness stat of a spawned animal. The mod once wrote <wildness> inside
# <race>, a field 1.6 no longer has, so both penguins read 0 in game while the XML said 0.15 (README, "Wildness
# became a stat"). The pawn step reads the stat the game computes, not the XML entry.
#
# TEST_SCENARIOS.md 11, the part a scenario can prove: the three pack textures the game derives from the kind's
# texPath ("Pack" appended, south, north, east; west is the east one mirrored) are shipped by the mod, and the pack
# is photographed on four facings (the step that fills the animal's pack is PickleTools 124c3e2, compiled, not played).

@requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.textureowner @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.colonistrace
Feature: The penguins read the wildness the def asks for and ship their pack textures

  Scenario Outline: the adult <kind> has the effective Wildness of 0.15
    Given the save "test-colony" is loaded
    And I close all dialogs
    When Nelim's Pickle Tools: an adult animal of kind "<kind>" named "Wild <kind>" is spawned at (<x>, 150)
    Then the "<kind>" at (<x>, 150) stat "Wildness" is 0.15
    And no errors were logged

    Examples:
      | kind            | x   |
      | king_penguin    | 145 |
      | emperor_penguin | 148 |

  Scenario Outline: the emperor penguin pack texture <facing> is shipped by the mod
    Then Nelim's Pickle Tools: the texture "Things/Pawn/Animal/Penguins/emperor_penguinPack_<facing>" is answered by the mod "nelim.penguins"

    Examples:
      | facing |
      | north  |
      | east   |
      | south  |

  # The pack drawn on the animal, read by a person from the capture (@review): a green scenario says the pack
  # filled and the photo was taken, not that the picture is right. West is the east texture mirrored.
  @review
  Scenario Outline: the emperor penguin carrying a pack faces <facing>
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Nelim's Pickle Tools: an adult animal of kind "emperor_penguin" named "Pack emperor_penguin" is spawned at (148, 150)
    And Nelim's Pickle Tools: the animal "Pack emperor_penguin" carries 20 "Silver" in its pack
    And Nelim's Pickle Tools: the animal "Pack emperor_penguin" stands at (148, 150) facing <facing>
    When Nelim's Pickle Tools: the camera is centered on "Pack emperor_penguin" at root size 11
    Then I take a screenshot "penguins emperor pack <facing>"
    And no errors were logged

    Examples:
      | facing |
      | North  |
      | East   |
      | South  |
      | West   |
