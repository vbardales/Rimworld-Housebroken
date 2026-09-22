@review @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.screenshotstudio
Feature: Housebroken settings in the native mod options dialog

  Background:
    Given the save "nelim-zen-meadow-studio" is loaded
    And game speed is paused
    And Housebroken settings are at their documented defaults
    And I close all dialogs

  Scenario: the primary options page draws and writes the same global settings
    When I open the Housebroken settings dialog
    Then Housebroken sees its settings dialog open
    When Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "housebroken settings page"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Housebroken setting "outdoorFactor" is set to "3"
    And I close all dialogs
    And Housebroken settings are written to disk
    And I open the Housebroken settings dialog
    Then Housebroken setting "outdoorFactor" reads "3"
    And no errors were logged
    When I close all dialogs
