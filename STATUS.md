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
workflow_stage: shootGallery[1.1.1]
licence:      original
licence_at:   original work, MIT (LICENSE and Mod/LICENSE)
upstream_mod_remotes: N/A (Sentience Catalyst Filth Rate Reducer, FlyingSloth, workshop 3525790312, gave the idea only,
  none of its code used; no repo URL in its About.xml, Source/, or the Steam page. Checked 2026-09-28 and 2026-10-02)
dependencies: declared
showcase:     complete
tested_on:    TF-01 to TF-22 under Pickle (2026-09-25, 26, 28); gallery 2026-10-08; non-regression on the published 1.1.0 (5ca8a79) 2026-10-14, 13 tickets, all green (docs/runs/2026-10-14.md); RimWorld 1.7 pass 2026-10-13 (docs/runs/2026-10-13.md)
workshop:      3806137798
tested_1_7:   yes  # 2026-10-13, ticket 5455, 19 of 19 logic scenarios (features 10-14, 28, 29, 33), RimWorld 1.7.4976 rev1043, English, no dependency map, on 5106f83; settings-window, RIMMSQOL, restart-pair and gallery features and French not replayed; no supportedVersions change before Virginie confirms
remaining:
  - feature (2026-10-15, owner order): new gallery series "A morning with Rex" (Nelim, Rex and Daisy, three pictures, one English subtitle each, texts in PUBLICATION.md "Gallery subtitles"). Scenarios, shot plan, `wsl-deps.gallery.map` and seeds are written and Check-Steps resolves every step; NOT played, no picture opened yet. Needs: a Pickle ticket (`-DepMap wsl-deps.gallery.map -Filter 40-gallery`), the pictures opened and read against the plan, `scripts/Add-Subtitle.ps1`, candidates in `Art/Gallery/`, the owner's acceptance, a manual upload to the Steam page. The pair accepted on 2026-10-08 stays in `Art/Gallery/` until then.
  - passed, out of scope (owner's rules, 2026-10-09: what belongs to RIMMSQOL is not retested; only the latest version of a third-party mod is tested at any given time): the shortcut reveal/hide passed once in WSL; persistence of the choice, other customization tools and older RIMMSQOL versions are not tested here.
  - passed, limits recorded and not defects: walking is a teleport, no click on an alert entry, the caravan goes through game
    functions, the main-bar tooltip is not observable, the settings window is clipped at 200 percent (TESTS_FONCTIONNELS.md).
  - unverified (2026-10-10, decision of the owner: 1.0.0 is enough for now, a 1.0.1 may come later): the French texts of `IntermediateTip` and `Scope` and the Preview with the echo are in `main` (see `[Unreleased]` in `CHANGELOG.md`) and in the GitHub social preview, not on Steam. The French page showing `Scope` is not replayed under Pickle yet. A 1.0.1 would send the Preview with `update_preview` on and the description untouched.
code_review_sha: 17d034f302014127d8cd27d0dd17e6927dc20780  # range 47cfe2b..17d034f reviewed 2026-10-14: About.xml modVersion and <li>1.7</li>, one French Keyed text (Settings.Intro), two PackageReference pins in Source/Housebroken.csproj (rebuilt DLL identical byte for byte to the shipped one), no code change, no finding
publication_changelog_review_sha: 9bf1e8164c5eaa9da43bb91d8fdefab29508689d  # PUBLICATION.md and CHANGELOG.md for the 1.1 line, and the French Settings.Intro, validated by the owner in chat 2026-10-13 (the commit only dates the section)
wsl_cleanup: 2026-10-09, nothing removed. The only Workshop item named by a Housebroken `wsl-deps` map is RIMMSqol 1084452457, still named by the maps of many other mods (kept). The other entries are local `path:` mods (PickleTools, SanctuaryBacklot, Housebroken test mods), staged and emptied by stage-pickle-wsl.sh, none downloaded.
session:      local_f471ae05-1325-4c5f-b3af-4ca7cfd99079
updated:      2026-10-15, shootGallery[1.1.1]: gallery series redone on the owner's order (written, not played); 1.1.0 stays the published version; older dated sections are in docs/runs/
protocols_read_sha: 65f1477c389ca6e741af05b7745aa30f6b26b595
echo_review_sha: 0bd8fee1009495504290ed663210e8a069c58393  # Preview echo (Art/echo-source.png, same drawing, renamed) validated by the owner in chat 2026-10-13 with the 1.7 badge Preview
social_preview_sha256: 3d46c189fdcc2f936d97300f7ee06e0a6e46fdd9f1b89d0a5efff03b164ef213  # Mod/About/Preview.png with the 1.7 badge and the translated ModIcon badge, uploaded by the session through Claude in Chrome 2026-10-13 on the owner's order
---

# Housebroken — status

## State

Published on the Workshop (item 3806137798), public since 2026-10-08, version 1.1.0 (published 2026-10-13), on RimWorld 1.6 and 1.7.

- **Published revision 1.1.0:** SHA `5ca8a794a8c1f6fce08109ec6447d74842213f56`. Dry-run [38472925054](https://github.com/vbardales/Rimworld-Housebroken/actions/runs/38472925054), publish run [38473065934](https://github.com/vbardales/Rimworld-Housebroken/actions/runs/38473065934) with `update_preview` and `update_tags` (description untouched), `steam-production` approved by the owner. Tag `v1.1.0` and release `Housebroken 1.1.0` created by the CI.
- **Published revision 1.0.0:** SHA `c360021adbb3ad7f71e27bbfc753f18b8b04da3c`. Dry-run
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
- **Build reproducibility (2026-10-14):** the shipped DLL referenced `0Harmony 2.4.2.0`; the floating `Lib.Harmony 2.*` now resolves 2.4.3, so a rebuild differed (`Build-Mod.ps1 -Check`: CHANGED). Pinned `Lib.Harmony 2.4.2` and `Krafs.Rimworld.Ref 1.6.4871`: the rebuild is byte for byte the shipped DLL (SAME). `Krafs.Publicizer 2.*` stays floating (build tool, no effect on the output).
- **Offline runner:** `Tests/Housebroken.Tests.csproj`, 59 of 59 pass on 2026-10-14 through `scripts/Run-UnitTests.ps1 -ModRoot .` (the project now declares `GameManaged`, the property that script requires; the runner reads no game assembly).
- **Code review** (field `code_review_sha`): last reviewed commit `f54316a083bb02bd40ddb83eaa7d264be67f755c` (2026-10-10, range `a843855..f54316a`: no code change; the
  Preview echo only: the `echo` block of `Art/Preview.config.json`, `Art/echo-source.png`, the re-rendered `Preview.png`, `0-preview.png` and `Preview.ico`.
  The Preview is 896 x 504, 590 KB, and `0-preview.png` is byte for byte its copy. No finding. Note, not a defect: the config declares
  `width: 800, height: 520` for an echo of 1536 x 1024; the renderer uses them only as a box ratio (`--echoAspect`) and the mask is `contain`, so the
  drawing is not distorted; left as validated).
  Earlier: `a843855f30c382122b7ddd1e5db33b7c0ffc579c` (range `6560a18..a843855`: three Keyed text edits, `WholeHomeAreaTip` EN and FR now agree with the
  built-flooring rule, `IntermediateTip` FR reworded, no finding); `6560a18fa893883989ebe1df07d633fbaba80d8f` (`/code-review`, low effort, range `1509201..6560a18`: one finding, `WholeHomeAreaTip`
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

- **Audit 2026-10-15 (AUDIT.md, revision `c2eac27`, working tree clean, in sync with `origin/main`): `dormant` confirmed.** No `Source/` or `Mod/` change since `code_review_sha` (`17d034f`), so the review stays valid. `Check-Status.ps1 -Mod Housebroken`: 0 error, 0 warning. Offline tests rerun: 59 of 59 pass. `Mod/About/Preview.png` sha256 equals `social_preview_sha256`. `About.xml` (1.1.0, `supportedVersions` 1.6 and 1.7, `PublishedFileId.txt` 3806137798), tags `v1.0.0` and `v1.1.0`, one branch (`main`): consistent. Protocols read up to `365bc5e` (only the session-marker rule changed: no marker in the session name any more); `protocols_read_sha` updated. `Build-Mod.ps1 -Mod Housebroken -Check` rerun: BUILD ok (0 warnings, 0 errors), `Housebroken.dll` and `Housebroken.PickleSteps.dll` SAME as shipped. Not rechecked here: anything that needs a running game.

- **1.1.0 closing pass, transitions confirmed (2026-10-14, AUDIT.md 15 and 12):** dependencies unchanged (Harmony as the one hard dependency in `About.xml`, `loadAfter` Core and DLCs, `supportedVersions` 1.6 and 1.7); no settings code or Def change, `settings_audit` stays `passed`; translation: `Settings.Intro` (FR) reworded and validated by the owner 2026-10-13, `Check-Translations.ps1` PASS (17 Keyed calls, coverage, duplicates, tokens); offline tests 59 of 59 on 2026-10-14, **after** the deployment (they had not been rerun before it: AUDIT.md 8.b asks for them before); Preview contrast measured on `Mod/About/Preview.png` 2026-10-14: version badge ink on accent 8.40:1, title 11.35:1 and summary 9.36:1 on median background (the husky echo lowers the worst 5 percent of pixels to about 2.7:1, accepted by the owner), the 268 px render was not rechecked after the corner badge shift (only the badge moved, no text); the owner subscribed to the item after the 1.1.0 upload and confirmed it (AUDIT.md 13.b, 2026-10-15); rollback target for 1.1.0 is `v1.0.0` (`c360021`); the shipped DLL is byte for byte what the sources give since the package pins. `ATTRIBUTION.md` and `LICENSE` differ from `Mod/` only by line endings in the working copy (same blobs in git).

- **Settings:** sliders clamp (reductions 0..100 %, outdoor 100..400 %), conditional controls follow `manureOutdoors`, reset restores
  all eleven fields, values are global through ModSettings/Scribe, `WriteSettings` clears the trait cache (normal expiry 250 ticks).
  Persistence, older files and out-of-range values were played under Pickle (TF-15, TF-22).
- **Translation:** every French and English key resolves, placeholders match (checked by the XML tests). `Check-DefInjected.ps1` is not
  applicable: no owned Def label or nested translatable field. `FRENCH_REVIEW.md` is generated by `scripts/Make-FrenchReview.ps1`
  and was reviewed by the owner on 2026-10-08 (two rounds, validated). She confirmed in chat on 2026-10-10 her review of the two texts changed since, `Housebroken.Settings.IntermediateTip` (`1fc57f4`) and `Housebroken.Settings.Scope` (`87242a2`), revision `87242a2`: no correction requested. The review line of `FRENCH_REVIEW.md` is hers to write; no session marks it reviewed on its own.
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
- **Echo (2026-10-10, owner's decision: keep this one):** `Art/echo-source.png`, a solid blue husky line-art made by hand and declared in `Art/Preview.config.json` (`echo`, `preSized`, `veil: false`, accent colour, opacity 1). It sits at the right of the title panel and shows the subject of the gallery (the husky and its droppings). It overlaps the end of the title and the word "and" of the summary line; legibility checked on the 896 x 504 render and on the 268 px render, accepted by the owner. Validated commit in `echo_review_sha`. The GitHub social preview was updated by the owner on 2026-10-10 (`social_preview_sha256`); the Steam header image still holds the previous Preview (see `remaining`).
- Gallery pictures `Art/Gallery/1-…` and later come from Pickle runs, not from the renderer (`PUBLICATION.md`, `TESTING.md`).

## Field vocabulary

`workflow_stage`: the chain in AUDIT.md (this mod: `dormant`; the old `stage` field and its codes are retired). `licence`: `open` an explicit licence, `silent` no licence and a
dead source, `alive` no licence but a living source, `forbidden` a written refusal, `original` owing nothing to anyone. `remaining`:
`feature` for something missing from a first release, `defect` for a known fault left unfixed, `unverified` for what could not be checked.
