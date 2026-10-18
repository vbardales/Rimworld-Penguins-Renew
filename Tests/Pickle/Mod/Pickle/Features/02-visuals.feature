# Pass 1 (sans-facultatifs). Run once in English and once in French: the language is set at launch
# (-Language), never switched inside a scenario. InspectTabs gives a def-based selection that does not
# depend on the language; DefFieldSteps reads labels from the defs as the game translated them.
#
# Textures, life stages and the pack are read by a person from the attached captures: a green scenario
# says the spawn and the capture happened, not that the picture is right (@review).

@requires:nelim.pickletools.deffields @requires:nelim.pickletools.inspecttabs @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.colonistrace
Feature: The two penguins are drawn and read correctly in game

  @review
  Scenario Outline: the adult <kind> spawns, selects and is drawn without error
    Given the save "test-colony" is loaded
    And I close all dialogs
    When Nelim's Pickle Tools: an adult animal of kind "<kind>" named "Adult <kind>" is spawned at (<x>, 150)
    And Nelim's Pickle Tools: the animal "Adult <kind>" stands at (<x>, 150) facing South
    And Nelim's Pickle Tools: I select the thing of def "<kind>" at (<x>, 150)
    And Nelim's Pickle Tools: the camera is centered on "Adult <kind>" at root size 11
    Then I take a screenshot "penguins <kind> adult"
    And no errors were logged

    Examples:
      | kind            | x   |
      | king_penguin    | 145 |
      | emperor_penguin | 148 |

  # Three life stages each: AnimalBabyTiny, AnimalJuvenile, AnimalAdult. Adults are covered above.
  @review
  Scenario Outline: the <stage> <kind> is spawned, drawn and photographed
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Nelim's Pickle Tools: an animal of kind "<kind>" named "Stage <kind>" is spawned at (<x>, 146) at the life stage "<stage>"
    And Nelim's Pickle Tools: the animal "Stage <kind>" stands at (<x>, 146) facing South
    When Nelim's Pickle Tools: the camera is centered on "Stage <kind>" at root size 11
    Then I take a screenshot "penguins <kind> <stage>"
    And no errors were logged

    Examples:
      | kind            | stage          | x   |
      | king_penguin    | AnimalBabyTiny | 145 |
      | king_penguin    | AnimalJuvenile | 145 |
      | emperor_penguin | AnimalBabyTiny | 148 |
      | emperor_penguin | AnimalJuvenile | 148 |

  @english
  Scenario: the penguins and their eggs read in English
    Then Nelim's Pickle Tools: def "king_penguin" of type "ThingDef" field "label" is "king penguin"
    And Nelim's Pickle Tools: def "emperor_penguin" of type "ThingDef" field "label" is "emperor penguin"
    And Nelim's Pickle Tools: def "king_penguinUnfertilized" of type "ThingDef" field "label" is "king penguin egg (unfert.)"
    And Nelim's Pickle Tools: def "king_penguinFertilized" of type "ThingDef" field "label" is "king penguin egg (fert.)"
    And Nelim's Pickle Tools: def "emperor_penguinUnfertilized" of type "ThingDef" field "label" is "emperor penguin egg (unfert.)"
    And Nelim's Pickle Tools: def "emperor_penguinFertilized" of type "ThingDef" field "label" is "emperor penguin egg (fert.)"
    And no errors were logged

  @french
  Scenario: the penguins and their eggs read in French
    Then Nelim's Pickle Tools: def "king_penguin" of type "ThingDef" field "label" is "manchot royal"
    And Nelim's Pickle Tools: def "emperor_penguin" of type "ThingDef" field "label" is "manchot empereur"
    And Nelim's Pickle Tools: def "king_penguinUnfertilized" of type "ThingDef" field "label" is "œuf de manchot royal (non fécondé)"
    And Nelim's Pickle Tools: def "king_penguinFertilized" of type "ThingDef" field "label" is "œuf de manchot royal (fécondé)"
    And Nelim's Pickle Tools: def "emperor_penguinUnfertilized" of type "ThingDef" field "label" is "œuf de manchot empereur (non fécondé)"
    And Nelim's Pickle Tools: def "emperor_penguinFertilized" of type "ThingDef" field "label" is "œuf de manchot empereur (fécondé)"
    And no errors were logged
