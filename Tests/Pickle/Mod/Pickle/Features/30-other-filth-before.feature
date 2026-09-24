@requires:nelim.housebroken.pickletests.otherfilthbefore
Feature: Another mod adds a FilthRate stat part, loaded before Housebroken

  Background:
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken settings are written to disk
    And Housebroken builds its test yard
    And Housebroken spawns the colony animal "TfElephant" as "Elephant"
    And Housebroken teaches "TfElephant" the training "Tameness"
    And Housebroken teaches "TfElephant" the training "Obedience"
    And Housebroken teaches "TfElephant" the training "Haul"
    And Housebroken spawns the colony animal "TfCow" as "Cow"
    And Housebroken teaches "TfCow" the training "Tameness"

  Scenario: TF-20 both contributions stand and the Housebroken one appears once
    Then mod "nelim.housebroken.pickletests.otherfilthbefore" loads before "nelim.housebroken"
    And Housebroken filth rate of "TfCow" is "1.5" times its base rate
    And Housebroken explanation for "TfCow" names no Housebroken factor
    And Housebroken filth rate of "TfElephant" at "outdoors" is "0.45" times its base rate
    And Housebroken explanation for "TfElephant" names the training factor exactly once
    And Housebroken filth rate of "TfElephant" at "closed room" is "0" times its base rate
    When Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    Then Housebroken filth rate of "TfElephant" is "0.225" times its base rate
    And Housebroken explanation for "TfElephant" names the training factor exactly once
    And no errors were logged
