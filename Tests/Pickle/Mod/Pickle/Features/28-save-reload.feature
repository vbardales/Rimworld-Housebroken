Feature: Housebroken across a save and a reload

  Background:
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
    And Housebroken lets 251 game ticks pass

  Scenario: TF-17 carried mud survives save and reload
    Given Housebroken loads "TfReduced" with carried Dirt
    And Housebroken puts "TfReduced" at "closed room"
    When I save and reload as "housebroken-tf17"
    Then Housebroken confirms that "TfReduced" carries Dirt
    And Housebroken filth rate of "TfReduced" at "closed room" is "0" times its base rate
    And Housebroken filth rate of "TfReduced" at "outdoors" is "0.3" times its base rate
    When Housebroken walks "TfReduced" for 3000 steps at "closed room"
    Then Housebroken counted no dropped filth from "TfReduced"
    And Housebroken confirms that "TfReduced" carries Dirt
    When Housebroken walks "TfReduced" for 3000 steps at "outdoors"
    Then Housebroken counted dropped filth from "TfReduced"
    And no errors were logged

  Scenario: TF-18 a game saved with the mod holds no data of it
    When Housebroken saves the game as "housebroken-tf18"
    Then Housebroken save "housebroken-tf18" holds no Housebroken data outside its mod list
    And no errors were logged
