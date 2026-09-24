Feature: The out-of-range settings file, read again after a restart

  Scenario: TF-22 the normalized values were written on close and come back
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    Then Housebroken setting "obedientFactor" reads "1"
    And Housebroken setting "wellTrainedFactor" reads "0"
    And Housebroken setting "intermediateSpeciesFactor" reads "0.8"
    And Housebroken setting "advancedSpeciesFactor" reads "0.6"
    And Housebroken setting "indoorFactor" reads "1"
    And Housebroken setting "outdoorFactor" reads "4"
    And no errors were logged
