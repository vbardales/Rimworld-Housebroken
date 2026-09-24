Feature: Housebroken sliders, eligibility, catalyst

  Background:
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken settings are written to disk
    And Housebroken builds its test yard

  Scenario: TF-04 sliders, no reduction at all, and a full reduction
    Given Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken spawns the colony animal "TfElephant" as "Elephant"
    And Housebroken teaches "TfElephant" the training "Tameness"
    And Housebroken teaches "TfElephant" the training "Obedience"
    And Housebroken teaches "TfElephant" the training "Haul"
    And Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "TfElephant" is "0.15" times its base rate
    When Housebroken setting "wellTrainedFactor" is set to "0.4"
    And Housebroken setting "advancedSpeciesFactor" is set to "0.75"
    And Housebroken settings are written to disk
    Then Housebroken filth rate of "TfElephant" is "0.3" times its base rate
    When Housebroken setting "obedientFactor" is set to "1"
    And Housebroken setting "wellTrainedFactor" is set to "1"
    And Housebroken setting "intermediateSpeciesFactor" is set to "1"
    And Housebroken setting "advancedSpeciesFactor" is set to "1"
    And Housebroken setting "manureOutdoors" is set to "true"
    And Housebroken setting "wipeFeetIndoors" is set to "true"
    And Housebroken setting "exemptFromAlert" is set to "true"
    And Housebroken settings are written to disk
    Then Housebroken filth rate of "TfElephant" at "closed room" is "1" times its base rate
    And Housebroken explanation for "TfElephant" names no Housebroken factor
    And Housebroken filth rate of "TfElephant" at "outdoors" is "1" times its base rate
    When Housebroken walks "TfElephant" for 3000 steps at "closed room"
    Then Housebroken counted manure from "TfElephant"
    When Housebroken puts "TfElephant" at "closed room"
    And Housebroken recalculates the animal filth alert
    Then Housebroken alert lists "TfElephant"
    When Housebroken setting "wellTrainedFactor" is set to "0"
    And Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    Then Housebroken filth rate of "TfElephant" is "0" times its base rate
    And no errors were logged

  Scenario: TF-05 only colony animals are reduced
    Given Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken spawns the colony animal "TfColony" as "Elephant"
    And Housebroken spawns the wild animal "TfWild" as "Elephant"
    And Housebroken spawns the animal "TfOther" as "Elephant" owned by another faction
    And Housebroken spawns the colonist "TfColonist"
    And Housebroken spawns the mechanoid "TfMech" for the colony
    And Housebroken teaches "TfColony" the training "Tameness"
    Then Housebroken filth rate of "TfColony" is "0.6" times its base rate
    And Housebroken filth rate of "TfWild" is "1" times its base rate
    And Housebroken filth rate of "TfOther" is "1" times its base rate
    And Housebroken filth rate of "TfColonist" is "1" times its base rate
    And Housebroken filth rate of "TfMech" is "1" times its base rate
    When Housebroken setting "colonyAnimalsOnly" is set to "false"
    And Housebroken settings are written to disk
    Then Housebroken filth rate of "TfWild" is "0.6" times its base rate
    And Housebroken filth rate of "TfOther" is "0.6" times its base rate
    And Housebroken filth rate of "TfColonist" is "1" times its base rate
    And Housebroken filth rate of "TfMech" is "1" times its base rate
    When Housebroken setting "colonyAnimalsOnly" is set to "true"
    And Housebroken settings are written to disk
    And Housebroken gives "TfWild" to the player faction
    Then Housebroken filth rate of "TfWild" is "0.6" times its base rate
    When Housebroken removes "TfColony" from every faction
    Then Housebroken filth rate of "TfColony" is "1" times its base rate
    And no errors were logged

  @requires:ludeon.rimworld.odyssey
  Scenario: TF-06 the sentience catalyst
    Given Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken spawns the colony animal "TfCow" as "Cow"
    And Housebroken spawns the colony animal "TfRhino" as "Rhinoceros"
    And Housebroken spawns the colony animal "TfElephant" as "Elephant"
    And Housebroken teaches "TfCow" the training "Tameness"
    And Housebroken teaches "TfRhino" the training "Tameness"
    And Housebroken teaches "TfElephant" the training "Tameness"
    Then Housebroken filth rate of "TfCow" is "1" times its base rate
    And Housebroken filth rate of "TfRhino" is "0.8" times its base rate
    And Housebroken filth rate of "TfElephant" is "0.6" times its base rate
    When Housebroken gives "TfCow" the sentience catalyst
    And Housebroken gives "TfRhino" the sentience catalyst
    And Housebroken gives "TfElephant" the sentience catalyst
    And Housebroken lets 251 game ticks pass
    Then Housebroken trainability of "TfCow" is Intermediate
    And Housebroken trainability of "TfRhino" is Advanced
    And Housebroken filth rate of "TfCow" is "0.8" times its base rate
    And Housebroken filth rate of "TfRhino" is "0.6" times its base rate
    And Housebroken filth rate of "TfElephant" is "0.6" times its base rate
    And no errors were logged
