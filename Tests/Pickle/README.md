# Housebroken Pickle suite

This companion mod is development-only and never ships in `Mod/`. Its Gherkin covers only what
the existing .NET/XML runner cannot establish: the real `Dialog_ModSettings` window, its game
settings file, the hidden MainButtons worker, RIMMSQOL's reveal/hide path, and visual English or
French rendering. The deterministic filth-rate mathematics, Scribe boundary cases, metadata,
patch contracts and Keyed/DefInjected coverage remain in `Tests/Housebroken.Tests.csproj`.

The probabilistic deposits, map-room arrangements, carried filth, alerts and existing-save cases
remain explicitly specified in `../../TESTS_FONCTIONNELS.md`. They need dedicated, observable
animal fixtures before a Gherkin assertion would be meaningful; this suite does not pretend that
a generic fixture proves them. Add those fixtures and scenarios before calling their runtime
behavior validated.

Build the companion steps, then check the output is present before any future run:

```powershell
dotnet build Tests/Pickle/Source/Housebroken.PickleSteps.csproj -c Release
```

Future runtime validation uses only the shared WSL launcher, never the Windows game:

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod Housebroken -DepMap wsl-deps.runtime-evidence.map -Language English
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod Housebroken -DepMap wsl-deps.runtime-evidence.map -Language French
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod Housebroken -DepMap wsl-deps.avec-rimmsqol.map -Filter 04-rimmsqol.feature
```

Each `@review` screenshot needs a human review after a complete report: check French for raw
keys/accented fallback or clean English literals, confirm controls are not clipped, and confirm
the shortcut opens the Housebroken settings page. A green capture proves only that it was taken.

The 2026-09-22 evidence is preserved under `evidence/2026-09-22/`: the English and French
`runtime-evidence` reports each have 3 passed, 0 failed, 1 skipped (RIMMSQOL absent), while
`avec-rimmsqol-English` has 1 passed, 0 failed. Each folder retains the complete report files
and only its Housebroken screenshots. All seven captures were reviewed as legible and unclipped;
the three runs cover different configurations, so none was cycled. They do not establish the
manual animal/gameplay scenarios or RIMMSQOL's own persistence across a restart.
