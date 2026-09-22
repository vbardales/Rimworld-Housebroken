@review @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.screenshotstudio
Feature: Housebroken hidden MainButtons shortcut

  Background:
    Given the save "nelim-zen-meadow-studio" is loaded
    And game speed is paused
    And Housebroken settings are at their documented defaults
    And I close all dialogs

  Scenario: hidden by default, live once revealed, and opening Housebroken settings
    Then Housebroken shortcut is hidden and not greyed on a clean configuration
    When Housebroken reveals its shortcut as a customization mod would
    Then Housebroken shortcut is drawn and live
    When Housebroken activates its shortcut
    Then Housebroken sees its settings dialog open
    When Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "housebroken settings opened by MainButtons"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And I close all dialogs
    And Housebroken hides its shortcut again
    Then Housebroken shortcut is not drawn
    And no errors were logged
