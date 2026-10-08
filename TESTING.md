# Housebroken — runtime acceptance plan

`done` means ready for in-game acceptance, not `tested`. The offline runner is
`Tests/Housebroken.Tests.csproj`; the development-only Pickle suite and its pass maps are in
`Tests/Pickle/`. The manual scenarios are in `TESTS_FONCTIONNELS.md`.

## Pickle configurations

The minimum production configuration is RimWorld 1.6, its staged DLCs, Harmony and
Housebroken. Screenshot Mode and Screenshot Studio are test-only capture helpers, not
Housebroken dependencies. Housebroken declares no optional third-party `loadAfter` mod;
RIMMSQOL is a separately requested shortcut integration check.

| Pass | Map and language | Scope | Evidence / state |
| --- | --- | --- | --- |
| Minimal EN | `wsl-deps.runtime-evidence.map`, English | Native options, hidden MainButton and EN page | 3 passed, 1 skipped (RIMMSQOL absent); [docs/runs/2026-09-22.md](docs/runs/2026-09-22.md) |
| Minimal FR | `wsl-deps.runtime-evidence.map`, French | Same UI paths and FR page | 3 passed, 1 skipped (RIMMSQOL absent); [docs/runs/2026-09-22.md](docs/runs/2026-09-22.md) |
| With RIMMSQOL EN | `wsl-deps.avec-rimmsqol.map`, English, `04-rimmsqol.feature` | List, reveal, activate, hide and forget the Housebroken shortcut | 1 passed; [docs/runs/2026-09-22.md](docs/runs/2026-09-22.md) |

All three reports ended with `exitReason: passed`; their seven Housebroken captures were opened and reviewed. The English
RIMMSQOL pass does not establish persistence owned by RIMMSQOL. French shortcut text and the page at two scales were played later
(TF-16, TF-21, `docs/runs/2026-09-28.md`).

## Passes of the functional scenarios (TF-01 to TF-22)

`TESTS_FONCTIONNELS.md` describes each scenario for a person. Most of them are also played by Pickle, on a
proving ground the suite builds on the fixture map: a closed room, a doorway, an unroofed pen, a roofed room
outside the home area, open ground, and a room touching the map edge. Animals are spawned with a chosen
training, and the stat, the deposits and the alert are read from the game. Only the walking is replaced, by a
teleport from cell to cell. **All of these passes have run** (2026-09-25 and 2026-09-26); each result is in `docs/runs/`.

| Pass | Command, from the collection root | Features | Covers |
| --- | --- | --- | --- |
| Minimal | `Run-PickleWsl.ps1 -Mod Housebroken -Filter '10-defaults-and-factors,11-sliders-eligibility-catalyst,12-location,13-deposits,14-alert'` | 10 to 14 | TF-01 to TF-14. TF-06 needs Odyssey |
| Settings | `-DepMap wsl-deps.settings.map -Filter '20-settings-reset,29-switching-games,32-language-review'`, English then French | 20, 29, 32 | TF-15 reset, TF-19 switching games, TF-16 page at two scales |
| Tooltips | `-DepMap wsl-deps.hover.map -Filter 32-language-review`, English then French | 32 | TF-16 every tooltip, hovered and captured (the HoverSteps tool, first played here) |
| Restart | `-DepMap wsl-deps.settings.map -Filter 21-settings-restart-write -Then 22-settings-restart-read` | 21, 22 | TF-15 persistence |
| Save and reload | `-Filter 28-save-reload` | 28 | TF-17, and TF-18 first half: a save holds no data of the mod |
| Caravan | `-Filter 33-caravan-to-second-map` | 33 | TF-19 transfer between two maps |
| Removal | `-DepMap wsl-deps.tf18.map -Filter 34-tf18-write -Then removal-check -ThenWithout nelim.housebroken,nelim.housebroken.pickletests` | 34, then the `Removal` companion | TF-18 second half: a game saved with the mod loads without it |
| Older file | `-DepMap wsl-deps.tf22-old.map -Filter 23-tf22-old-load -Then 24-tf22-old-read` | 23, 24 | TF-22 fields missing. Seed: `config/tf22-old/` |
| Out of range | `-DepMap wsl-deps.tf22-range.map -Filter 25-tf22-range-load -Then 26-tf22-range-read` | 25, 26 | TF-22 clamped and non-finite numbers. Seed: `config/tf22-range/` |
| RIMMSQOL | `-DepMap wsl-deps.rimmsqol-tf.map -Filter '27-shortcut-and-settings'`, and the restart pair again | 27 | TF-21 and the shortcut on the main bar (its tooltip is not observable: the main bar does not record tip regions) |
| Other mod, before | `-DepMap wsl-deps.otherfilth-before.map -Filter 30-other-filth-before` | 30 | TF-20 |
| Other mod, after | `-DepMap wsl-deps.otherfilth-after.map -Filter 31-other-filth-after` | 31 | TF-20 |

The two settings seeds are small XML files named as the game names a settings file (`Mod_Housebroken_HousebrokenMod.xml`)
under `config/<pass>/`. The "other mod" of TF-20 is a pair of tiny companions in `OtherFilth/` that add the vanilla
age stat part, a constant times 1.5, to the same stat, one loaded before Housebroken and one after.

What Pickle does not replace, and stays a person's check: hovering is now a step (`HoverSteps` in PickleTools), but
whether a French sentence reads well, and whether a tooltip covers what it should, is for a person looking at the captures.

## Gallery photographs (both pictures accepted by the owner, 2026-10-08)

`40-gallery.feature` takes two photographs for the Workshop page on the Sanctuaire de Nelim. The Sanctuary now lives in its own repository,
`SanctuaryBacklot` (save `Nelims-tribe`, named places, `docs/GALERIE.md`). Three families of steps, told apart by prefix:
`Nelim's Sanctuary:` (SB: load place, animals removed), `Nelim's Pickle Tools:` (NPT: animals, decor, screenshot mode) and `Housebroken` (this mod).
`wsl-deps.gallery.map` stages `SanctuaryBacklot/Mod` and the PickleTools it needs; the fixture is never staged from ScreenshotStudio (a duplicate fails Pickle).

Places: `hearth-hall` (roofed room of the colonist's house, indoor rule) and `calm-zone` (cream floor built in the open, outdoor rule; natural soil never receives an animal's dropping, so open ground such as `statue-garden` cannot be used); free cells read in `SANCTUAIRE-CASES.md`.
Each scenario asserts the filth rate it shows (0 and 1 indoors, 0.3 outdoors). The run of 2026-10-07 was green but the pictures were rejected: the
frame followed one animal that wandered during the 251 ticks, with no cow and no dropping in view. The frame is now the cell at zoom 11. Kept as `Art/Gallery/1-indoors.png` and `2-outdoors.png` (run 61f3 and run e924). To replay, open the
captures, then copy the kept ones to `Art/Gallery/`.

## Passes, and their order

Three families (`AUDIT.md`): **without the optional mods** (the minimal rows above: Core, DLC, Harmony, the mod), **with the optional
mods** (the RIMMSQOL, hover, other-filth rows: the tools that exercise a path, none is a `loadAfter` of the mod), and **one per declared
incompatibility** (none: the mod declares no `incompatibleWith`). The tables above are the full list: 3 passes of the settings page, then
the 12 passes of TF-01 to TF-22.

**Order.** What has never run or is red is replayed alone, in a small ticket (`-Filter`). The non-regression passes, which replay what already ran green, are deposited together on the final revision; for Housebroken they were queued after the publication, as small tickets (fail fast), and their verdicts are in `docs/runs/2026-10-08.md`.

## State

Every scenario TF-01 to TF-22 passed under Pickle (2026-09-25, 26, 28); none is `@wip`; the gallery passed 2026-10-08. The limits (walking is a teleport, no click on an alert entry, the main-bar tooltip is not observable, the settings window is clipped at 200 percent) are recorded in `TESTS_FONCTIONNELS.md` as limits, not open tests. Whether RIMMSQOL remembers a button-visibility choice after a restart belongs to RIMMSQOL. The non-regression replay on the published revision was queued 2026-10-08 (`docs/runs/2026-10-08.md`).

## Launching and keeping evidence

Never launch the Windows RimWorld. A run is a request: `Submit-PickleRun.ps1 ... -EvidenceDir Tests/Pickle/Evidence/<run>` (see
`Rimworld-Ticket-Dispatcher/docs/SUBMIT.md`), written with the repository SHA in the `-Label`, since a request carries no SHA and the mod
tree must stay frozen until `RUN_DONE`. Read `exitReason` and the played/discovered count, open every `@review` capture, then **minify
before handing over** and add one line to `docs/runs/`. [docs/runs/README.md](docs/runs/README.md) says what is kept (`summary.md`,
`junit.xml`, `log-check.txt`, a few small JPEGs of what only a picture answers) and what is dropped (PNGs, `report.html`,
`messages.ndjson`, `Player.log`). `Tests/Pickle/evidence/` is on disk and ignored by git, as are `*.dds` and `*.webm`; the table of the
latest proof per scenario is in [docs/runs/2026-10-02.md](docs/runs/2026-10-02.md).
