@review @gallery @requires:nelim.sanctuarybacklot @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.screenshotmode
Feature: Housebroken gallery photographs, on the Sanctuaire de Nelim

  # Two families of steps, told apart by their prefix:
  #   "Nelim's Sanctuary: ..."      SB, the SanctuaryBacklot repository: the save, the named places (frame, animals removed).
  #   "Nelim's Pickle Tools: ..."   NPT, PickleTools: the animals, the decor, screenshot mode.
  #   "Housebroken ..."             this mod's own steps (training, rates).
  #
  # Story: Nelim keeps a husky and a cow. Rex was taught tameness, obedience and hauling; Daisy the cow was only tamed
  # (a cow has no species reduction, a husky has, so she is the honest control). Indoors, in the hearth hall, Daisy leaves
  # a mess and Rex keeps it to himself. Outdoors, in the statue garden, Rex lets it go. Each picture asserts the stat it
  # shows, so a green run says the stat is right; whether the picture shows it is read by eye (run 2026-10-07 was green
  # with both subjects out of frame).
  # Places chosen from SANCTUAIRE-LIEUX.md and SANCTUAIRE-CASES.md: only a roofed room of the home area shows the indoor
  # rule, so the hearth hall (x 172-190, z 106-124, cells (184,120), (187,120) and (188,120) are free there, away from the doors); open ground
  # with a real garden behind it for the outdoor rule, so the statue garden. Neither is cleared or re-roofed. The frame is
  # the cell at zoom 11. The animals wander during the 251 ticks the rate cache needs (a run of 2026-10-08 lost Rex out of the
  # hall and another out of the frame), so each is put back near its cell afterwards by this mod's own step; the rate is read there. The dropping is not a placed prop: the animal steps in place through the game's own entry point, so what lies on its cell is what the mod lets through (the cow leaves one, Rex indoors none).

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken settings are written to disk

  Scenario: Gallery 1, indoors the trained husky keeps it to himself
    Given Nelim's Sanctuary: I am at the sanctuary "hearth-hall"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "hearth-hall"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Rex" is spawned at (184, 120)
    And Nelim's Pickle Tools: an adult animal of kind "Cow" named "Daisy" is spawned at (187, 120)
    And Housebroken teaches "Rex" the training "Tameness"
    And Housebroken teaches "Rex" the training "Obedience"
    And Housebroken teaches "Rex" the training "Haul"
    And Housebroken teaches "Daisy" the training "Tameness"
    And Housebroken lets 251 game ticks pass
    And Housebroken puts "Rex" at the cell (184, 120)
    And Housebroken puts "Daisy" at the cell (187, 120)
    Then Housebroken filth rate of "Rex" is "0" times its base rate
    And Housebroken filth rate of "Daisy" is "1" times its base rate
    When Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken lets "Rex" step 2000 times where it stands
    Then Housebroken finds animal filth on the cell of "Daisy"
    And Housebroken finds no animal filth on the cell of "Rex"
    When Nelim's Pickle Tools: I frame the cell (185, 118) at zoom 11
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery indoors"
    And Nelim's Pickle Tools: screenshot mode is disabled
    Then no errors were logged

  Scenario: Gallery 2, outdoors the trained husky lets it go
    Given Nelim's Sanctuary: I am at the sanctuary "statue-garden"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Rex" is spawned at (152, 95)
    And Housebroken teaches "Rex" the training "Tameness"
    And Housebroken teaches "Rex" the training "Obedience"
    And Housebroken teaches "Rex" the training "Haul"
    And Housebroken lets 251 game ticks pass
    And Housebroken puts "Rex" at the cell (152, 95)
    Then Housebroken filth rate of "Rex" is "0.3" times its base rate
    When Housebroken lets "Rex" step 4000 times where it stands
    Then Housebroken finds animal filth within 2 cells of "Rex"
    And Nelim's Pickle Tools: I frame the cell (152, 95) at zoom 11
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery outdoors"
    And Nelim's Pickle Tools: screenshot mode is disabled
    Then no errors were logged
