# Pass 2 (avec-ads2). A Dog Said... Animal Prosthetics 2 (SamBucher.ADogSaidAnimalProsthetics2, Workshop 3238353862).
# Patches/Compat_ADogSaidAnimalProsthetics2.xml puts both penguins in ADS_Cat1 and ADS_Cat2 and not in
# ADS_Cat3; About.xml declares <loadBefore> for ADS 2.
#
# WHAT ONLY A RUN SHOWS. ADS 2 copies its category lists onto its recipe bases ONCE, at its own last patch.
# A patch right on paper that loads after it leaves the real recipes without the animals, so the check is on
# the recipes the game built (ThingDef.AllRecipes) and on the load order.
#
# THE CONTROL. Duck is in Cat1 and Cat2 and in no other category: if the control did not offer the same
# recipes, ADS 2 itself had not applied and a missing penguin would prove nothing about this mod.
# One recipe per category: InstallPegLegAnimal (1), InstallSimpleProstheticLegAnimal (2), InstallBionicEyeAnimal (3).
# Typed steps only: the penguins' names are both a ThingDef and a PawnKindDef.
# Skipped by requirement in the pass without optional mods, on purpose: it is counted there, not hidden.
@requires:SamBucher.ADogSaidAnimalProsthetics2 @requires:nelim.pickletools.deffields
Feature: Animal Prosthetics 2 offers its surgeries to the two penguins

  Scenario: this mod loads before ADS 2, which is what its lists depend on
    Then mod "nelim.penguins" loads before "SamBucher.ADogSaidAnimalProsthetics2"

  Scenario: control, the Duck is offered categories 1 and 2 and not 3
    Then Nelim's Pickle Tools: the recipe "InstallPegLegAnimal" is offered for the race "Duck"
    And Nelim's Pickle Tools: the recipe "InstallSimpleProstheticLegAnimal" is offered for the race "Duck"
    And Nelim's Pickle Tools: the race "Duck" is not offered the recipe "InstallBionicEyeAnimal"

  Scenario Outline: the <race> is offered categories 1 and 2 and not 3
    Then Nelim's Pickle Tools: the recipe "InstallPegLegAnimal" is offered for the race "<race>"
    And Nelim's Pickle Tools: the recipe "InstallSimpleProstheticLegAnimal" is offered for the race "<race>"
    And Nelim's Pickle Tools: the race "<race>" is not offered the recipe "InstallBionicEyeAnimal"

    Examples:
      | race            |
      | king_penguin    |
      | emperor_penguin |
