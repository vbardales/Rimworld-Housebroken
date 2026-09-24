Feature: Settings read after a restart

  Scenario: TF-15 read settings after restart
    Given the save "test-colony" is loaded
    And game speed is paused
    And I close all dialogs
    Then Housebroken setting "obedientFactor" reads "0.9"
    And Housebroken setting "wellTrainedFactor" reads "0.8"
    And Housebroken setting "intermediateSpeciesFactor" reads "0.7"
    And Housebroken setting "advancedSpeciesFactor" reads "0.95"
    And Housebroken setting "colonyAnimalsOnly" reads "False"
    And Housebroken setting "manureOutdoors" reads "False"
    And Housebroken setting "wholeHomeArea" reads "True"
    And Housebroken setting "indoorFactor" reads "0.4"
    And Housebroken setting "outdoorFactor" reads "3.5"
    And Housebroken setting "wipeFeetIndoors" reads "False"
    And Housebroken setting "exemptFromAlert" reads "False"
    And no errors were logged
