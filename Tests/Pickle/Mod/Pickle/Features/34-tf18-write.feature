@requires:nelim.housebroken.pickleremoval
Feature: Save with Housebroken for removal

  Scenario: TF-18 save, check, hand over
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken settings are written to disk
    And Housebroken builds its test yard
    And Housebroken spawns the colony animal "TfReduced" as "Elephant"
    And Housebroken teaches "TfReduced" the training "Tameness"
    And Housebroken teaches "TfReduced" the training "Obedience"
    And Housebroken teaches "TfReduced" the training "Haul"
    And Housebroken loads "TfReduced" with carried Dirt
    And Housebroken puts "TfReduced" at "closed room"
    When Housebroken saves the game as "housebroken-tf18-with-mod"
    Then Housebroken save "housebroken-tf18-with-mod" holds no Housebroken data outside its mod list
    When Housebroken hands the saved game "housebroken-tf18-with-mod" to the mod "nelim.housebroken.pickleremoval"
    Then no errors were logged
