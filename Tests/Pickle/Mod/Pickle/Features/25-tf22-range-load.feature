@review @requires:nelim.pickletools.screenshotmode
Feature: Out-of-range settings file

  Scenario: TF-22 out-of-range values are normalized
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    Then Housebroken setting "obedientFactor" reads "1"
    And Housebroken setting "wellTrainedFactor" reads "0"
    And Housebroken setting "intermediateSpeciesFactor" reads "0.8"
    And Housebroken setting "advancedSpeciesFactor" reads "0.6"
    And Housebroken setting "indoorFactor" reads "1"
    And Housebroken setting "outdoorFactor" reads "4"
    Given Housebroken builds its test yard
    And Housebroken spawns the colony animal "TfTame" as "Elephant"
    And Housebroken spawns the colony animal "TfObey" as "Elephant"
    And Housebroken spawns the colony animal "TfMore" as "Elephant"
    And Housebroken teaches "TfTame" the training "Tameness"
    And Housebroken teaches "TfObey" the training "Tameness"
    And Housebroken teaches "TfObey" the training "Obedience"
    And Housebroken teaches "TfMore" the training "Tameness"
    And Housebroken teaches "TfMore" the training "Obedience"
    And Housebroken teaches "TfMore" the training "Haul"
    And Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "TfTame" at "outdoors" is "2.4" times its base rate
    And Housebroken filth rate of "TfTame" at "closed room" is "0.6" times its base rate
    And Housebroken filth rate of "TfObey" at "closed room" is "0.6" times its base rate
    And Housebroken filth rate of "TfMore" at "outdoors" is "0" times its base rate
    And Housebroken filth rate of "TfMore" at "closed room" is "0" times its base rate
    When I open the Housebroken settings dialog
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "housebroken settings from an out-of-range file"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And I close all dialogs
    And Housebroken keeps its settings for the next launch
    Then no errors were logged
