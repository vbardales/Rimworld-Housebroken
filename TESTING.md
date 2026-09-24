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

All three reports ended with `exitReason: passed`; their seven Housebroken captures were
opened and reviewed. The English RIMMSQOL pass does not establish French shortcut text or
any persistence behavior owned by RIMMSQOL. A French RIMMSQOL pass is needed only if the
French revealed-shortcut label and tooltip are claimed as runtime-reviewed. The manual
TF-16 check remains open for tooltips, reset confirmation, stat explanations and small-screen
layout in both languages.

## Remaining acceptance

TF-01..22 have no complete manual execution record yet. In particular, the Pickle UI
passes do not measure animal filth behavior, validate a new colony or an existing save,
or prove Housebroken settings persist across a game restart. TF-15 and TF-21 should check
Housebroken's own values after restart; whether RIMMSQOL remembers a button-visibility
choice after restart belongs to RIMMSQOL, not Housebroken.

For every future WSL Pickle run, use the shared `scripts/Run-PickleWsl.ps1` launcher and
its `-EvidenceDir` option pointing inside this repository (`Tests/Pickle/Evidence/<run>`,
ignored by git). Inspect `exitReason`, the discovered/playable scenario count, logs and every
`@review` capture. Then **minify before handing over** and add one line to `docs/runs/`;
[docs/runs/README.md](docs/runs/README.md) lists what is kept (summary, JUnit, a log check,
a few small captures) and what is dropped (PNGs, HTML report, message stream, `Player.log`).
Never launch the Windows RimWorld.
