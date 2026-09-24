@review @requires:nelim.pickletools.screenshotmode
Feature: Older settings file

  Scenario: TF-22 missing fields take defaults
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    Then Housebroken setting "obedientFactor" reads "0.7"
    And Housebroken setting "manureOutdoors" reads "False"
    And Housebroken setting "wellTrainedFactor" reads "0.25"
    And Housebroken setting "intermediateSpeciesFactor" reads "0.8"
    And Housebroken setting "advancedSpeciesFactor" reads "0.6"
    And Housebroken setting "colonyAnimalsOnly" reads "True"
    And Housebroken setting "wholeHomeArea" reads "False"
    And Housebroken setting "indoorFactor" reads "0"
    And Housebroken setting "outdoorFactor" reads "2"
    And Housebroken setting "wipeFeetIndoors" reads "True"
    And Housebroken setting "exemptFromAlert" reads "True"
    Given Housebroken builds its test yard
    And Housebroken spawns the colony animal "TfElephant" as "Elephant"
    And Housebroken teaches "TfElephant" the training "Tameness"
    And Housebroken teaches "TfElephant" the training "Obedience"
    And Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "TfElephant" is "0.42" times its base rate
    When I open the Housebroken settings dialog
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "housebroken settings from an older file"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And I close all dialogs
    And Housebroken keeps its settings for the next launch
    Then no errors were logged
