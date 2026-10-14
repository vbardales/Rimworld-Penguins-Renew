# Pass 1 (sans-facultatifs). Language-independent: defs are named by defName and the lists are read
# from what the game kept after loading the whole mod list. The offline checks (XML fields, references,
# DefInjected paths) own everything provable without a game; this is what a running game adds.
#
# king_penguin and emperor_penguin each name a ThingDef AND a PawnKindDef, so every step here is the
# typed form: Pickle's untyped def steps refuse an ambiguous name.

@requires:nelim.pickletools.deffields
Feature: The mod loads and owns its two penguins

  Scenario: the mod is loaded and each species exists as a race and as a kind
    Then mod "nelim.penguins" is loaded
    And def "king_penguin" of type "ThingDef" exists
    And def "king_penguin" of type "PawnKindDef" exists
    And def "emperor_penguin" of type "ThingDef" exists
    And def "emperor_penguin" of type "PawnKindDef" exists
    And def "king_penguinFertilized" of type "ThingDef" exists
    And def "king_penguinUnfertilized" of type "ThingDef" exists
    And def "emperor_penguinFertilized" of type "ThingDef" exists
    And def "emperor_penguinUnfertilized" of type "ThingDef" exists
    And mod "SamBucher.ADogSaidAnimalProsthetics2" is not loaded
    And mod "Pesopenguin.thePenguinsmod" is not loaded
    And no errors were logged

  # The wildBiomes of each race become BiomeDef.wildAnimals once the game has loaded; a typo in a biome
  # name would be dropped without a line in the log.
  Scenario Outline: the penguins are wild animals of the cold biomes
    Then Nelim's Pickle Tools: the biome "<biome>" lists the wild animal "king_penguin"
    And Nelim's Pickle Tools: the biome "<biome>" lists the wild animal "emperor_penguin"

    Examples:
      | biome         |
      | SeaIce        |
      | IceSheet      |
      | Tundra        |
      | BorealForest  |
      | ColdBog       |
