# Pass 1 (sans-facultatifs). English only. Catches a broken ExposeData, the most common way a content
# mod loses state across a reload; the offline checks never run a save.

@requires:nelim.pickletools.inspecttabs
Feature: The penguins survive a save and reload

  @english
  Scenario: a king penguin and an emperor penguin keep their identity across a save and reload
    Given the save "test-colony" is loaded
    And I close all dialogs
    When I spawn a "king_penguin" pawn at (145, 150)
    And I spawn a "emperor_penguin" pawn at (148, 150)
    And I save and reload
    And Nelim's Pickle Tools: I select the thing of def "king_penguin" at (145, 150)
    Then the inspect pane shows "king penguin"
    When Nelim's Pickle Tools: I select the thing of def "emperor_penguin" at (148, 150)
    Then the inspect pane shows "emperor penguin"
    And no errors were logged
