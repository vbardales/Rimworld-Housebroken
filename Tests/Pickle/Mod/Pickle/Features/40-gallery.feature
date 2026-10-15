@review @gallery @timeout:600 @requires:nelim.sanctuarybacklot @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.colonistrace @requires:lucius.eyegenes3 @requires:nelim.pickletools.camerazoom
Feature: Housebroken gallery photographs, A morning with Rex, on the Sanctuaire de Nelim

  # Two families of steps, told apart by their prefix:
  #   "Nelim's Sanctuary: ..."      SB, the SanctuaryBacklot repository: the save, the named places, Nelim's own face.
  #   "Nelim's Pickle Tools: ..."   NPT, PickleTools: animals, pawns, camera, screenshot mode.
  #   "Housebroken ..."             this mod's own steps (training, rates).
  #
  # Story (owner's rule 2026-10-14: Nelim is the protagonist; Nelim is Virginie): one morning. Nelim keeps a husky, Rex, and a cow, Daisy.
  # Rex was taught tameness, obedience and hauling; Daisy was only tamed (a cow has no species reduction, a husky has, so she is the honest control).
  # Cast: Nelim in her fixture look (her hair, her smirk, her brown eyes, her trousers) with a teal basic shirt, the one colour that stands out of
  # the brown boards, the orange rugs and the cream floor; Rex and Daisy stand facing South, so the animals are seen from the front.
  # Not changed on purpose: her hair and face (they are Virginie's, the fixture owns them). Her expression stays the smirk of "Nelim has her own face".
  #
  # Shot plan, one line per image (GALLERY.md, "Une photo mise en scene"):
  #   1  hearth-hall, 09:00 plus the 251 ticks the rate cache needs. Wide, zoom 6 on (186, 119): Rex at (184, 120), Nelim at (186, 120), Daisy at (188, 120),
  #      all facing South; the cow's dropping on her cell, nothing on Rex's. Says: the same hall, two animals, one mess.
  #   2  hearth-hall, 09:00 plus 460 ticks. Close, zoom 3.5 on (185, 119): Nelim and Rex side by side facing South, the boards clean around them, the cow out of
  #      the frame (removed for this picture). Says: the trained husky keeps his manners indoors.
  #   3  calm-zone, 11:00. Zoom 5 on (199, 187): Nelim at (198, 187), Rex at (200, 187), both facing South on the cream built floor, his dropping on the floor at his feet.
  #      Says: outside, on built floor, he lets it go.
  # Each picture asserts the stat it shows, so a green run says the stat is right; whether the picture shows it is read by eye (run 2026-10-07 was green
  # with both subjects out of frame). The subtitle of each picture is added afterwards by scripts/Add-Subtitle.ps1 (text in PUBLICATION.md).
  # Places chosen from SANCTUAIRE-LIEUX.md and SANCTUAIRE-CASES.md: only a roofed room of the home area shows the indoor rule, so the hearth hall
  # (x 172-190, z 106-124; cells (184,120), (187,120), (188,120) free there, away from the doors); open ground with a built floor for the outdoor rule,
  # so the calm zone. Neither is cleared or re-roofed. The animals wander during the 251 ticks the rate cache needs, so each is put back near its cell
  # afterwards by this mod's own step. The dropping is not a placed prop: the animal steps in place through the game's own entry point.
  # NOT PLAYED YET: the cells of Nelim ((186,120), (185,120), (198,187)), the zooms and the facing are plans until a run is read by eye.

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken settings are written to disk

  Scenario: Gallery 1, the hall: Daisy leaves a mess, Rex keeps it to himself
    Given I set the hour to 9
    And Nelim's Sanctuary: I am at the sanctuary "hearth-hall"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "hearth-hall"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Rex" is spawned at (184, 120)
    And Nelim's Pickle Tools: an adult animal of kind "Cow" named "Daisy" is spawned at (188, 120)
    And Housebroken teaches "Rex" the training "Tameness"
    And Housebroken teaches "Rex" the training "Obedience"
    And Housebroken teaches "Rex" the training "Haul"
    And Housebroken teaches "Daisy" the training "Tameness"
    And Housebroken lets 251 game ticks pass
    And Housebroken puts "Rex" at the cell (184, 120)
    And Housebroken puts "Daisy" at the cell (188, 120)
    Then Housebroken filth rate of "Rex" is "0" times its base rate
    And Housebroken filth rate of "Daisy" is "1" times its base rate
    When Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken lets "Rex" step 2000 times where it stands
    Then Housebroken finds animal filth on the cell of "Daisy"
    And Housebroken finds no animal filth on the cell of "Rex"
    Given Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" stands at (186, 120) facing South
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: the animal "Rex" stands at (184, 120) facing South
    And Nelim's Pickle Tools: the animal "Daisy" stands at (188, 120) facing South
    When Nelim's Pickle Tools: I frame the cell (186, 119) at zoom 6
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery 1 the hall"
    And Nelim's Pickle Tools: screenshot mode is disabled
    Then no errors were logged

  Scenario: Gallery 2, the lesson: Rex keeps his manners indoors
    Given I set the hour to 9
    And Nelim's Sanctuary: I am at the sanctuary "hearth-hall"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "hearth-hall"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Rex" is spawned at (186, 120)
    And Housebroken teaches "Rex" the training "Tameness"
    And Housebroken teaches "Rex" the training "Obedience"
    And Housebroken teaches "Rex" the training "Haul"
    And Housebroken lets 460 game ticks pass
    And Housebroken puts "Rex" at the cell (186, 120)
    Then Housebroken filth rate of "Rex" is "0" times its base rate
    When Housebroken lets "Rex" step 2000 times where it stands
    Then Housebroken finds no animal filth on the cell of "Rex"
    Given Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" stands at (185, 120) facing South
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: the animal "Rex" stands at (186, 120) facing South
    When Nelim's Pickle Tools: I frame the cell (185, 119) at zoom 3.5
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery 2 the lesson"
    And Nelim's Pickle Tools: screenshot mode is disabled
    Then no errors were logged

  Scenario: Gallery 3, the garden path: outdoors Rex lets it go
    Given I set the hour to 11
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Rex" is spawned at (200, 187)
    And Housebroken teaches "Rex" the training "Tameness"
    And Housebroken teaches "Rex" the training "Obedience"
    And Housebroken teaches "Rex" the training "Haul"
    And Housebroken lets 251 game ticks pass
    And Housebroken puts "Rex" at the cell (200, 187)
    Then Housebroken filth rate of "Rex" is "0.3" times its base rate
    When Housebroken lets "Rex" step 4000 times where it stands
    Then Housebroken finds animal filth within 2 cells of "Rex"
    Given Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" stands at (198, 187) facing South
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: the animal "Rex" stands at (200, 187) facing South
    When Nelim's Pickle Tools: I frame the cell (199, 187) at zoom 5
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery 3 the garden path"
    And Nelim's Pickle Tools: screenshot mode is disabled
    Then no errors were logged
