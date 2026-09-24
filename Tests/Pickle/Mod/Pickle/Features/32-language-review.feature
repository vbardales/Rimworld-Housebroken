@review @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.interfacescale @requires:nelim.pickletools.keyedclick @requires:nelim.pickletools.hoversteps
Feature: The Housebroken settings page at the sizes a player uses, in the language of the pass

  Background:
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken settings are written to disk

  Scenario: TF-16 the page draws at 100 and at 200 percent, and the reset confirmation fits
    When I open the Housebroken settings dialog
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "housebroken settings page at 100 percent"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: the interface scale is 200 percent
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "housebroken settings page at 200 percent"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: I click button keyed "Housebroken.Settings.Reset"
    Then window "Dialog_MessageBox" is open
    When Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "housebroken reset confirmation at 200 percent"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: I click button keyed "GoBack"
    And I close all dialogs
    Then no errors were logged

  Scenario: TF-16 every tooltip of the page is drawn, and read
    When I open the Housebroken settings dialog
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And Nelim's Pickle Tools: I hover over the tooltip keyed "Housebroken.Settings.ObedientTip"
    Then Nelim's Pickle Tools: the tooltip keyed "Housebroken.Settings.ObedientTip" is drawn
    When I take a screenshot "housebroken tooltip obedience"
    And Nelim's Pickle Tools: I hover over the tooltip keyed "Housebroken.Settings.WellTrainedTip"
    And I take a screenshot "housebroken tooltip further training"
    And Nelim's Pickle Tools: I hover over the tooltip keyed "Housebroken.Settings.AdvancedTip"
    And I take a screenshot "housebroken tooltip advanced species"
    And Nelim's Pickle Tools: I hover over the tooltip keyed "Housebroken.Settings.ColonyOnlyTip"
    And I take a screenshot "housebroken tooltip colony only"
    And Nelim's Pickle Tools: I hover over the tooltip keyed "Housebroken.Settings.ManureOutdoorsTip"
    And I take a screenshot "housebroken tooltip manure outside"
    And Nelim's Pickle Tools: I hover over the tooltip keyed "Housebroken.Settings.WholeHomeAreaTip"
    And I take a screenshot "housebroken tooltip whole home area"
    And Nelim's Pickle Tools: I hover over the tooltip keyed "Housebroken.Settings.IndoorTip"
    And I take a screenshot "housebroken tooltip indoor"
    And Nelim's Pickle Tools: I hover over the tooltip keyed "Housebroken.Settings.OutdoorTip"
    And I take a screenshot "housebroken tooltip outdoor"
    And Nelim's Pickle Tools: I hover over the tooltip keyed "Housebroken.Settings.WipeFeetTip"
    And I take a screenshot "housebroken tooltip clean feet"
    And Nelim's Pickle Tools: I hover over the tooltip keyed "Housebroken.Settings.ExemptAlertTip"
    And I take a screenshot "housebroken tooltip alert exemption"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And I close all dialogs
    Then no errors were logged
