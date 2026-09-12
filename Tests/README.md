# Automated tests

Run from the repository root with the .NET 8 SDK:

```powershell
dotnet run --project Tests/Housebroken.Tests.csproj -c Release
```

The executable prints each result and exits with code 1 if any test fails, or 0
if all pass. This is a package-free runner; use `dotnet run`, not `dotnet test`.
Build outputs stay under `.build/tests/`, outside the Workshop folder.

The project compiles the actual production sources for `Cleanliness`,
`StatPart_Housebroken`, both patch bodies and `HousebrokenSettings` through linked
compile items. It does not copy or reimplement their rules. `GameDoubles.cs`
supplies only the game boundary needed to exercise them without launching RimWorld.

Coverage includes training/species combinations and thresholds, eligibility,
cache expiry and invalidation, reused pawn IDs, location boundaries, independent
manure/feet options, alert list alignment, stat transformation and explanation
selection, and resetting every setting. Test state is reset before each case.

These are isolated logic tests, not engine integration tests. The doubles do not
validate Harmony patch installation, XML patch execution, actual room discovery,
random deposits, translation rendering, settings-window callbacks or game save
serialization. `Scribe_Values` is deliberately inert: no persistence claim is made.
See `../TESTS_FONCTIONNELS.md` for the remaining in-game checks.

Also compile against the real reference assemblies to check API compatibility:

```powershell
dotnet build Source/Housebroken.csproj -c Release
```

Verified on 2026-09-12: **47 passed, 0 failed**; production Release build succeeded
with no warnings or errors. The first run exposed stale cache reuse after a clock
rewind; regression coverage also checks a new pawn reusing a previous pawn's ID.
