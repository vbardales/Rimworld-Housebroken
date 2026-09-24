Feature: Housebroken deposits: manure while walking, and mud and blood carried

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
    And Housebroken spawns the colony animal "TfControl" as "Cow"
    And Housebroken teaches "TfControl" the training "Tameness"

  Scenario: TF-10 manure while moving: none inside by default, some outside, and again inside once the rule is off
    Then Housebroken filth rate of "TfControl" is "1" times its base rate
    When Housebroken walks "TfReduced" for 3000 steps at "closed room"
    Then Housebroken counted no manure from "TfReduced"
    When Housebroken walks "TfReduced" for 3000 steps at "outdoors"
    Then Housebroken counted manure from "TfReduced"
    When Housebroken walks "TfControl" for 3000 steps at "closed room"
    Then Housebroken counted manure from "TfControl"
    When Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken walks "TfReduced" for 3000 steps at "closed room"
    Then Housebroken counted manure from "TfReduced"
    And no errors were logged

  Scenario: TF-11 carried mud is held inside and released outside
    Given Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken loads "TfReduced" with carried Dirt
    And Housebroken loads "TfControl" with carried Dirt
    When Housebroken walks "TfControl" for 3000 steps at "closed room"
    Then Housebroken counted dropped filth from "TfControl"
    When Housebroken walks "TfReduced" for 3000 steps at "closed room"
    Then Housebroken counted no dropped filth from "TfReduced"
    And Housebroken confirms that "TfReduced" carries Dirt
    When Housebroken walks "TfReduced" for 3000 steps at "outdoors"
    Then Housebroken counted dropped filth from "TfReduced"
    When Housebroken setting "wipeFeetIndoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken walks "TfReduced" for 3000 steps at "closed room"
    Then Housebroken counted dropped filth from "TfReduced"
    And no errors were logged

  Scenario: TF-11 carried blood is held inside and released outside
    Given Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken loads "TfReduced" with carried Blood
    And Housebroken loads "TfControl" with carried Blood
    When Housebroken walks "TfControl" for 3000 steps at "closed room"
    Then Housebroken counted dropped filth from "TfControl"
    When Housebroken walks "TfReduced" for 3000 steps at "closed room"
    Then Housebroken counted no dropped filth from "TfReduced"
    And Housebroken confirms that "TfReduced" carries Blood
    When Housebroken walks "TfReduced" for 3000 steps at "outdoors"
    Then Housebroken counted dropped filth from "TfReduced"
    And no errors were logged

  Scenario: TF-12 the two options are independent, and whole-home mode governs feet on its own
    Given Housebroken loads "TfReduced" with carried Dirt
    When Housebroken walks "TfReduced" for 3000 steps at "closed room"
    Then Housebroken counted no manure from "TfReduced"
    And Housebroken counted no dropped filth from "TfReduced"
    When Housebroken setting "wipeFeetIndoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken walks "TfReduced" for 3000 steps at "closed room"
    Then Housebroken counted no manure from "TfReduced"
    And Housebroken counted dropped filth from "TfReduced"
    When Housebroken setting "manureOutdoors" is set to "false"
    And Housebroken settings are written to disk
    And Housebroken walks "TfReduced" for 3000 steps at "closed room"
    Then Housebroken counted manure from "TfReduced"
    And Housebroken counted dropped filth from "TfReduced"
    When Housebroken setting "wipeFeetIndoors" is set to "true"
    And Housebroken settings are written to disk
    And Housebroken walks "TfReduced" for 3000 steps at "closed room"
    Then Housebroken counted manure from "TfReduced"
    And Housebroken counted no dropped filth from "TfReduced"
    When Housebroken walks "TfReduced" for 3000 steps at "unroofed pen"
    Then Housebroken counted dropped filth from "TfReduced"
    When Housebroken setting "wholeHomeArea" is set to "true"
    And Housebroken settings are written to disk
    And Housebroken walks "TfReduced" for 3000 steps at "unroofed pen"
    Then Housebroken counted no dropped filth from "TfReduced"
    When Housebroken setting "manureOutdoors" is set to "true"
    And Housebroken settings are written to disk
    And Housebroken walks "TfReduced" for 3000 steps at "unroofed pen"
    Then Housebroken counted no manure from "TfReduced"
    And Housebroken counted no dropped filth from "TfReduced"
    And no errors were logged
