---
mod:          Housebroken
packageId:    nelim.housebroken
repo:         Rimworld-Housebroken
visibility:   public
detached:     yes
stage:        done
licence:      original
licence_at:   original work, MIT
dependencies: declared
showcase:     complete
tested_on:
workshop:
remaining:
  - unverified: never seen running. No off-game test suite either, so the whole runtime side
    is unchecked: the StatPart multiplier, the held-filth rule, and the two Harmony patches.
  - defect: the C# comments are in French, in a public repository. Six files, all of Source/
    plus the patch comment in `Mod/Patches/FilthRate.xml`. The About was fixed on 2026-09-12,
    these were not.
session:      local_4d2743f4-5c98-4ccc-95af-33bbae4bd890
updated:      2026-09-12, detached from the monorepo
---

# Housebroken — status

Kept at the root, never inside `Mod/`, so Steam never receives it. Maintained by the session
that holds this mod, not by the sweep that first wrote it.

## Where it stands

Detached from the monorepo on 2026-09-12 and living in its own repository at
`https://github.com/vbardales/Rimworld-Housebroken`, public. The junction from `RimWorld/Mods`
points at `Housebroken/Mod` and was not touched: the folder never moved, and the four
identifiers were already aligned, so nothing was renamed.

Nothing here is owed to another mod. FlyingSloth's Sentience Catalyst Filth Rate Reducer gave
the idea and is thanked in the About, but no code, def or asset of theirs is used: the
criterion changed from the catalyst to training and trainability. Hence `licence: original`,
MIT.

## What it is made of

A `StatPart` on `FilthRate` carries the whole reduction, added by a conditional XML patch that
tolerates either load order. Two Harmony patches do the rest: one holds the drop while the
animal is inside the base, one keeps the animal out of the vanilla filth alert. Four settings,
no save data, safe to add to or remove from a running game.

## Field vocabulary

`stage`: `port`, `showcase`, `preTest`, `done`, `tested`, `published`. `done` means the work is
finished, not that it is published.

`licence`: `open` an explicit licence, `silent` no licence and a dead source, `alive` no licence
but a living source, `forbidden` a written refusal, `original` owing nothing to anyone.

`remaining`: `feature` for something missing from a first release, `defect` for a known fault
left unfixed, `unverified` for what could not be checked.
