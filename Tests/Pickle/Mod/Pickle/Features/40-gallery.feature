@review @gallery @timeout:600 @requires:nelim.sanctuarybacklot @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.colonistrace @requires:lucius.eyegenes3 @requires:nelim.pickletools.camerazoom
Feature: Housebroken gallery photographs, A morning with Shogun, on the Sanctuaire de Nelim

  # Two families of steps, told apart by their prefix:
  #   "Nelim's Sanctuary: ..."      SB, the SanctuaryBacklot repository: the save, the named places, Nelim's own face.
  #   "Nelim's Pickle Tools: ..."   NPT, PickleTools: animals, pawns, camera, screenshot mode, jobs, carried items.
  #   "Housebroken ..."             this mod's own steps (training, rates).
  #
  # Story (owner's rule 2026-10-14: Nelim is the protagonist; Nelim is Virginie): one morning. Nelim feeds her labrador, Shogun (the animal of the
  # Sanctuary save, owner's order 2026-10-25: Shogun, not a new husky), and a cow, Daisy, spawned for the occasion.
  # Shogun is taught tameness, obedience and hauling; Daisy is only tamed (a cow has no species reduction, a labrador has, so she is the honest control).
  # Cast: Nelim in her fixture look (her hair, her smirk, her brown eyes, her trousers) with a teal basic shirt, the one colour that stands out of
  # the brown boards, the orange rugs and the cream floor; Shogun in his leather collar (his default, kept: Sanctuary wardrobe). Both animals are seen
  # from the front, facing or walking South. Nelim is the only colonist: no colonist outside NSB is used.
  # Not changed on purpose: her hair and face (they are Virginie's, the fixture owns them). Her expression stays the smirk of "Nelim has her own face".
  #
  # Shot plan, one line per image (GALLERY.md, "Une photo mise en scene"). Every picture is a paused game (criterion e): the gesture is started with a
  # job, the game runs N ticks and is paused, and the picture is taken. The tick counts below are plans, to tune on the first run.
  #   1  hearth-hall, 09:00 plus the 251 ticks the rate cache needs. Wide, zoom 6 on (185, 120). Just before: Nelim fetched the kibble from the pantry;
  #      just after: she sets it down for Shogun. Nelim crosses the hall at z 121 from (181, 121) to (186, 121) holding "Kibble", about 30 ticks into
  #      her walk, one foot forward. Shogun at (184, 120) and Daisy at (188, 120) face South; the cow's dropping on her cell, nothing on Shogun's.
  #      Says: the same hall, two animals, one mess.
  #   2  hearth-hall, 09:00 plus 460 ticks. Close, zoom 3.5 on (185, 120). Just before: Shogun brought the log in from the yard; just after: he drops it
  #      at Nelim's feet. Shogun holds the item "WoodLog" in his mouth (the hauling lesson), Nelim beside him at (186, 120) facing South, the boards clean
  #      around them, the cow out of the frame (removed for this picture). Says: the trained dog keeps his manners indoors.
  #   3  calm-zone, 11:00. Medium, zoom 5 on (200, 187). Just before: Shogun was let out; just after: he reaches the gravel path. Shogun walks South from
  #      (200, 189) to (200, 186), mid-stride toward the camera, his dropping on the cream built floor behind him at (200, 187); Nelim at (198, 187)
  #      watches him go. Says: outside, on built floor, he lets it go.
  # Each picture asserts the stat it shows, so a green run says the stat is right; whether the picture shows it is read by eye (run 2026-10-07 was green
  # with both subjects out of frame). The subtitle of each picture is added afterwards by ../scripts/Add-Subtitle.ps1 (text in PUBLICATION.md).
  # Places chosen from SANCTUAIRE-LIEUX.md and SANCTUAIRE-CASES.md: only a roofed room of the home area shows the indoor rule, so the hearth hall
  # (x 172-190, z 106-124; cells (184,120), (187,120), (188,120) free there, away from the doors); open ground with a built floor for the outdoor rule,
  # so the calm zone. Neither is cleared or re-roofed. The animals wander during the 251 ticks the rate cache needs, so each is put back near its cell
  # afterwards by this mod's own step. The dropping is not a placed prop: the animal steps in place through the game's own entry point.
  # Shogun lives in the save: "the animals are removed from the sanctuary" would despawn him if he stands in the hall, and the steps find him by name
  # (AnimalSteps.Named); the first run says whether he is out of the hall. Daisy is spawned by this mod's own step (a colony cow).
  # NOT PLAYED YET: the cells of Nelim, the zooms, the tick counts of the walks and the mouth-carry look are plans until a run is read by eye.

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken settings are written to disk

  Scenario: Gallery 1, the hall: Daisy leaves a mess, Shogun keeps it to himself
    Given I set the hour to 9
    And Nelim's Sanctuary: I am at the sanctuary "hearth-hall"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "hearth-hall"
    And Housebroken spawns the colony animal "Daisy" as "Cow"
    And Housebroken teaches "Shogun" the training "Tameness"
    And Housebroken teaches "Shogun" the training "Obedience"
    And Housebroken teaches "Shogun" the training "Haul"
    And Housebroken teaches "Daisy" the training "Tameness"
    And Housebroken lets 251 game ticks pass
    And Housebroken puts "Shogun" at the cell (184, 120)
    And Housebroken puts "Daisy" at the cell (188, 120)
    Then Housebroken filth rate of "Shogun" is "0" times its base rate
    And Housebroken filth rate of "Daisy" is "1" times its base rate
    When Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken lets "Shogun" step 2000 times where it stands
    Then Housebroken finds animal filth on the cell of "Daisy"
    And Housebroken finds no animal filth on the cell of "Shogun"
    Given Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" stands at (181, 121) facing East
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" carries the item "Kibble"
    And Nelim's Pickle Tools: the animal "Shogun" stands at (184, 120) facing South
    And Nelim's Pickle Tools: the animal "Daisy" stands at (188, 120) facing South
    When Nelim's Pickle Tools: "Nelim" is forced to walk to (186, 121)
    And Nelim's Pickle Tools: I advance the paused game by exactly 30 ticks
    And Nelim's Pickle Tools: I frame the cell (185, 120) at zoom 6
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery 1 the hall"
    And Nelim's Pickle Tools: screenshot mode is disabled
    Then no errors were logged

  Scenario: Gallery 2, the lesson: Shogun keeps his manners indoors
    Given I set the hour to 9
    And Nelim's Sanctuary: I am at the sanctuary "hearth-hall"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "hearth-hall"
    And Housebroken teaches "Shogun" the training "Tameness"
    And Housebroken teaches "Shogun" the training "Obedience"
    And Housebroken teaches "Shogun" the training "Haul"
    And Housebroken lets 460 game ticks pass
    And Housebroken puts "Shogun" at the cell (185, 120)
    Then Housebroken filth rate of "Shogun" is "0" times its base rate
    When Housebroken lets "Shogun" step 2000 times where it stands
    Then Housebroken finds no animal filth on the cell of "Shogun"
    Given Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" stands at (186, 120) facing South
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: the animal "Shogun" stands at (185, 120) facing South
    And Nelim's Pickle Tools: "Shogun" carries the item "WoodLog"
    When Nelim's Pickle Tools: I frame the cell (185, 120) at zoom 3.5
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery 2 the lesson"
    And Nelim's Pickle Tools: screenshot mode is disabled
    Then no errors were logged

  Scenario: Gallery 3, the garden path: outdoors Shogun lets it go
    Given I set the hour to 11
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone"
    And Housebroken teaches "Shogun" the training "Tameness"
    And Housebroken teaches "Shogun" the training "Obedience"
    And Housebroken teaches "Shogun" the training "Haul"
    And Housebroken lets 251 game ticks pass
    And Housebroken puts "Shogun" at the cell (200, 187)
    Then Housebroken filth rate of "Shogun" is "0.3" times its base rate
    When Housebroken lets "Shogun" step 4000 times where it stands
    Then Housebroken finds animal filth within 2 cells of "Shogun"
    Given Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" stands at (198, 187) facing East
    And Nelim's Sanctuary: Nelim has her own face
    And Housebroken puts "Shogun" at the cell (200, 189)
    When Nelim's Pickle Tools: "Shogun" is forced to walk to (200, 186)
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
    And Nelim's Pickle Tools: I frame the cell (200, 187) at zoom 5
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery 3 the garden path"
    And Nelim's Pickle Tools: screenshot mode is disabled
    Then no errors were logged
