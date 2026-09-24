# Runs

What each Pickle run of this mod showed, in text. **The evidence itself is on disk and ignored by git**:
`Tests/Pickle/evidence/<date>/<run>/` (and `Tests/Pickle/Evidence/`, the spelling the launcher's `-EvidenceDir` uses).
The runner's shared report folder is overwritten by every mod's next run, so a report worth keeping is copied out
before that, then minified. A full run leaves about 20 MB, most of it an HTML report nobody reads twice.

## Which proofs to keep, and which to drop

The disk is full and the shared report folder holds every mod's screenshots (root `AGENTS.md`, "Test evidence").
For this mod:

- **Keep, per run:** `summary.md` and `junit.xml` (a few KB: what played, what failed), a `log-check.txt` (the result
  of grepping `Player.log` for `^(XML error|Config error|Could not resolve|Could not find)` and for `exception`, both
  expected to be 0), and one line in the table of the day's file.
- **Keep, for `@review` scenarios of the current build:** one **minified** capture (JPEG, 1280 px wide, quality 70,
  about 100 KB, never the 4 MB PNG) for each thing only a picture answers: the settings page in each language, the page
  opened from the MainButtons shortcut in each language, and the page opened after the RIMMSQOL reveal. French accents
  and slider labels stay legible at that size; check one before dropping the PNGs.
- **Drop the duplicates:** the capture of `01-settings.feature` shows the same dialog at defaults as the one of
  `03-language.feature` in the same run, so only the latter is kept.
- **Drop as soon as the log check is written:** the PNG captures, `report.html` (about 18 MB), `messages.ndjson`,
  `Player.log` (it carries the home path of the machine that ran it), `summary.json` (a copy of `summary.md`) and
  `archive-complete.txt`.
- **A run of a superseded build proves nothing about the current one.** After a change to `Source/`, to `Mod/` or to
  the Pickle steps, the older folders go once a run of the new build exists; until then they are the only record of
  what the old build did.
- **Never in git:** `evidence/`, `.build/`, `*.webm`, `*.dds`. The repository holds these text files and nothing else.

Rules kept here:

- `exitReason` is read before any number, and the scenarios played are counted against the ones written.
- A run that wrote no report is listed as such; nothing is concluded from it.
- A green `@review` scenario says the trajectory ran, not that the picture was looked at.
- The `avec-rimmsqol` pass and the two `runtime-evidence` passes cover different configurations, so none replaces
  another.

| File | Covers |
| --- | --- |
| [2026-09-22.md](2026-09-22.md) | The first runs of the Pickle suite: English, French and RIMMSQOL, and two tickets that never ran |
