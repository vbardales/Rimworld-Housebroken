# Validation results — 2026-09-13

Base revision: `79b58f6cb1bee4ed1aa3b41dfb184c86884cb131`, plus uncommitted audit
fixes. The pre-existing About, status and test changes were preserved and extended.
This report supersedes the pre-fix result for changed components, without erasing
the September 12 result of 52 successful tests.

## Executed checks

- `dotnet build Source/Housebroken.csproj -c Release --no-restore`: passed,
  zero warnings/errors. SDK 8.0.424; reference RimWorld 1.6.4871, Harmony 2.4.2.
- `dotnet run --project Tests/Housebroken.Tests.csproj -c Release`: **59 passed,
  0 failed**. All six XML cases pass, including both FilthRate patch branches,
  exact final repository link and hidden/revealable shortcut definition.
- `powershell -NoProfile -ExecutionPolicy Bypass -File ../scripts/Check-DefInjected.ps1
  -TransMod Mod`: **2 keys checked, 0 errors**, 11,587 indexed Defs, no unresolved
  targets reported. The process-only execution-policy override enables the local
  checker; it does not change the machine policy.
- `node Art/render-preview.cjs` with the bundled Node modules: size and contrast
  checks passed. Direct final-image and thumbnail inspection passed; see Art/README.md.
- All original manual scenarios TF-01 through TF-20 retained in English;
  TF-21 and TF-22 add optional shortcut and legacy-settings checks. None executed.

Shipped `Mod/Assemblies/Housebroken.dll` SHA256:
`8DF40BAEF199F4A896390C438AEB42DAB1623227A029521F92F3C779462E871A`.

## Settings coverage and limits

The executable links all production classes. The six additional settings cases check
all eleven serialized fields through an XML-backed Scribe boundary double, older
missing fields, numeric normalization, slider conversion/clamping, shared native-dialog
configuration and WriteSettings cache invalidation, and reset confirmation.
Existing logic cases cover the actual effect of training/species/location factors,
eligibility, feet, manure, home-area and alert toggles.

Installed game classes were inspected using ILSpy: MainButtonDef.buttonVisible is a
native field, MainButtonWorker.Visible reads it, and MainButtonsRoot skips invisible
workers rather than drawing disabled buttons. Dialog_ModSettings takes a Mod instance,
renders that mod's settings and calls WriteSettings in PreClose. The new worker inherits
native visibility and passes HousebrokenMod.Instance to this native dialog.

These are technical contract checks, not in-game interaction. The Scribe double does
not execute native disk IO, and the dialog double does not validate the Unity event
loop. Actual game logs, disk persistence, FR/EN layout, Harmony installation, new
colonies, existing saves and RIMMSQOL remain unverified. No customization tool/version
has been certified by a live integration test. These checks belong to `done -> tested`
under the user's workflow override.

There are no numeric text boxes: empty/invalid typed input is not applicable to the
player UI. Finite out-of-range stored factors clamp to the supported bounds, non-finite
factors use defaults, and missing fields retain the native Scribe default contract.
No new custom save data or mandatory customization dependency was introduced.
