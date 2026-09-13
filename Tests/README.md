# Automated tests

Run from the repository root with the .NET 8 SDK:

```powershell
dotnet run --project Tests/Housebroken.Tests.csproj -c Release
```

The executable prints each result and exits with code 1 if any test fails, or 0
if all pass. This is a package-free runner; use `dotnet run`, not `dotnet test`.
Build outputs stay under `.build/tests/`, outside the Workshop folder.

The project compiles the actual production sources for `Cleanliness`,
`StatPart_Housebroken`, both patch bodies, `HousebrokenSettings`, `HousebrokenMod`
and `MainButtonWorker_Housebroken` through linked
compile items. It does not copy or reimplement their rules. `GameDoubles.cs`
supplies only the game boundary needed to exercise them without launching RimWorld.

Coverage includes training/species combinations and thresholds, eligibility,
cache expiry and invalidation, reused pawn IDs, location boundaries, independent
manure/feet options, alert list alignment, stat transformation and explanation
selection, and resetting every setting. Test state is reset before each case.

These are isolated logic tests, not engine integration tests. The doubles do not
validate Harmony patch installation, in-game XML patch execution, actual room discovery,
random deposits, translation rendering or actual game save serialization.
Settings tests execute production UI conversions, reset confirmation, normalization
and WriteSettings. A Scribe boundary double records/parses values through an XML
document to test all eleven fields and older missing values. A dialog boundary double
exercises closing through WriteSettings; its contract was checked against the installed
native Dialog_ModSettings. This proves the mod-side contract, not native disk persistence
or interactive UI integration. Slider boundaries are tested with injected widget results;
there is no free-text numeric input in the player UI.
See `../TESTS_FONCTIONNELS.md` for the remaining in-game checks.

XML tests parse every shipped XML file, check both conditional FilthRate patch
branches using .NET XPath and append semantics on fixture definitions, and ensure
existing parts and unrelated stats survive. They also check publication metadata,
the exact final Steam GitHub link, language key parity, placeholders, source translation
key coverage, hidden MainButton definition and French injection fields. These are
contract tests, not execution of the RimWorld patch engine.

Also compile against the real reference assemblies to check API compatibility:

```powershell
dotnet build Source/Housebroken.csproj -c Release
```

Verified on 2026-09-12: **52 passed, 0 failed**; production Release build succeeded
with no warnings or errors. The first run exposed stale cache reuse after a clock
rewind; regression coverage also checks a new pawn reusing a previous pawn's ID.

Verified on 2026-09-13 after the audit fixes: **59 passed, 0 failed** (47 original
logic cases, 6 XML cases and 6 settings cases). Release build: zero warnings/errors.
See [RESULTS.md](RESULTS.md) for artifact identity, commands and remaining runtime checks.
