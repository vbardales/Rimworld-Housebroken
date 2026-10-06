@review @gallery @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.stagedecor @requires:nelim.pickletools.screenshotmode
Feature: Housebroken gallery photographs, on the Sanctuaire de Nelim

  # Story: Nelim keeps a husky and a cow. Rex was taught tameness, obedience and hauling; Daisy the cow was only tamed (a cow has no species reduction, a husky has, so she is the honest control).
  # Indoors, in the hearth hall, Daisy leaves a mess and Rex keeps it to himself. Outdoors, in the statue garden,
  # Rex lets it go. Each picture asserts the stat it shows, so a green run proves the picture means what it says.
  # Coordinates are first guesses on the final Nelims-tribe fixture: a blocked cell fails the step by naming it.
  # Places chosen after reading all of docs/SANCTUAIRE-LIEUX.md: only a roofed room of the home area shows the indoor
  # rule, so the hearth hall (Nelim's own house); and open ground with a real garden behind it for the outdoor rule,
  # so the statue garden. Neither is cleared or re-roofed; the animals already there are removed from the hall only.

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken settings are written to disk

  Scenario: Gallery 1, indoors the trained husky keeps it to himself
    Given Nelim's Pickle Tools: I am at the sanctuary "hearth-hall"
    And Nelim's Pickle Tools: the animals are removed from the sanctuary "hearth-hall"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Rex" is spawned at (183, 111)
    And Nelim's Pickle Tools: an adult animal of kind "Cow" named "Daisy" is spawned at (186, 111)
    And Housebroken teaches "Rex" the training "Tameness"
    And Housebroken teaches "Rex" the training "Obedience"
    And Housebroken teaches "Rex" the training "Haul"
    And Housebroken teaches "Daisy" the training "Tameness"
    And Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "Rex" is "0" times its base rate
    And Housebroken filth rate of "Daisy" is "1" times its base rate
    When Nelim's Pickle Tools: I place the decor "Filth_AnimalFilth" at (187, 111)
    And Nelim's Pickle Tools: I frame the animal "Rex" at zoom 8
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery indoors"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged

  Scenario: Gallery 2, outdoors the trained husky lets it go
    Given Nelim's Pickle Tools: I am at the sanctuary "statue-garden"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Rex" is spawned at (152, 95)
    And Housebroken teaches "Rex" the training "Tameness"
    And Housebroken teaches "Rex" the training "Obedience"
    And Housebroken teaches "Rex" the training "Haul"
    And Housebroken lets 251 game ticks pass
    Then Housebroken filth rate of "Rex" is "0.3" times its base rate
    When Nelim's Pickle Tools: I place the decor "Filth_AnimalFilth" at (151, 95)
    And Nelim's Pickle Tools: I frame the animal "Rex" at zoom 8
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery outdoors"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged
