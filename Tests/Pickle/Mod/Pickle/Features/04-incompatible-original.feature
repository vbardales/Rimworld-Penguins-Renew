# Pass 3 (incompat-original): Peso penguin's original, then this port. Not a supported configuration.
#
# About.xml declares the two mods incompatible: the defNames are the same, RimWorld resolves a duplicate
# defName by load order and logs nothing, so one silently stands in for the other. That claim ages, so
# this pass goes and looks. Green means the symptom still holds as documented, not that both mods behave
# well together. Replayed when the original changes, not at every release.

@requires:Pesopenguin.thePenguinsmod
Feature: The original mod is silently overridden, as documented

  Scenario: both mods load and the game does not warn about the duplicate defNames
    Then mod "Pesopenguin.thePenguinsmod" is loaded
    And mod "nelim.penguins" is loaded
    And no errors were logged
