@review @rimmsqol @requires:MalteSchulze.RIMMSqol @requires:nelim.pickletools.rimmsqol @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.screenshotstudio
Feature: RIMMSQOL reveals the Housebroken shortcut

  Background:
    Given the save "nelim-zen-meadow-studio" is loaded
    And game speed is paused
    And I close all dialogs
    Then mod "MalteSchulze.RIMMSqol" is loaded
    And RIMMSQOL is ready to be driven

  Scenario: the shortcut is listed hidden, revealed, activated, hidden and forgotten
    Then RIMMSQOL's own list of main buttons offers "Housebroken_Settings"
    And RIMMSQOL shows the main button "Housebroken_Settings" as hidden
    And the main bar does not draw the button "Housebroken_Settings"
    When RIMMSQOL reveals the main button "Housebroken_Settings"
    Then the main bar draws the button "Housebroken_Settings"
    When the main bar's button "Housebroken_Settings" is activated
    Then Housebroken sees its settings dialog open
    When Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "housebroken settings opened after RIMMSQOL reveal"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And I close all dialogs
    And RIMMSQOL hides the main button "Housebroken_Settings"
    Then the main bar does not draw the button "Housebroken_Settings"
    When RIMMSQOL forgets its choice for the main button "Housebroken_Settings"
    Then RIMMSQOL holds no choice for the main button "Housebroken_Settings"
