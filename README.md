# Housebroken

A trained or intelligent animal makes less mess, and does its business outside instead of in
your base. RimWorld 1.6.

## What the mod does

**1. A lower filth rate.** Two multiplicative factors, both adjustable:

| Criterion | Default |
| --- | --- |
| Obedience learned | −50 % |
| Trained beyond obedience | −75 % |
| Species of intermediate trainability | −20 % |
| Species of advanced trainability | −40 % |

A husky (advanced) that has learned obedience and hauling: 0.25 × 0.6 = **0.15**, that is 85 %
less filth. The sentience catalyst raises trainability by one step, so it counts here on its own.

**2. Manure outside.** An animal that already gets a reduction holds it while inside the base,
and relieves itself once out. "Inside the base" means a roofed room of the home area — the very
definition the vanilla alert already uses — and an option widens it to the whole home area. The
"outside" slider sits at 200 % by default: what was held in comes back out rather than vanishing.
At 100 %, the colony simply produces less filth overall.

**3. Mud tracked in.** The same animal keeps the mud and blood it picked up on its feet while
inside the base, and drops them once outside. This is a separate setting: clean feet are worth
having even without the manure rule.

**4. The alert.** Animals the mod has made cleaner no longer trigger the "animal filth" alert.

## How it hooks in

Everything a pawn **produces** goes through a single point:

```
Pawn_FilthTracker.Notify_EnteredNewCell()
    → Rand.Value < pawn.GetStatValue(StatDefOf.FilthRate) * 0.005f
```

and the alert compares that same stat against 4. So the mod grafts itself on with a **StatPart**
on `FilthRate` (`Patches/FilthRate.xml`) rather than a Harmony patch on the tracker. That is the
vanilla way — see `StatPart_Trainable` — the stat tooltip explains the reduction on its own, and
compatibility with other mods stays as wide as it can be.

The StatPart depends on the pawn's position, which is legitimate here: both callers pass
`cacheStaleAfterTicks = -1`, so `StatWorker.GetValue` caches nothing. This is what makes the
manure rule possible without storing a single byte in the save. The training-and-species half of
the calculation is cached by the mod instead (250 ticks), because the StatPart is asked for a
value on every cell a pawn walks into.

Two Harmony patches, no more. A postfix on `Alert_AnimalFilth.CalculateTargets`, which drops
clean animals from the alert's two parallel lists. And a prefix on
`Pawn_FilthTracker.TryDropFilth` for the mud: that one is out of the StatPart's reach, because
`Notify_EnteredNewCell` calls `TryDropFilth` on a fixed constant — 0.05 per cell — with no link
to `FilthRate` at all. Carried filth is already serialised by `Pawn_FilthTracker.ExposeData`, so
holding it in adds nothing to the save either.

## Saves

The mod adds no comp and no data to the save. It can be added to or removed from a game in
progress with no consequence.

## Repository layout

The Workshop uploader sends the mod folder as it stands, with no filtering —
`SteamUGC.SetItemContent` takes the root directory and nothing else. `Source/` therefore ships
with the mod, which is harmless at 36 KB and fits an MIT mod. What must not ship is the build
intermediates: `Source/Directory.Build.props` keeps `obj/` out, since the publicised
`Assembly-CSharp.dll` it holds — about 6 MB of Ludeon's own code — would otherwise go to every
subscriber.

## Build

    dotnet build Source/Housebroken.csproj -c Release

The assembly lands in `Assemblies/`. Reference assemblies come from NuGet
(`Krafs.Rimworld.Ref`), so no RimWorld installation is needed to compile.

See `ATTRIBUTION.md` for where the idea came from, and `CHANGELOG.md` for the history.
