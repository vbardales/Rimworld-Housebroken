Feature: An animal travels to another map by caravan

  Scenario: TF-19 the rate follows the map the animal is on, in transit and after arrival
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken settings are written to disk
    And Housebroken builds its test yard
    And Housebroken spawns the colony animal "TfTraveller" as "Elephant"
    And Housebroken teaches "TfTraveller" the training "Tameness"
    And Housebroken teaches "TfTraveller" the training "Obedience"
    And Housebroken teaches "TfTraveller" the training "Haul"
    Then Housebroken filth rate of "TfTraveller" at "closed room" is "0" times its base rate
    Given Housebroken founds a second colony map
    When Housebroken sends "TfTraveller" on a caravan towards the second map
    Then Housebroken filth rate of "TfTraveller" can be read while it is on a caravan
    When Housebroken lets the caravan of "TfTraveller" arrive on the second map
    Then Housebroken filth rate of "TfTraveller" is "0.3" times its base rate
    When Housebroken builds its test yard
    Then Housebroken filth rate of "TfTraveller" at "closed room" is "0" times its base rate
    And Housebroken filth rate of "TfTraveller" at "outdoors" is "0.3" times its base rate
    When Housebroken looks at the first map again
    Then no errors were logged
