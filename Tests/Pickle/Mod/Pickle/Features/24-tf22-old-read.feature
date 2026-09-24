Feature: The older settings file, read again after a restart

  Scenario: TF-22 the values written on close come back, and the original file is put back
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    Then Housebroken setting "obedientFactor" reads "0.7"
    And Housebroken setting "manureOutdoors" reads "False"
    And Housebroken setting "wellTrainedFactor" reads "0.25"
    And Housebroken setting "outdoorFactor" reads "2"
    And Housebroken setting "exemptFromAlert" reads "True"
    And no errors were logged
