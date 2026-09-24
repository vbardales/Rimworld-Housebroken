Feature: Housebroken filth rate, from loading to the individual and species factors

  Background:
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken settings are written to disk
    And Housebroken builds its test yard

  Scenario: TF-01 loading and defaults
    Then Housebroken setting "obedientFactor" reads "0.5"
    And Housebroken setting "wellTrainedFactor" reads "0.25"
    And Housebroken setting "intermediateSpeciesFactor" reads "0.8"
    And Housebroken setting "advancedSpeciesFactor" reads "0.6"
    And Housebroken setting "colonyAnimalsOnly" reads "True"
    And Housebroken setting "manureOutdoors" reads "True"
    And Housebroken setting "wholeHomeArea" reads "False"
    And Housebroken setting "indoorFactor" reads "0"
    And Housebroken setting "outdoorFactor" reads "2"
    And Housebroken setting "wipeFeetIndoors" reads "True"
    And Housebroken setting "exemptFromAlert" reads "True"
    And Housebroken shortcut is hidden and not greyed on a clean configuration
    And no errors were logged

  Scenario: TF-02 individual and species factors multiply, and extra training does not stack
    Given Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken spawns the colony animal "TfCow" as "Cow"
    And Housebroken spawns the colony animal "TfRhino" as "Rhinoceros"
    And Housebroken spawns the colony animal "TfRhinoObey" as "Rhinoceros"
    And Housebroken spawns the colony animal "TfElephant" as "Elephant"
    And Housebroken spawns the colony animal "TfElephantObey" as "Elephant"
    And Housebroken spawns the colony animal "TfElephantOne" as "Elephant"
    And Housebroken spawns the colony animal "TfElephantSeveral" as "Elephant"
    And Housebroken teaches "TfCow" the training "Tameness"
    And Housebroken teaches "TfRhino" the training "Tameness"
    And Housebroken teaches "TfRhinoObey" the training "Tameness"
    And Housebroken teaches "TfRhinoObey" the training "Obedience"
    And Housebroken teaches "TfElephant" the training "Tameness"
    And Housebroken teaches "TfElephantObey" the training "Tameness"
    And Housebroken teaches "TfElephantObey" the training "Obedience"
    And Housebroken teaches "TfElephantOne" the training "Tameness"
    And Housebroken teaches "TfElephantOne" the training "Obedience"
    And Housebroken teaches "TfElephantOne" the training "Haul"
    And Housebroken teaches "TfElephantSeveral" the training "Tameness"
    And Housebroken teaches "TfElephantSeveral" the training "Obedience"
    And Housebroken teaches "TfElephantSeveral" the training "Haul"
    And Housebroken teaches "TfElephantSeveral" the training "Rescue"
    And Housebroken teaches "TfElephantSeveral" the training "Release"
    Then Housebroken trainability of "TfCow" is None
    And Housebroken trainability of "TfRhino" is Intermediate
    And Housebroken trainability of "TfElephant" is Advanced
    And Housebroken filth rate of "TfCow" is "1" times its base rate
    And Housebroken filth rate of "TfRhino" is "0.8" times its base rate
    And Housebroken filth rate of "TfElephant" is "0.6" times its base rate
    And Housebroken filth rate of "TfRhinoObey" is "0.4" times its base rate
    And Housebroken filth rate of "TfElephantObey" is "0.3" times its base rate
    And Housebroken filth rate of "TfElephantOne" is "0.15" times its base rate
    And Housebroken filth rate of "TfElephantSeveral" is "0.15" times its base rate
    And Housebroken explanation for "TfCow" names no Housebroken factor
    And Housebroken explanation for "TfElephantOne" names the training factor
    And Housebroken explanation for "TfElephantOne" names no location rule
    And no errors were logged

  Scenario: TF-03 learning and losing training moves the rate step by step
    Given Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken spawns the colony animal "TfElephant" as "Elephant"
    And Housebroken teaches "TfElephant" the training "Tameness"
    Then Housebroken filth rate of "TfElephant" is "0.6" times its base rate
    When Housebroken half-teaches "TfElephant" the training "Obedience"
    And Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "TfElephant" is "0.6" times its base rate
    When Housebroken teaches "TfElephant" the training "Obedience"
    And Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "TfElephant" is "0.3" times its base rate
    When Housebroken teaches "TfElephant" the training "Haul"
    And Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "TfElephant" is "0.15" times its base rate
    When Housebroken makes "TfElephant" forget the training "Haul"
    And Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "TfElephant" is "0.3" times its base rate
    When Housebroken makes "TfElephant" forget the training "Obedience"
    And Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "TfElephant" is "0.6" times its base rate
    And no errors were logged
