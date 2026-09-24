Feature: Housebroken settings are written for a separate-process restart

  Scenario: TF-15 write a distinctive value for every setting and keep the file for the next launch
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    When Housebroken setting "obedientFactor" is set to "0.9"
    And Housebroken setting "wellTrainedFactor" is set to "0.8"
    And Housebroken setting "intermediateSpeciesFactor" is set to "0.7"
    And Housebroken setting "advancedSpeciesFactor" is set to "0.95"
    And Housebroken setting "colonyAnimalsOnly" is set to "false"
    And Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken setting "wholeHomeArea" is set to "true"
    And Housebroken setting "indoorFactor" is set to "0.4"
    And Housebroken setting "outdoorFactor" is set to "3.5"
    And Housebroken setting "wipeFeetIndoors" is set to "false"
    And Housebroken setting "exemptFromAlert" is set to "false"
    And I open the Housebroken settings dialog
    And I close all dialogs
    And Housebroken keeps its settings for the next launch
    Then no errors were logged
