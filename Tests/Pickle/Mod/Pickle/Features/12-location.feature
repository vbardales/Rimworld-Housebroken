Feature: Housebroken holds it inside the base and lets it out

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

  Scenario: TF-07 the boundaries of the base
    Then Housebroken filth rate of "TfElephant" at "closed room" is "0" times its base rate
    And Housebroken explanation for "TfElephant" names the holding rule
    And Housebroken filth rate of "TfElephant" at "unroofed pen" is "0.3" times its base rate
    And Housebroken explanation for "TfElephant" names the outside rule
    And Housebroken filth rate of "TfElephant" at "roofed room outside home" is "0.3" times its base rate
    And Housebroken filth rate of "TfElephant" at "outdoors" is "0.3" times its base rate
    And Housebroken filth rate of "TfElephant" at "doorway" is "0.3" times its base rate
    And Housebroken explanation for "TfElephant" names the outside rule
    And Housebroken filth rate of "TfElephant" at "edge room" is "0.3" times its base rate
    And Housebroken explanation for "TfElephant" names the outside rule
    And Housebroken filth rate of "TfElephant" at "closed room" is "0" times its base rate
    And no errors were logged

  Scenario: TF-08 the whole home area counts as inside
    Given Housebroken setting "wholeHomeArea" is set to "true"
    And Housebroken settings are written to disk
    Then Housebroken filth rate of "TfElephant" at "closed room" is "0" times its base rate
    And Housebroken filth rate of "TfElephant" at "unroofed pen" is "0" times its base rate
    And Housebroken filth rate of "TfElephant" at "doorway" is "0" times its base rate
    And Housebroken filth rate of "TfElephant" at "edge room" is "0" times its base rate
    And Housebroken filth rate of "TfElephant" at "roofed room outside home" is "0.3" times its base rate
    And Housebroken filth rate of "TfElephant" at "outdoors" is "0.3" times its base rate
    When Housebroken puts "TfElephant" at "unroofed pen"
    And Housebroken removes the home area from the cell of "TfElephant"
    Then Housebroken filth rate of "TfElephant" is "0.3" times its base rate
    When Housebroken restores the home area on the cell of "TfElephant"
    Then Housebroken filth rate of "TfElephant" is "0" times its base rate
    And no errors were logged

  Scenario: TF-09 the indoor and outdoor factors, and switching the rule off
    Given Housebroken setting "indoorFactor" is set to "0.5"
    And Housebroken setting "outdoorFactor" is set to "3"
    And Housebroken settings are written to disk
    Then Housebroken filth rate of "TfElephant" at "closed room" is "0.075" times its base rate
    And Housebroken filth rate of "TfElephant" at "outdoors" is "0.45" times its base rate
    When Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    Then Housebroken filth rate of "TfElephant" at "closed room" is "0.15" times its base rate
    And Housebroken explanation for "TfElephant" names no location rule
    And Housebroken filth rate of "TfElephant" at "outdoors" is "0.15" times its base rate
    And Housebroken explanation for "TfElephant" names no location rule
    And no errors were logged
