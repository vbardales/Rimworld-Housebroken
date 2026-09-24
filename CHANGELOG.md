# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it in game.

## 0.1.0

- Creation of the `PublishedFileId.txt` file (`Mod/About/PublishedFileId.txt`): the Workshop item exists, id
  `3806137798`. It was created by the prepublication.

The content of this version is everything described below: the first version, then the fixes and additions made
before the prepublication.

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
