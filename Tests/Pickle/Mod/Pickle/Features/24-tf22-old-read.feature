Feature: Older settings file, after restart

  Scenario: TF-22 old file, read after restart
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    Then Housebroken setting "obedientFactor" reads "0.7"
    And Housebroken setting "manureOutdoors" reads "False"
    And Housebroken setting "wellTrainedFactor" reads "0.25"
    And Housebroken setting "outdoorFactor" reads "2"
    And Housebroken setting "exemptFromAlert" reads "True"
    And no errors were logged
