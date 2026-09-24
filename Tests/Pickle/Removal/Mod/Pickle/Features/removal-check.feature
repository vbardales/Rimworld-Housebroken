Feature: A game saved with Housebroken, loaded without it

  Scenario: TF-18 the game loads and runs without Housebroken, and saves again
    Given mod "nelim.housebroken" is not loaded
    And the save "housebroken-tf18-with-mod" is loaded
    And game speed is fast
    When I wait 250 ticks
    Then no errors were logged
    And the engine is alive
    When I save and reload as "housebroken-tf18-without-mod"
    Then no errors were logged
    And the engine is alive
