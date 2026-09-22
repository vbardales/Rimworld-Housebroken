@review @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.screenshotstudio
Feature: Housebroken settings in the startup language

  Background:
    Given the save "nelim-zen-meadow-studio" is loaded
    And game speed is paused
    And Housebroken settings are at their documented defaults
    And I close all dialogs

  Scenario: the native settings page is available in this pass language
    When I open the Housebroken settings dialog
    Then Housebroken sees its settings dialog open
    When Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "housebroken settings in this startup language"
    And Nelim's Pickle Tools: screenshot mode is disabled
    Then no errors were logged
    When I close all dialogs
