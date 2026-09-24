@review @requires:nelim.pickletools.keyedclick @requires:nelim.pickletools.screenshotmode
Feature: Housebroken settings and reset

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
    And Housebroken lets 251 game ticks pass

  Scenario: TF-15 change, cancel reset, confirm reset
    Given Housebroken setting "obedientFactor" is set to "0.9"
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
    When I open the Housebroken settings dialog
    And I close all dialogs
    Then Housebroken filth rate of "TfElephant" is "0.76" times its base rate
    When I open the Housebroken settings dialog
    And Nelim's Pickle Tools: I click button keyed "Housebroken.Settings.Reset"
    Then window "Dialog_MessageBox" is open
    When Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "housebroken reset confirmation"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: I click button keyed "GoBack"
    Then Housebroken setting "obedientFactor" reads "0.9"
    And Housebroken setting "outdoorFactor" reads "3.5"
    And Housebroken setting "exemptFromAlert" reads "False"
    When Nelim's Pickle Tools: I click button keyed "Housebroken.Settings.Reset"
    And Nelim's Pickle Tools: I click button keyed "Confirm"
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
    When I close all dialogs
    Then Housebroken filth rate of "TfElephant" at "outdoors" is "0.3" times its base rate
    And Housebroken filth rate of "TfElephant" at "closed room" is "0" times its base rate
    And no errors were logged
