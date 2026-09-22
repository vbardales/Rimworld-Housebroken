# Housebroken — functional test scenarios

Manual acceptance tests for RimWorld 1.6. Originally written on September 12, 2026 from the code and documentation; translated and extended on September 13. **No scenario has yet been executed in game.** Existing scenario IDs and execution history are preserved.

## Preparation and method

- Use dedicated save copies with Harmony and Housebroken. Add other mods only for compatibility cases. Record the exact game version, DLC, mod order and tested DLL hash.
- Enable development mode to prepare animals and training. Disable cleaning and keep unrelated filth sources away from the test routes.
- Prepare a closed roofed room in the home area, an unroofed home-area pen, a roofed room outside the home area, a doorway and an outdoor route outside the home area. Verify roofs and area membership cell by cell.
- Prepare animals of none, intermediate and advanced trainability. Record their actual trainability. Prepare an advanced animal without obedience, with obedience only, and with obedience plus another learned training. Selected or partially learned training does not count.
- Measure each subject's baseline filth rate **B** without Housebroken under otherwise identical conditions. Use subjects with B greater than zero.
- Restore defaults before each scenario unless stated otherwise. Disable manure outdoors to isolate training factors.
- After changing training or trainability, wait at least 250 simulation ticks before checking again. Close the settings window to save and apply settings, then reopen the animal's stat details.
- Account for displayed rounding. Deposits are random: repeat routes, count walked cells and compare with a control animal. A short deposit-free walk does not prove a reduction; one forbidden deposit with a confirmed source can establish failure.

## Filth rate calculation

### TF-01 — Loading and defaults

**Preconditions:** minimal mod configuration, settings reset.

**Actions:** start a new colony, open Housebroken mod options, inspect every setting and check the developer log.

**Expected:** no Housebroken XML or Harmony loading errors. Reductions: obedience 50%, further training 75%, intermediate 20%, advanced 40%. Colony-only, manure outdoors, clean feet and alert exemption enabled; whole-home disabled; indoor reduction 100%, outdoor multiplier 200%. No visible or greyed-out Housebroken MainButton.

### TF-02 — Individual and species factors

**Preconditions:** manure outdoors disabled; tame colony animals.

**Actions:** inspect the filth rate and explanation for each available combination.

| Trainability | Learned training | Expected rate |
| --- | --- | --- |
| None | Tameness only | B |
| Intermediate | Tameness only | B × 0.8 |
| Advanced | Tameness only | B × 0.6 |
| Intermediate | Obedience only | B × 0.4 |
| Advanced | Obedience only | B × 0.3 |
| Advanced | Obedience plus one additional training | B × 0.15 |
| Advanced | Obedience plus several additional trainings | B × 0.15 |

**Expected:** further training replaces the obedience factor; extra trainings do not stack. Species and training factors multiply. The Housebroken explanation appears when the factor is below one, with no location line when manure outdoors is disabled.

### TF-03 — Learning and losing training

**Preconditions:** tame advanced animal; manure outdoors disabled.

**Actions:** measure without obedience, with partially learned obedience, with learned obedience, with an additional learned training, after removing that additional training, then after removing obedience. Wait 250 ticks after each effective change.

**Expected:** successive rates B × 0.6, B × 0.6, B × 0.3, B × 0.15, B × 0.3, B × 0.6. Incomplete training gives no reduction.

### TF-04 — Sliders and no reduction

**Preconditions:** advanced animal with obedience and hauling; B > 0.

**Actions:** disable manure outdoors; set further-training reduction to 60% and advanced-species reduction to 25%. Close options and measure. Set all four trait reductions to 0%, then enable location, feet and alert options. Finally test an applicable training reduction of 100%.

**Expected:** initial rate B × 0.4 × 0.75 = B × 0.3. With all trait reductions zero, rate B everywhere, no reduction explanation and no Housebroken deposit or alert exemption. With an applicable 100% reduction, rate zero. Reduction sliders stay within 0–100%; outdoor multiplier within 100–400%.

### TF-05 — Eligible animals

**Preconditions:** advanced colony, wild and other-faction animals; human colonist and mechanoid controls. Manure outdoors disabled.

**Actions:** compare stats with colony-only enabled and disabled. Tame a wild subject, then test an animal leaving the player's faction if preparation permits.

**Expected:** with colony-only enabled, only player animals receive reductions. Otherwise other animals qualify according to training and trainability. Humans and mechanoids are unchanged. Faction changes affect eligibility; allow cache expiry for simultaneous training changes.

### TF-06 — Sentience catalyst

**Preconditions:** catalyst content available; compatible animal; manure outdoors disabled; unchanged training.

**Actions:** record trainability and rate before and after applying the catalyst; wait 250 ticks.

**Expected:** the reduction follows actual new trainability: species factor 1, 0.8 or 0.6. No separate catalyst bonus. Mark not applicable if the required content is unavailable.

## Location and produced manure

### TF-07 — Base boundaries

**Preconditions:** advanced animal with obedience and hauling, trait factor 0.15; default settings.

**Actions:** move the same animal to each location and reopen its stat immediately, without waiting 250 ticks.

| Location | Expected rate |
| --- | --- |
| Closed roofed room in home area | 0 |
| Unroofed pen in home area | B × 0.3 |
| Roofed room outside home area | B × 0.3 |
| Outdoors outside home area | B × 0.3 |
| Doorway, even roofed and in home area | B × 0.3 |
| Roofed home-area cell in a room touching the map edge | B × 0.3 |

**Expected:** holding-it explanation inside and outside explanation elsewhere. Position changes apply immediately. Prepare the final case with verifiable room contact with the map edge.

### TF-08 — Whole home area

**Preconditions:** same subject as TF-07.

**Actions:** enable whole-home mode. Repeat TF-07 positions; remove and restore the occupied cell's home-area membership.

**Expected:** zero rate in every home-area cell, including unroofed cells and doorways; B × 0.3 outside. Area changes apply without the training-cache delay.

### TF-09 — Indoor/outdoor factors and disabling

**Preconditions:** same subject; default base definition.

**Actions:** set indoor reduction to 50% and outdoor multiplier to 300%. Measure inside and outside. Disable manure outdoors and repeat.

**Expected:** indoor rate B × 0.075, outdoor B × 0.45. Disabled: B × 0.15 in both places with no location explanation.

### TF-10 — Deposits while moving

**Preconditions:** clean routes; subjects carry no mud or blood; reduced subject and unreduced control.

**Actions:** walk the reduced subject through the interior and outside. Repeat with manure outdoors disabled. Observe the unreduced control inside too.

**Expected:** by default the reduced subject produces no manure indoors; outside deposits remain possible. Disabling the option allows indoor deposits again. The control behaves normally. Do not require an immediate outdoor deposit or exact compensation for time indoors: no manure stock is stored; only the outdoor rate is multiplied.

## Carried mud and blood

### TF-11 — Holding and outdoor release

**Preconditions:** reduced animal; manure outdoors disabled to isolate mechanisms; clean indoor route. Prepare carried mud and blood separately, using a control to confirm each source can actually be picked up and carried.

**Actions:** walk the subject through the source and interior, then extend the route outside. Repeat with clean feet disabled, and with an unreduced animal.

**Expected:** with clean feet enabled, the reduced subject does not drop carried filth in the base; outdoor drops remain possible. Disabled or unreduced, indoor drops remain possible. Distinguish carried blood from active bleeding. If the carried load cannot be confirmed, record blocked rather than passed.

### TF-12 — Independent options and extended area

**Preconditions:** reduced animal with confirmed carried filth; reset the route between combinations.

**Actions:** test all four manure outdoors on/off × clean feet on/off combinations. Enable whole-home mode and cross an unroofed home-area pen. Disable manure outdoors while retaining whole-home mode.

**Expected:** clean feet depends only on its own toggle, eligibility and the base definition. It works with manure outdoors disabled. Whole-home mode still governs it while that control is hidden by the manure toggle. Manure rate follows its own setting.

## Animal filth alert

### TF-13 — Exemption and restoration

**Preconditions:** manure outdoors disabled. In an alert-eligible room, prepare a reduced animal whose final rate remains strictly above 4; adjust reductions if necessary. First confirm it appears with exemption disabled.

**Actions:** enable and disable exemption, allowing alert recalculation between observations.

**Expected:** the animal disappears with exemption and returns without it. Do not use an animal below the ordinary alert threshold to prove this option's effect.

### TF-14 — Mixed list and clickable targets

**Preconditions:** several animals triggering the alert without exemption, including at least two reduced and two unreduced animals; manure outdoors disabled.

**Actions:** record names, enable exemption, inspect remaining entries and click their targets. Repeat after an animal leaves; finish with only reduced animals.

**Expected:** only unreduced animals remain listed; names correspond to the correct targets. No ghost entries or errors. If all candidates are exempt, the alert disappears.

## Settings, saves and compatibility

### TF-15 — Saving and resetting

**Preconditions:** game open.

**Actions:** change every slider and checkbox from its default; close options and verify effects. Restart the game and check values. Request reset and cancel; repeat and confirm; close options and check rates.

**Expected:** values persist after restart. Cancelling changes nothing. Confirmation restores every TF-01 default. No stale reduction factor remains after saving options. The global scope and close-to-apply explanation is visible.

### TF-16 — French and English interface

**Preconditions:** run once in French and once in English.

**Actions:** read all settings, tooltips, reset confirmation and indoor/outdoor stat explanations. Scroll at a small supported resolution. Include the revealed shortcut label and tooltip.

**Expected:** no raw Housebroken keys or missing text; sliders and reset button accessible; percentages agree with measured rates. Location controls appear/disappear with manure outdoors. No clipping, overlapping controls or untranslated shortcut description.

### TF-17 — Save/reload with carried filth

**Preconditions:** reduced subject inside with a confirmed carried load; protection enabled.

**Actions:** save, quit, reload; walk inside and outside.

**Expected:** no mod-related loading error; coherent rates; indoor protection preserved and outdoor release still possible. Saving must not erase the carried load artificially.

### TF-18 — Add/remove on an existing save

**Preconditions:** separate copies of saves without and with Housebroken.

**Actions:** enable the mod and load the first copy; verify TF-02 and TF-07. Disable the mod, restart and load the second copy; continue simulation and save to a new file.

**Expected:** successful addition and removal without missing Housebroken data or related errors. Vanilla behavior resumes after removal. An ordinary changed-mod-list warning alone is not failure.

### TF-19 — Multiple maps and switching games

**Preconditions:** two maps with different home areas; reduced subject.

**Actions:** transfer the animal between maps, for example via caravan; inspect in transit and after arrival. Load another save without quitting, containing differently trained animals; check immediately and after 250 ticks.

**Expected:** no error off-map; destination map's base definition applies on arrival. No previous-game factor contaminates the new game. Record any transient incorrect rate even if it disappears after 250 ticks.

### TF-20 — Another FilthRate modification

**Preconditions:** validated minimal configuration, then an identified test mod adding another FilthRate stat part; record its effect without Housebroken.

**Actions:** load both mods in each dependency-permitted order; inspect logs and explanations; repeat a numeric TF-02 case. Record tested names and versions.

**Expected:** no XML patch failure; exactly one Housebroken contribution; other contribution preserved. Calculation follows actual operation order; identical results are not required if the other mod adds a constant. Only the tested combinations are validated.

### TF-21 — Optional MainButtons shortcut

**Preconditions:** clean configuration with Harmony and Housebroken; then repeat with an identified RIMMSQOL version. Record its version and load order.

**Actions:** first open Housebroken through Mod options without RIMMSQOL. Confirm no visible or greyed-out MainButton. With RIMMSQOL, reveal Housebroken_Settings through MainButton customization, open it, change a setting and close. Reopen through Mod options and verify the same value and actual effect. Reverse the two routes. Restart and check Housebroken settings. In the same session, hide the shortcut and confirm that Housebroken does not force it visible again. Repeat for any other customization tool claimed as tested.

**Expected:** primary access always works independently; shortcut opens the same native settings dialog and shares Housebroken values and persistence. Visibility is controlled by the customization tool and is not forced back each frame. Hidden shortcut occupies no visible or disabled button. No related errors in logs. A tool that cannot expose the Def is recorded precisely as an integration limitation, not silently passed. Persistence of a RIMMSQOL visibility choice across a restart is a RIMMSQOL feature, outside Housebroken's acceptance scope.

### TF-22 — Older settings and numeric limits

**Preconditions:** dedicated backed-up test configuration, game closed. This is a developer fixture test, not a player configuration procedure.

**Actions:** prepare an older settings fixture missing newly added fields and a fixture with numeric factors outside slider bounds. Load each and open options. Check defaults, safe ranges and actual rates. Close, restart and verify the normalized values. Then restore the user's original configuration.

**Expected:** missing fields receive defaults; finite out-of-range values clamp to slider bounds; non-finite numeric values use defaults. No negative/non-finite filth rate from settings. Normal players use the options UI, not manual XML editing.

## Execution record

Copy one row per scenario and variant. Historical status on September 12 remains **not executed**; translation and additions on September 13 do not establish runtime success.

| ID / variant | Game, DLC, DLL and mods | Save / subjects / settings | Observed result and evidence | Status | Issue |
| --- | --- | --- | --- | --- | --- |
| TF-… | To record | To record | Stat screenshot, log or route observation | Not executed | — |

Statuses: **Not executed**, **Passed**, **Failed**, **Blocked**, **Not applicable**. For failure, attach exact steps, expected and observed results, and logs where relevant. For blocked/not applicable cases, state the reason.

Acceptance requires every applicable scenario to pass with no open functional defect. Blocked cases remain unverified. Writing these scenarios does not validate in-game behavior.
