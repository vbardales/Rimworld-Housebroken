# SHOTLIST of the gallery, one line per image, written 2026-11-10 (full story, cast and rules in the header below the Feature line):
#   1. opening, wide. hearth-hall, 09:00 plus 251 ticks, Clear, warm lamplight indoors, zoom 4 on (187, 120) (x 178-196, z 115-125). Left half clean,
#        right half soiled: Shogun walks East from (184, 119) to (185, 119) onto his kibble bowl at (185, 119) over clean boards (the hall fence stands one row up); Daisy walks West from
#        (190, 118) to (189, 118) onto a pile of hay at (189, 118), her three droppings on the boards around (190-192, 119) behind her. Nelim walks South
#        toward the camera from (184, 122) to (184, 120), smiling, her high ponytail (Highpony, the fixture hair), empty-handed (nothing carried: the hay hid her face), caught about 26 ticks into her
#        walk. Background (north): the hall's own couches, armchair and lamp (not staged), plus a staged
#        PlantPot_Bonsai at (183, 123). Just before: she put the hay down for Daisy; just after: she goes to the dog. Says: two animals feed on the
#        same boards and only one leaves a mess.
#   2. close, the meeting. hearth-hall, 09:00 plus 460 ticks, Clear, same light, zoom 3.5 on (186, 120) (x 180-192, z 116.5-123.5). Shogun, tame, obedient
#        and hauling, comes to her: he walks East from (183, 121) to (184, 121) over clean boards, Nelim walks South from (186, 122) to (186, 121),
#        smiling, her high ponytail, empty-handed, looking down at him, one empty cell between them, both about 20 ticks into their step. Foreground (south): bare
#        boards, no dropping. Background (north): the bonsai pot at (183, 123) and, at the top of the frame, the hall's own couches, armchair and lamp (not staged). At the right edge, Daisy's two droppings on (189, 121) and (189, 122) are
#        the proof of what Shogun does not do, and Daisy's rear half is cut by the frame at (191, 122). Just before: Shogun answered her call; just
#        after: she gives him the kibble. Says: the trained dog keeps his manners indoors. (Criterion c, an animal seen from the front, is not reachable: the animal sprites have only side views for North and South, an assumed -0.5 on shot 1.)
#   3. closing, medium. calm-zone, 09:00 plus 1250 ticks, Clear, daylight, zoom 4 on (200, 188) (x 194-206, z 184-192), cream built floor. Shogun
#        walks South from (200, 189) to (200, 185) toward the camera, about 45 ticks into his walk, at mid-path with his dropping on the floor at
#        (200, 187) behind him (on screen: above his feet); Nelim follows him from (200, 190), inside the frame, smiling, her high ponytail, facing South. The calm zone's own flower beds (red and yellow flowers) frame the cream square on both sides. Background: two more Plant_Daylily at (196, 189) and (204, 190). Foreground
#        (south, z 185-186): two Plant_Daylily, fully grown, at (197, 185) and (203, 186). Just before: Shogun was let out of the hall; just after: he
#        reaches the path. Says: outside, on built floor, he lets it go.
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
  # her trousers, redone 2026-10-31: Apparel_Pants worn explicitly, dark slate rgb (52, 58, 78), because run 2026-10-31 showed bare legs) with a teal basic shirt,
  # rgb (38, 128, 134), the one colour that stands out of the brown boards, the orange rugs and the cream floor. Redo 2026-10-31 (owner: the series is redone):
  # Nelim always faces South, so her face is seen; the kibble is no longer carried (it hid her face in picture 2); NSB facts: her save fixture wears Apparel_Pants,
  # Shogun is LabradorRetriever59410, bonded to her, collar Apparel_leatherdogcollar. Animals have side sprites for North and South: no front view is possible.
  # Colonists smile on default scenes (owner's rule 2026-10-25): her own face with the face kit "smile", held against the expression her job gives, in all three pictures.
  # No colonist outside NSB is used. Shogun keeps his leather collar (the save's own, the Sanctuary wardrobe default). Animals are seen from the side (their sprites have no front view: criterion c, front view, is an assumed malus).
  # Top-down camera: south is the bottom of the picture (foreground), north the top (background); "facing South" faces the camera.
  #
  # SHOT PLAN, one line per image (GALLERY.md, "Une photo mise en scene"). Every picture is a paused game (criterion e): the gesture is started with a
  # job, the game runs N exact ticks (a pawn walks about one cell per 13 ticks) and is paused, then the picture is taken. N is a plan to tune.
  # Redo 2026-11-10 (the f82b run, all three pictures REDO by eye): in 1 the carried hay hid her face again, in 2 she did not smile (a job expression
  # overrides a bare mouth: now "face kit is smile" plus "face is held neutral") and Shogun was far from her, in 3 she was out of the frame. Director's pass
  # (Opus sub-agent, kept: zoom 4 for 1, animals eating along an East-West axis because their sprites have only side views, Shogun comes to her in 2, the hay
  # and the droppings tell the story by their side of the hall, Daisy's rear cut by the frame in 2; not kept: a hall wall in the top row of 3, the calm zone is
  # a free cream square away from the hall, and East-walking Shogun in 3, he keeps walking South toward the camera).
  # (the shot lines 1 to 3 are in the first lines of this file, above the tags, where Check-ShotlistVsScenario.ps1 reads them)
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
    And Housebroken puts "Shogun" at the cell (184, 119)
    And Housebroken puts "Daisy" at the cell (190, 119)
    Then Housebroken filth rate of "Shogun" is "0" times its base rate
    And Housebroken filth rate of "Daisy" is "1" times its base rate
    When Housebroken lets "Shogun" step 2000 times where it stands
    Then Housebroken finds no animal filth on the cell of "Shogun"
    When Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken puts "Daisy" at the cell (191, 119)
    And Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken puts "Daisy" at the cell (192, 119)
    And Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken puts "Daisy" at the cell (190, 118)
    Then Housebroken finds animal filth on the cell of "Daisy"
    Given Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" at (183, 123)
    And Nelim's Pickle Tools: 20 of the item "Hay" are spawned at (189, 118)
    And Nelim's Pickle Tools: 20 of the item "Kibble" are spawned at (185, 119)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (52, 58, 78)
    And Nelim's Pickle Tools: "Nelim" stands at (184, 122) facing South
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" face kit is "smile"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    When Nelim's Pickle Tools: "Nelim" is forced to walk to (184, 120)
    And Nelim's Pickle Tools: "Shogun" is forced to walk to (185, 119)
    And Nelim's Pickle Tools: "Daisy" is forced to walk to (189, 118)
    And Nelim's Pickle Tools: I advance the paused game by exactly 26 ticks
    And Nelim's Pickle Tools: I frame the cell (187, 120) at zoom 4
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
    And Housebroken puts "Shogun" at the cell (183, 121)
    And Housebroken puts "Daisy" at the cell (189, 120)
    Then Housebroken filth rate of "Shogun" is "0" times its base rate
    When Housebroken lets "Shogun" step 2000 times where it stands
    Then Housebroken finds no animal filth on the cell of "Shogun"
    When Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken puts "Daisy" at the cell (189, 121)
    And Housebroken lets "Daisy" step 2000 times where it stands
    And Housebroken puts "Daisy" at the cell (189, 122)
    And Housebroken lets "Daisy" step 2000 times where it stands
    Then Housebroken finds animal filth on the cell of "Daisy"
    When Housebroken puts "Daisy" at the cell (191, 122)
    Given Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" at (183, 123)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (52, 58, 78)
    And Nelim's Pickle Tools: "Nelim" stands at (186, 122) facing South
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" face kit is "smile"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    When Nelim's Pickle Tools: "Nelim" is forced to walk to (186, 121)
    And Nelim's Pickle Tools: "Shogun" is forced to walk to (184, 121)
    And Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I frame the cell (186, 120) at zoom 3.5
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
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (196, 189) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (204, 190) fully grown
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (38, 128, 134)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (52, 58, 78)
    And Nelim's Pickle Tools: "Nelim" stands at (200, 190) facing South
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" face kit is "smile"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
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
