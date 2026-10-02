# Protocols read

What the session that holds this mod read, in which version, and what it took from it, so that a document that has not
moved is not read twice. **A document is re-read only when its content hash below no longer matches**
(`(Get-FileHash <file>).Hash.Substring(0,12).ToLower()`), or when the task needs a section this note calls partial.

Read on 2026-09-25, session `local_4d2743f4-5c98-4ccc-95af-33bbae4bd890`, monorepo HEAD `9afdc758` (2026-09-25 17:13).
"Version" is the last commit that touched the file (`git log -1`) and whether it was uncommitted, then the first 12 hex digits
of the SHA-256 of its content and its size in bytes. Files of the monorepo are relative to `Documents/rimworld`.

## Read and useful

| Document | Version | Read | What this mod takes from it |
| --- | --- | --- | --- |
| `AGENTS.md` | `90d51374` 2026-09-25 15:25, clean, `36631e730433`, 3265 | in full | The gates in order (settings, translations, then `preTest`); test evidence is kept on disk and not in git, one text line per run in `docs/runs/`; the CI creates the tag and the release, never by hand; no session approves a `publish` |
| `AUDIT.md` | `90d51374`, clean, `f46fe88e5ec0`, 58839 | in full | The chain and each transition. **`done -> tested`**: scenarios run and green, Pickle green with every `@review` capture opened, no `@wip`, every conditional scenario run, no manual test left, FR and EN checked. **`tested -> prepublished`**: `PUBLICATION.md`, description order, thanks, gallery order, deps and DLC. **`prepublished -> published`**: the 1.0.0, fail fast (no red without a green replay first, gallery, owner's manual checks, rollback target). The `0.1.0` prepublication and its changelog line. Pickle rules: two passes at least and TESTING.md says how many; a green run proves the path, not the picture. The session title is `<mod> / <stage>` |
| `PUBLISHING.md` | `90d51374`, clean, `3d83491eb5bf`, 45391 | in full | The description is sent once, at creation; thanks and comments rules; English everywhere; copies of ATTRIBUTION must be compared; topics and social preview for a public repository; the by-hand 1.0.0 steps are the owner's; git rules for a shared index (pathspec on `commit`, never `--amend` without `git log -1`) |
| `TRANSLATIONS.md` | `90d51374`, clean, `3368579d01dc`, 6109 | in full | The gate is `complete` here (`localization`, `translation_en`, `translation_fr`). What is left is the runtime check in both languages: raw keys, fallback, clipping. That is TF-16 |
| `PickleTools/Headless/README.md` | `b2712fc` 2026-09-25 15:03, clean, `988dbf0dcee7`, 35889 | in full | `-Filter` terms, one pass one request, `-Then`, `-ThenWithout` (first real use is TF-18), settings seeds under `config/<pass>/`, the pass map lines, exit codes, screenshot names reach MAX_PATH, the game logs in UTC |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | `79668cc` 2026-09-25 17:16, clean, `b9f93a680f17`, 7626 | in full, twice | One test for a fix or an exploration, everything for an initial or final pass; deposit a request, keep no process, no watcher; **a request carries no SHA: freeze the mod tree until `RUN_DONE` and write the SHA in the label**; keep only `summary.json` and `junit.xml` in evidence; write the version read of each document (point 5) |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | `79668cc`, clean, `9ac5e37bb64c`, 11645 | in full | Every option of `Submit-PickleRun.ps1`; `-DepMap` is a file name alone; `-EvidenceDir` is relative to the root and always given; `-Extra '-pickle-scenario-timeout=N'`; exit codes in `RUN_DONE` |

## Read, partly useful

| Document | Version | Read | What applies |
| --- | --- | --- | --- |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | `d403592` 2026-09-25 16:33, clean, `6f556de4bbf7`, 31325 | in full | Only the dry-run section, the publish workflow template (`generate-publish-workflow.sh`, `--require`, `--description-file`, `--gallery-dir`) and "First Workshop publication". Housebroken has a DLL, so the `Source/*.csproj` check passes and the runner's DLL is compared with the committed one: the committed `Mod/Assemblies/Housebroken.dll` is what ships. The rest (credentials, Skill Icons history, Codespace) is the owner's or another mod's |
| `Housebroken/STATUS.md` | `9b1e07d` 2026-09-25 13:35, clean, `54f859619458`, 29060 | front matter and headings; the historical audits skimmed | Written by this session and by earlier audits. Only the front matter, "Gate to `tested`" and the latest result are live |
| `Housebroken/README.md` | `b1bcc1b` 2026-09-13, clean, `3fd0623b7ce7`, 4722 | in full | **Was stale in three places, corrected the same day:** "These scenarios have not yet been executed in game", "Interactive RIMMSQOL compatibility is awaiting in-game validation", "Functional add/remove validation remains pending" |
| `Housebroken/CHANGELOG.md` | `41d1b55` 2026-09-24, clean, `5a6d9fea09e3`, 2299 | in full | The 0.1.0 section was written `## 0.1.0`; AUDIT and the CI want `## [0.1.0]`, corrected the same day |
| `Housebroken/TESTING.md` | `1bbe583` 2026-09-24, clean, `a396acc0b3f0`, 5934 | in full | The eleven passes of TF-01 to TF-22 |
| `Housebroken/Mod/About/About.xml` | `2c4e14b` 2026-09-24, clean, `66c1402cefd2`, 3134 | in full | THANKS lacked the test tools and RIMMSQOL, and the AI line did not name Codex: corrected on 2026-09-25 |
| `Housebroken/ATTRIBUTION.md`, `LICENSE` | `06fad23`, `ae6ae5fa894c`; `0cd6a55`, `ae6ae5fa894c` | in full | The two distributed copies in `Mod/` are byte for byte identical |

## Read and not useful: do not read again unless the hash moves and the task changes

| Document | Version | Why it did not help |
| --- | --- | --- |
| `STYLE_RIMWORLD.md` | `90d51374`, clean, `de13cbe5e1f9`, 31676 | How the owner has the Preview and the ModIcon drawn. This session generates no image. Two lines matter and are repeated in PUBLISHING.md: the ModIcon is the owner's, and `Preview.png` is 896 x 504 and under 1 MB |
| `scripts/SEARCHING.md` | `90d51374`, clean, `9dbd52b2bcd4`, 9594 | Searching the Workshop corpus. Housebroken asks nobody else's defName. The session Grep tool times out on that corpus: use the script |
| `PickleTools/README.md` | `2b7b6d0` 2026-09-25 17:22, clean, `6ea974180eb8`, 7912 | The tool catalogue. HoverSteps is now in its payload (fourteen DLLs). Read it only to look for a tool |
| `PickleTools/docs/steps.md` | `7268217` 2026-09-25 17:22, clean, `9ee5aa2ee87f`, 18942 | A generated list of steps. Read it before writing a step, not otherwise |

## Absent in this repository

`BACKLOG.md`, `NOTES.md`, `BUGS.md`. No workflow under `.github/`. `PUBLICATION.md` was absent when this note was first written and was

added the same day, on the model of `SkillIcons/PUBLICATION.md` (90d51374, read for its structure only).

## Read afterwards, for the publication

| Document | Version | Read | What applies |
| --- | --- | --- | --- |
| `WORKSHOP_COMMENTS.md` | modified and uncommitted by another session before this session edited it; 17b48700eece after this session's edit | table and process | One main comment per recipient page for the whole collection. Housebroken was added to the `Covers` of Harmony, Pickle, RimLogging, RIMMSQOL and PickleTools, and a `drafted` row was added for FlyingSloth's mod. The file was left uncommitted because it carries another session's pending rows |

## Referenced but not read in this pass

`MOD_SETTINGS.md` (the gate is already `complete` in STATUS.md), `PickleTools/Authoring/README.md` (read on 2026-09-24, version not
kept), `EXTERNAL_TOOLS.md`, `WORKSHOP_COMMENTS.md` (the registry of thanks comments, needed for the entry of FlyingSloth's mod),
`PickleTools/Upstream/PENDING.md`.
## Re-read on 2026-09-28 (the protocols moved: `AGENTS.md`, `AUDIT.md`, `TRANSLATIONS.md` and the others are now owned by the protocols repository, edited in place)

Same rule: a document is re-read only when its hash moves. Every hash below differs from the table above.

| Document | Hash now (12 hex) | Re-read | What changed for this mod |
| --- | --- | --- | --- |
| `AGENTS.md` | `6cee468a7521` | in full (condensed) | Same rules, shorter. Evidence: latest report per scenario for the current revision, list before deleting, never delete what a STATUS field points to |
| `AUDIT.md` | `27bb0c0aac43` | in full | Step 12 (backward audit: replay `options -> l10n` against the current documents, `preTest -> done`), `Art\ModIcon.ico` and `Art\Preview.ico` for `desktop.ini`, the 1.0.0 stays `unreleased` in CHANGELOG above 0.1.0 until `published`, session title `<packageId without nelim.> / <stage>`, `-Language` per pass, fail fast |
| `TRANSLATIONS.md` | `298f74d226da` | in full | New rule of 2026-09-25 on counts and plurals (`.One`, `.Many`, `.Zero`). Housebroken shows percentages and multipliers only, no counted noun: nothing to split (checked 2026-09-28) |
| `MOD_SETTINGS.md` | `404916bc99a7` | not re-read | Moved; the gate is `complete` and the task did not touch the settings design |
| `PUBLISHING.md` | `513f110ae0b6` | not re-read | Moved; publication goes through the CI, `PUBLICATION.md` holds the page |
| `STYLE_RIMWORLD.md` | `2c6db32396ae` | not re-read | Moved; no image is generated here |
| `scripts/SEARCHING.md` | `013075b06b89` | not re-read | Moved. Rule taken from the dispatcher's message of 2026-09-28: never `find /` or `grep -r` on `/` or `C:\`, search one named folder |
| `WORKSHOP_COMMENTS.md` | `4ec43a9b47c1` | not re-read | Moved; registry of thanks comments, needed at publication |
| `PickleTools/README.md`, `Headless/README.md`, `docs/steps.md` | `628350c7bcc3`, `2310bb974f68`, `2d17e1b10ed7` | not re-read | Moved; read when a step is written or a tool looked up |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | `23fcf6423000` | its description-standard lines only | One-source description standard, already applied (2026-09-27) |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md`, `SUBMIT.md` | `08b440a03f74`, `eaca3969c7eb` | not re-read | Moved; commands already in use worked unchanged |

## Re-read on 2026-10-02 (audit session, monorepo HEAD `c770fd1e`)

Same rule: a document is re-read only when its hash moves. Hashes are the first 12 hex digits of SHA-256, and sizes in bytes.

| Document | Hash now | Read | What this mod takes from it |
| --- | --- | --- | --- |
| `AGENTS.md` | `7a236f03ca15`, 2716 | in full | Evidence: keep the latest report per scenario for the revision in the repository, delete the rest once a newer one replaces it; `pickle-reports-archive/` is trimmed by each session for its own runs (done: `stalled-Housebroken-0928-2212`); history is one text line per run in `docs/runs/` |
| `AUDIT.md` | `7c00eb1f3b1b`, 69900 | in full | **`done -> tested`** now says it in four lines: no scenario `@wip`; every `@requires:<packageId>` scenario ran with the map that mounts it; no manual test left to validate; `@review` captures opened. Non-regression passes go last, after the new and red ones, on the final revision. Step 12 of the chain, the WSL clean-up and the branch clean-up apply only at `published`. The session title is `<packageId without nelim.> / <workflow_stage>` |
| `TRANSLATIONS.md` | `e381086a5271`, 14121 | in full | French review by the owner (`FRENCH_REVIEW.md`), no pawn-gender text in this mod; `translation_fr` stays `partial` until she reviews |
| `PUBLISHING.md` | `30a1c36885ed`, 65104 | the start, "Mods qui ajoutent des animaux", "Dépôt", "Juste après", "À chaque mise à jour" | If an origin repository exists, a PR to it is systematic and goes in `BACKLOG.md` (none exists here, see below). The four animal-mod integrations concern mods that **add** animals: Housebroken adds none, so none applies |

Not re-read, unchanged: `MOD_SETTINGS.md` (`404916bc99a7`), `scripts/SEARCHING.md` (`013075b06b89`),
`PickleTools/Headless/README.md` (`2310bb974f68`), `Rimworld-Release-Admin/docs/OPERATIONS.md` (`23fcf6423000`),
`Rimworld-Ticket-Dispatcher/docs/WELCOME.md` (`08b440a03f74`) and `SUBMIT.md` (`eaca3969c7eb`).

Moved but not useful to this task (no image generated, no comment posted, no step written, no tool looked up), so
not read: `STYLE_RIMWORLD.md` (`5a054cf3a04b`), `WORKSHOP_COMMENTS.md` (`3fb37586f04b`, only its Housebroken rows were
searched: Harmony, Pickle, RimLogging, RIMMSQOL `posted`, PickleTools `not_applicable`, FlyingSloth `drafted`),
`PickleTools/README.md` (`40e44a5d2c12`), `PickleTools/docs/steps.md` (`6cb87154cdb9`).

Mod documents of this repository: `STATUS.md`, `CHANGELOG.md`, `TESTING.md`, `PUBLICATION.md` (to the Steam description),
`TESTS_FONCTIONNELS.md` (the execution record), `docs/runs/`, `Tests/Pickle/` features and `About.xml` were read. `README.md`
and `ATTRIBUTION.md` were checked for the origin question only. `BACKLOG.md`, `NOTES.md` and `BUGS.md` do not exist here.
