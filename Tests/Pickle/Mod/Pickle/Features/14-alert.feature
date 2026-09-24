Feature: Housebroken and the animal filth alert

  Background:
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken builds its test yard

  Scenario: TF-13 the alert exemption
    Given Housebroken spawns the colony animal "TfElephant" as "Elephant"
    And Housebroken teaches "TfElephant" the training "Tameness"
    And Housebroken teaches "TfElephant" the training "Obedience"
    When Housebroken puts "TfElephant" at "closed room"
    Then Housebroken filth rate of "TfElephant" is "0.3" times its base rate
    When Housebroken setting "exemptFromAlert" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken recalculates the animal filth alert
    Then Housebroken alert lists "TfElephant"
    When Housebroken setting "exemptFromAlert" is set to "true"
    And Housebroken settings are written to disk
    And Housebroken recalculates the animal filth alert
    Then Housebroken alert does not list "TfElephant"
    When Housebroken setting "exemptFromAlert" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken recalculates the animal filth alert
    Then Housebroken alert lists "TfElephant"
    And no errors were logged

  Scenario: TF-14 a mixed list in the alert
    Given Housebroken spawns the colony animal "TfReducedOne" as "Elephant"
    And Housebroken spawns the colony animal "TfReducedTwo" as "Elephant"
    And Housebroken spawns the colony animal "TfCowOne" as "Cow"
    And Housebroken spawns the colony animal "TfCowTwo" as "Cow"
    And Housebroken teaches "TfReducedOne" the training "Tameness"
    And Housebroken teaches "TfReducedOne" the training "Obedience"
    And Housebroken teaches "TfReducedTwo" the training "Tameness"
    And Housebroken teaches "TfReducedTwo" the training "Obedience"
    And Housebroken teaches "TfCowOne" the training "Tameness"
    And Housebroken teaches "TfCowTwo" the training "Tameness"
    And Housebroken setting "exemptFromAlert" is set to "false"
    And Housebroken settings are written to disk
    When Housebroken puts "TfReducedOne" at "closed room"
    And Housebroken puts "TfReducedTwo" at "closed room"
    And Housebroken puts "TfCowOne" at "closed room"
    And Housebroken puts "TfCowTwo" at "closed room"
    And Housebroken recalculates the animal filth alert
    Then Housebroken alert lists "TfReducedOne"
    And Housebroken alert lists "TfReducedTwo"
    And Housebroken alert lists "TfCowOne"
    And Housebroken alert lists "TfCowTwo"
    When Housebroken setting "exemptFromAlert" is set to "true"
    And Housebroken settings are written to disk
    And Housebroken recalculates the animal filth alert
    Then Housebroken alert does not list "TfReducedOne"
    And Housebroken alert does not list "TfReducedTwo"
    And Housebroken alert lists "TfCowOne"
    And Housebroken alert lists "TfCowTwo"
    And Housebroken alert entries all name their own target
    When Housebroken puts "TfCowTwo" at "outdoors"
    And Housebroken recalculates the animal filth alert
    Then Housebroken alert lists "TfCowOne"
    And Housebroken alert does not list "TfCowTwo"
    And Housebroken alert entries all name their own target
    When Housebroken puts "TfCowOne" at "outdoors"
    And Housebroken recalculates the animal filth alert
    Then Housebroken alert does not list "TfCowOne"
    And Housebroken alert does not list "TfReducedOne"
    And Housebroken alert does not list "TfReducedTwo"
    And no errors were logged
