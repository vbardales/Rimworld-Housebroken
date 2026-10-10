---
localization: complete
translation_en: complete
translation_fr: complete
settings_audit: passed
mod:          Housebroken
packageId:    nelim.housebroken
repo:         Rimworld-Housebroken
visibility:   public
detached:     yes
workflow_stage: followUp[1.0.0]
licence:      original
licence_at:   original work, MIT (LICENSE and Mod/LICENSE)
upstream_mod_remotes: N/A (Sentience Catalyst Filth Rate Reducer, FlyingSloth, workshop 3525790312, gave the idea only,
  none of its code used; no repo URL in its About.xml, Source/, or the Steam page. Checked 2026-09-28 and 2026-10-02)
dependencies: declared
showcase:     complete
tested_on:    TF-01 to TF-22 under Pickle (2026-09-25, 26, 28); gallery 2026-10-08; non-regression replay on the published revision 2026-10-08 and 2026-10-09, all green (TF-20 after green on replay 15f8 after the staging fix 265e0c1; docs/runs/2026-10-08.md)
workshop:      3806137798
remaining:
  - passed, out of scope (owner's rules, 2026-10-09: what belongs to RIMMSQOL is not retested; only the latest version of a third-party mod is tested at any given time): the shortcut reveal/hide passed once in WSL; persistence of the choice, other customization tools and older RIMMSQOL versions are not tested here.
  - passed, limits recorded and not defects: walking is a teleport, no click on an alert entry, the caravan goes through game
    functions, the main-bar tooltip is not observable, the settings window is clipped at 200 percent (TESTS_FONCTIONNELS.md).
code_review_sha: a843855f30c382122b7ddd1e5db33b7c0ffc579c  # no code change in Source, Defs, Patches or the DLL since 6560a18; range 6560a18..a843855 reviewed 2026-10-10: 3 Keyed text edits (WholeHomeAreaTip EN and FR, IntermediateTip FR), no finding
publication_changelog_review_sha: 76aeb3e0e6c01ee34e3f0e991e9579083e6c2722  # PUBLICATION.md and CHANGELOG.md reviewed by the owner, confirmed in chat 2026-10-10
wsl_cleanup: 2026-10-09, nothing removed. The only Workshop item named by a Housebroken `wsl-deps` map is RIMMSqol 1084452457, still named by the maps of many other mods (kept). The other entries are local `path:` mods (PickleTools, SanctuaryBacklot, Housebroken test mods), staged and emptied by stage-pickle-wsl.sh, none downloaded.
session:      local_f471ae05-1325-4c5f-b3af-4ca7cfd99079
updated:      2026-10-08, published; STATUS.md cleaned to the current state (older dated sections are one line each in docs/runs/2026-10-08.md; the full text is in git)
protocols_read_sha: 3f0f61bff6203d1bb16a8a5c3dd865a1ad714b45
---

# Housebroken — status

## State

Published on the Workshop (item 3806137798), public since 2026-10-08, version 1.0.0, on RimWorld 1.6.

- **Published revision:** SHA `c360021adbb3ad7f71e27bbfc753f18b8b04da3c`. Dry-run
  [37798996377](https://github.com/vbardales/Rimworld-Housebroken/actions/runs/37798996377), publish run
  [37800930249](https://github.com/vbardales/Rimworld-Housebroken/actions/runs/37800930249) with `update_preview` and `update_description`,
  `steam-production` approved by the owner. The CI created tag `v1.0.0` and the GitHub release `Housebroken 1.0.0`.
  `Mod/About/PublishedFileId.txt` holds `3806137798`.
- **Tested tree vs published tree:** they differ only by the `<description>` of `About.xml` (synced from `PUBLICATION.md`), the
  French and English settings texts reworded on 2026-10-08 (`ColonyOnlyTip`, `OutdoorTip`, `WipeFeet`, `ManureOutdoorsTip`,
  `WholeHomeAreaTip`, `IntermediateTip`, `AdvancedTip`, `Intro`, `WipeFeetTip`), text only, no logic. DLL unchanged since `6af8e17`.
- **Gallery:** `Art/Gallery/0-preview.png` (the Preview), `1-indoors.png`, `2-outdoors.png`, all accepted by the owner 2026-10-08
  and uploaded by hand. Outdoors scene: the game never lets an animal soil bare natural ground (`FilthMaker.CanMakeFilth`), so
  the held filth is dropped only on built flooring outside; the description, README and `ManureOutdoorsTip` say so.
- **Owner's steps done, stated 2026-10-08:** public page read, gallery uploaded, Harmony as required item, subscriptions, FlyingSloth
  thank-you posted (the other recipients already cover Housebroken in their collective comment; register `WORKSHOP_COMMENTS.md`).
- **Offline runner:** `Tests/Housebroken.Tests.csproj`, 59 of 59 pass on 2026-10-08.
- **Code review** (field `code_review_sha`): last reviewed commit `a843855f30c382122b7ddd1e5db33b7c0ffc579c` (2026-10-10, range `6560a18..a843855`: no code change,
  three Keyed text edits, `WholeHomeAreaTip` EN and FR now agree with the built-flooring rule, `IntermediateTip` FR reworded, no finding).
  Earlier: `6560a18fa893883989ebe1df07d633fbaba80d8f` (`/code-review`, low effort, range `1509201..6560a18`: one finding, `WholeHomeAreaTip`
  contradicting the built-flooring rule, fixed in `c07e748`); `1509201eeabb7e1ef53895a5ce6ad004173b0283`, no finding.

## What it is made of

A `StatPart` on `FilthRate` carries the whole reduction, added by a conditional XML patch that tolerates either load order. Two
Harmony patches do the rest: one holds the drop while the animal is inside the base (`Patch_TryDropFilth`), one keeps the animal out
of the vanilla filth alert. Eleven settings (six numeric factors: obedient .5, well-trained .25, intermediate .8, advanced .6, indoor 0,
outdoor 2; five booleans: colony-only, outdoor manure, wipe-feet and alert exemption true, whole-home false), no save data, safe to add
to or remove from a running game. Settings: Mod options -> Housebroken (native overrides); a hidden `MainButtonDef` shortcut opens the
same page for RIMMSQOL and compatible customization mods. English and French; no text agrees with a pawn's gender, so no French
gender-agreement convention applies.

## Findings that still count

- **Settings:** sliders clamp (reductions 0..100 %, outdoor 100..400 %), conditional controls follow `manureOutdoors`, reset restores
  all eleven fields, values are global through ModSettings/Scribe, `WriteSettings` clears the trait cache (normal expiry 250 ticks).
  Persistence, older files and out-of-range values were played under Pickle (TF-15, TF-22).
- **Translation:** every French and English key resolves, placeholders match (checked by the XML tests). `Check-DefInjected.ps1` is not
  applicable: no owned Def label or nested translatable field. `FRENCH_REVIEW.md` is generated by `scripts/Make-FrenchReview.ps1`
  and was reviewed by the owner on 2026-10-08 (two rounds, validated); no session marks it reviewed on its own.
- **Passes:** the pass list, commands and limits are in `TESTING.md`; what each run showed is in `docs/runs/`.

## Art sources and regeneration

- Sources: `Art/Preview-source.png` (text-free illustration), `Art/ModIcon-source.png` (the owner's icon, trimmed of its transparent
  padding on 2026-10-08 on her express authorisation, 1180 x 1078), `Art/Preview.config.json`. The earlier versions (`*-original.png`)
  were deleted on 2026-10-09 (closing pass; git history keeps them).
- The config reads `ModIcon-source.png` for both the delivered ModIcon (`modIconSource`) and the Preview corner badge
  (`iconBadge.file`). There is no separate badge file: the shared renderer refuses a source with excessive transparent padding, so
  the source itself stays trimmed. Do not re-add padding when the owner replaces it; trim it first.
- Regenerate from the mod root: `node ../scripts/Render-Preview.cjs`. It writes `Mod/About/ModIcon.png` (128 x 128),
  `Mod/About/Preview.png` (ModIcon badge bottom-left), `Art/Gallery/0-preview.png` (byte-identical copy of the Preview),
  `Art/Preview.ico` and `Art/ModIcon.ico`. QA files go to `Art/.render/`, ignored by git.
- Gallery pictures `Art/Gallery/1-…` and later come from Pickle runs, not from the renderer (`PUBLICATION.md`, `TESTING.md`).

## Field vocabulary

`workflow_stage`: the chain in AUDIT.md (this mod: `followUp[1.0.0]`; the old `stage` field and its codes are retired). `licence`: `open` an explicit licence, `silent` no licence and a
dead source, `alive` no licence but a living source, `forbidden` a written refusal, `original` owing nothing to anyone. `remaining`:
`feature` for something missing from a first release, `defect` for a known fault left unfixed, `unverified` for what could not be checked.
