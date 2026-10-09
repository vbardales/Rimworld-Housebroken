# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it in game.

## [1.0.0] - 2026-10-08

This is 1.0.0, dated at prepublication as AUDIT.md requires; Steam received it when it was published, on 2026-10-08. Decided by the owner: this is the first real publication, uploaded on top of the `0.1.0` prepublication item
(3806137798). Rollback, if needed after the upload, is switching the item back to private, not a code revert.

### Added

- A tooltip on the Intermediate trainability slider (`Housebroken.Settings.IntermediateTip`), the only reduction
  row that had none; English and French.

### Changed

- `modVersion` in `About.xml` moved from 0.1.0 (the version the Workshop item was created with) to 1.0.0.
- The Steam description moved to a single Markdown source, the fenced block under "## Steam description" of
  `PUBLICATION.md`; `Mod/README.template.md` and its `.steamignore` lines are dropped.
- The manure-outside texts (description, README, `ManureOutdoorsTip` in English and French) now say the held filth is dropped only on built flooring outside: the game never lets an animal soil bare natural ground.
- The tooltip of "Whole home area counts as inside" no longer says an unroofed pasture gets manure: only built flooring in the open does.
- Settings texts reworded in French (`ColonyOnlyTip`, `OutdoorTip`, `WipeFeet`) and in the English description.
- TF-01 through TF-22 played and passed under Pickle, with their limits recorded in `TESTS_FONCTIONNELS.md`.

## [0.1.0]

- Creation of the `PublishedFileId.txt` file (`Mod/About/PublishedFileId.txt`): the Workshop item exists, id
  `3806137798`. It was created by the prepublication.

This version contains the first version and the fixes and additions made before prepublication, described below.

## First version — RimWorld 1.6

Written on 2026-09-04, before the version number was fixed; it is what 0.1.0 contains.

### Added

- An animal's filth rate is reduced according to its individual training (obedience, then later training) and its species' trainability (intermediate, advanced). The sentience catalyst is accounted for, since it raises trainability by one step.
- Dung outdoors: a clean enough animal holds it in while inside the base and relieves itself once out.
- Tracked-in mud: a clean enough animal keeps the mud and blood it picked up on its paws while inside the base, and drops it once outside. Set separately from dung.
- Animals that have become clean are exempt from the "animal filth" alert.
- Everything is adjustable in the mod settings.

### Notes

- No data is added to the save: the mod can be added to or removed from an ongoing game.

## Before the prepublication

Made between 2026-09-12 and 2026-09-20, and included in 0.1.0.

### Added

- An optional MainButtons shortcut, hidden by default, opening the native Housebroken settings dialog.
- English/French settings scope guidance and French shortcut translation.
- Technical settings and shortcut tests; translated manual scenarios with shortcut and migration cases.
- A standalone automated logic test suite and manual functional test scenarios.

### Fixed

- Normalize stored numeric settings to safe slider ranges, with defaults for non-finite values.
- Put the required Steam-formatted GitHub source link at the end of the About description.
- Recompose the Preview with an overhead illustration, contrasting blue accent and 1.6 badge.
- Reject stale cleanliness cache entries when the game clock moves backwards or a
  different pawn reuses an earlier pawn's ID after loading another game.
