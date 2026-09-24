@review @rimmsqol @requires:MalteSchulze.RIMMSqol @requires:nelim.pickletools.rimmsqol @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.hoversteps
Feature: Settings routes

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
    Then mod "MalteSchulze.RIMMSqol" is loaded
    And RIMMSQOL is ready to be driven

  Scenario: TF-21 shortcut and Mod options routes
    Then Housebroken shortcut is hidden and not greyed on a clean configuration
    When RIMMSQOL reveals the main button "Housebroken_Settings"
    Then the main bar draws the button "Housebroken_Settings"
    When I take a screenshot "housebroken shortcut revealed on the main bar"
    And Nelim's Pickle Tools: I hover over the tooltip containing "Housebroken"
    Then Nelim's Pickle Tools: the tooltip containing "Housebroken" is drawn
    When I take a screenshot "housebroken shortcut tooltip on the main bar"
    When the main bar's button "Housebroken_Settings" is activated
    Then Housebroken sees its settings dialog open
    When Housebroken setting "wellTrainedFactor" is set to "0.5"
    And I close all dialogs
    And I open the Housebroken settings dialog
    Then Housebroken setting "wellTrainedFactor" reads "0.5"
    And Housebroken filth rate of "TfElephant" at "outdoors" is "0.6" times its base rate
    When Housebroken setting "wellTrainedFactor" is set to "0.1"
    And I close all dialogs
    And the main bar's button "Housebroken_Settings" is activated
    Then Housebroken sees its settings dialog open
    And Housebroken setting "wellTrainedFactor" reads "0.1"
    And Housebroken filth rate of "TfElephant" at "outdoors" is "0.12" times its base rate
    When I close all dialogs
    And RIMMSQOL hides the main button "Housebroken_Settings"
    And Housebroken lets 120 frames pass
    Then the main bar does not draw the button "Housebroken_Settings"
    And Housebroken shortcut is not drawn
    And no errors were logged
