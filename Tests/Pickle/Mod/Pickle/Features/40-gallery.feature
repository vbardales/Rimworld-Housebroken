@review @gallery @timeout:600 @requires:nelim.sanctuarybacklot @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.screenshotmode @requires:nelim.pickletools.colonistrace @requires:lucius.eyegenes3 @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.stagedecor
Feature: Housebroken gallery photographs, A morning with Shogun, on the Sanctuaire de Nelim

  # Three families of steps, told apart by their prefix:
  #   "Nelim's Sanctuary: ..."      SB, the SanctuaryBacklot repository: the save, the named places, Nelim's own face.
  #   "Nelim's Pickle Tools: ..."   NPT, PickleTools: decor, jobs, carried items, camera, screenshot mode.
  #   "Housebroken ..."             this mod's own steps (training, rates, droppings).
  #
  # STORY (owner's rule 2026-10-14: Nelim is the protagonist; Nelim is Virginie). One clear morning, 09:00 to about 09:30. Nelim feeds the animals in
  # the hearth hall: hay for Daisy, a cow spawned for the occasion who has been in the hall since dawn and has left a trail of droppings, and kibble
  # for Shogun, her labrador, the animal of the Sanctuary save (owner's order 2026-10-25: Shogun, not a new husky). Shogun was taught tameness,
  # obedience and hauling; Daisy is only tamed (a cow has no species reduction, a labrador has, so she is the honest control). Then Nelim rewards
  # Shogun for his manners, and lets him out into the cream calm zone, where outside, on built floor, he lets it go (rate x0.3, never x0).
  # The series shows the whole offer of the mod: indoors a trained animal keeps it back (x0), an untrained one does not (x1), outdoors it is released.
  # Settings are shown by the settings-page pictures (no subtitle), not by this series. Rhythm: 09:00 plus 251 ticks, 09:00 plus 460 ticks, 09:00 plus
  # 1250 ticks (2,500 ticks per game hour: about 09:06, 09:11, 09:30), so it is one continuous morning, clear sky, no rain.
  # CAST (outfit continuity, owner's rule 2026-10-23: nobody changes clothes, it is the same morning): Nelim in her fixture look (her hair, her brown eyes,
  # her trousers) with a teal basic shirt, rgb (38, 128, 134), the one colour that stands out of the brown boards, the orange rugs and the cream floor.
  # Colonists smile on default scenes (owner's rule 2026-10-25): her own face (brows) with MouthSmile instead of her smirk, in all three pictures.
  # No colonist outside NSB is used. Shogun keeps his leather collar (the save's own, the Sanctuary wardrobe default). Animals are seen from the front.
  # Top-down camera: south is the bottom of the picture (foreground), north the top (background); "facing South" faces the camera.
  #
  # SHOT PLAN, one line per image (GALLERY.md, "Une photo mise en scene"). Every picture is a paused game (criterion e): the gesture is started with a
  # job, the game runs N exact ticks (a pawn walks about one cell per 13 ticks) and is paused, then the picture is taken. N is a plan to tune.
  #   1  opening, wide. hearth-hall, 09:00 plus 251 ticks, Clear, warm lamplight indoors, zoom 5 on (187, 120) (x 178-196, z 115-125). Foreground
  #      (south, z 119): Shogun walking South from (186, 122) to (186, 119) toward his kibble bowl at (186, 118), clean boards behind him; Daisy walking
  #      South from (189, 122) to (189, 119) toward a pile of hay at (189, 118), her three droppings on the boards around (189-190, 121-122) behind her.
  #      Nelim crossing the hall at z 121, from (182, 121) to (185, 121), smiling, a bundle of hay in her hands (carries the item "Hay"), caught about 26
  #      ticks into her walk. Background (north): the hall's own couches (185, 123) and (187, 122), the armchair (189, 123), the lamp (187, 121), plus a
  #      staged PlantPot_Bonsai at (183, 123). Just before: Nelim fetched the hay; just after: she puts it down for Daisy. Says: two animals walk the
  #      same boards and only one leaves a mess.
  #   2  close. hearth-hall, 09:00 plus 460 ticks, Clear, same light, zoom 3.5 on (185, 120) (x 179-191, z 116.5-123.5). The picture is the meeting of
  #      two paths over clean boards: Shogun, tame, obedient and hauling, walks South from (184, 122) to (184, 119) and Nelim walks West from (188, 120)
  #      to (186, 120), smiling, holding the kibble that is his reward (carries the item "Kibble"), both about 20 ticks into their walk. Foreground
  #      (south): bare boards, no dropping. Background (north): the bonsai pot at (183, 123). At the right edge, Daisy's trail of droppings on (189, 120),
  #      (189, 121) and (190, 121) is the proof of what Shogun does not do; Daisy herself stands out of frame at (190, 124) (she wandered, she is still
  #      in the hall). Just before: Shogun answered her call; just after: she hands him the kibble. Says: the trained dog keeps his manners indoors.
  #   3  closing, medium. calm-zone, 09:00 plus 1250 ticks, Clear, daylight, zoom 4 on (200, 188) (x 194-206, z 184-192), cream built floor. Shogun
  #      walks South from (200, 189) to (200, 185) toward the camera, about 45 ticks into his walk, at (200, 186) with his dropping on the floor at
  #      (200, 187) behind him (on screen: above his feet); Nelim follows him from (200, 192) (follow job), smiling, at the top of the frame. Foreground
  #      (south, z 185-186): two Plant_Daylily, fully grown, at (197, 185) and (203, 186). Just before: Shogun was let out of the hall; just after: he
  #      reaches the path. Says: outside, on built floor, he lets it go.
  # Thumbnail (criterion j, 268 px wide = 14 to 18 cells across a 1920 px picture, so one cell is 15 to 20 px): the dog, the cow, the woman and the
  # droppings (small dark marks on light wood in 1, a dark mark on the cream floor in 3) are each at least one cell; whether the droppings contrast
  # enough on the boards is read on the capture, and the floor of the scene is changed if they do not.
  # Each picture asserts the stat it shows, so a green run says the stat is right; whether the picture shows it is read by eye (run 2026-10-07 was green
  # with both subjects out of frame). The subtitle of each picture is added afterwards by ../scripts/Add-Subtitle.ps1 (text in PUBLICATION.md).
  # PLACES chosen from SANCTUAIRE-LIEUX.md and SANCTUAIRE-CASES.md: only a roofed room of the home area shows the indoor rule, so the hearth hall (x 172-190,
  # z 106-124; every cell used here is in the list of free cells, nothing is cleared or re-roofed); open ground with a built floor for the outdoor rule,
  # so the calm zone (the cream square x 195-205, z 182-191 is free). Shogun lives in the save, far from both places: the steps find him by name and put
  # him on a cell ("the animals are removed from the sanctuary" would despawn him if he stood in the hall; the first run says). Daisy is a colony cow
  # spawned by this mod's own step. The dropping is not a placed prop: the animal steps in place through the game's own entry point.
  # NOT PLAYED YET: the cells, the zooms, the tick counts of the walks, the follow job and the carried items are plans until a run is read by eye.

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I close all dialogs
    And Housebroken settings are at their documented defaults
    And Housebroken settings are written to disk

  Scenario: Gallery 1, the hall: Daisy leaves a mess, Shogun keeps it to himself
    Given I set the hour to 9
    And I set the weather to "Clear"
    And Nelim's Sanctuary: I am at the sanctuary "hearth-hall"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "hearth-hall"
    And Housebroken spawns the colony animal "Daisy" as "Cow"
    And Housebroken teaches "Shogun" the training "Tameness"
    And Housebroken teaches "Shogun" the training "Obedience"
    And Housebroken teaches "Shogun" the training "Haul"
    And Housebroken teaches "Daisy" the training "Tameness"
    And Housebroken lets 251 game ticks pass
    And Housebroken puts "Shogun" at the cell (186, 122)
    And Housebroken puts "Daisy" at the cell (189, 122)
    Then Housebroken filth rate of "Shogun" is "0" times its base rate
    And Housebroken filth rate of "Daisy" is "1" times its base rate
    When Housebroken lets "Shogun" step 2000 times where it stands
    Then Housebroken finds no animal filth on the cell of "Shogun"
    When Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken puts "Daisy" at the cell (190, 122)
    And Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken puts "Daisy" at the cell (190, 121)
    And Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken puts "Daisy" at the cell (189, 122)
    Then Housebroken finds animal filth on the cell of "Daisy"
    Given Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" at (183, 123)
    And Nelim's Pickle Tools: 20 of the item "Hay" are spawned at (189, 118)
    And Nelim's Pickle Tools: 20 of the item "Kibble" are spawned at (186, 118)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" stands at (182, 121) facing East
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" carries the item "Hay"
    When Nelim's Pickle Tools: "Nelim" is forced to walk to (185, 121)
    And Nelim's Pickle Tools: "Shogun" is forced to walk to (186, 119)
    And Nelim's Pickle Tools: "Daisy" is forced to walk to (189, 119)
    And Nelim's Pickle Tools: I advance the paused game by exactly 26 ticks
    And Nelim's Pickle Tools: I frame the cell (187, 120) at zoom 5
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery 1 the hall"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged

  Scenario: Gallery 2, the lesson: Shogun keeps his manners indoors
    Given I set the hour to 9
    And I set the weather to "Clear"
    And Nelim's Sanctuary: I am at the sanctuary "hearth-hall"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "hearth-hall"
    And Housebroken spawns the colony animal "Daisy" as "Cow"
    And Housebroken teaches "Shogun" the training "Tameness"
    And Housebroken teaches "Shogun" the training "Obedience"
    And Housebroken teaches "Shogun" the training "Haul"
    And Housebroken teaches "Daisy" the training "Tameness"
    And Housebroken lets 460 game ticks pass
    And Housebroken puts "Shogun" at the cell (184, 122)
    And Housebroken puts "Daisy" at the cell (189, 120)
    Then Housebroken filth rate of "Shogun" is "0" times its base rate
    When Housebroken lets "Shogun" step 2000 times where it stands
    Then Housebroken finds no animal filth on the cell of "Shogun"
    When Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken puts "Daisy" at the cell (189, 121)
    And Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken puts "Daisy" at the cell (190, 121)
    And Housebroken lets "Daisy" step 2000 times where it stands
    Then Housebroken finds animal filth on the cell of "Daisy"
    When Housebroken puts "Daisy" at the cell (190, 124)
    Given Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" at (183, 123)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" stands at (188, 120) facing West
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" carries the item "Kibble"
    When Nelim's Pickle Tools: "Nelim" is forced to walk to (186, 120)
    And Nelim's Pickle Tools: "Shogun" is forced to walk to (184, 119)
    And Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I frame the cell (185, 120) at zoom 3.5
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery 2 the lesson"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged

  Scenario: Gallery 3, the garden path: outdoors Shogun lets it go
    Given I set the hour to 9
    And I set the weather to "Clear"
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone"
    And Housebroken teaches "Shogun" the training "Tameness"
    And Housebroken teaches "Shogun" the training "Obedience"
    And Housebroken teaches "Shogun" the training "Haul"
    And Housebroken lets 1250 game ticks pass
    And Housebroken puts "Shogun" at the cell (200, 187)
    Then Housebroken filth rate of "Shogun" is "0.3" times its base rate
    When Housebroken lets "Shogun" step 4000 times where it stands
    Then Housebroken finds animal filth within 2 cells of "Shogun"
    Given Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (197, 185) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (203, 186) fully grown
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" stands at (200, 192) facing South
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Housebroken puts "Shogun" at the cell (200, 189)
    When Nelim's Pickle Tools: "Shogun" is forced to walk to (200, 185)
    And Nelim's Pickle Tools: "Nelim" follows "Shogun"
    And Nelim's Pickle Tools: I advance the paused game by exactly 45 ticks
    And Nelim's Pickle Tools: I frame the cell (200, 188) at zoom 4
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "gallery 3 the garden path"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged
