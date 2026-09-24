Feature: Nothing of a game leaks into the next one

  Scenario: TF-19 a reused ID gets its own factor
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken builds its test yard
    And Housebroken spawns the colony animal "TfFirst" as "Elephant"
    And Housebroken teaches "TfFirst" the training "Tameness"
    And Housebroken teaches "TfFirst" the training "Obedience"
    And Housebroken teaches "TfFirst" the training "Haul"
    And Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "TfFirst" is "0.15" times its base rate
    When Housebroken records the thing ID of "TfFirst"
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken builds its test yard
    And Housebroken spawns the colony animal "TfSecond" as "Elephant"
    And Housebroken teaches "TfSecond" the training "Tameness"
    And Housebroken gives "TfSecond" the thing ID recorded for "TfFirst"
    Then Housebroken filth rate of "TfSecond" is "0.6" times its base rate
    When Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "TfSecond" is "0.6" times its base rate
    And no errors were logged
