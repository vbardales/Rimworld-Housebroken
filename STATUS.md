---
localization: complete
translation_en: complete
translation_fr: complete
settings_audit: complete
mod:          Housebroken
packageId:    nelim.housebroken
repo:         Rimworld-Housebroken
visibility:   public
detached:     yes
stage:        done
licence:      original
licence_at:   original work, MIT (LICENSE and Mod/LICENSE)
dependencies: declared
showcase:     complete
tested_on:
workshop:      3806137798
remaining:
  - unverified: run TF-01 through TF-22 in game, including animal behavior, native settings
    persistence across restart, new colony and existing-save acceptance; Pickle UI-path passes
    do not cover these manual scenarios.
  - unverified: RIMMSQOL's Housebroken shortcut reveal/hide path passed once in WSL, but
    other customization tools and exact integration-version coverage remain unverified.
  - unverified: subscriber test, public-visibility confirmation and posted Workshop thank-you
    messages for item 3806137798 have not been evidenced in this audit.
  - defect: `modVersion` now says 0.1.0, matching the Workshop item and CHANGELOG.md, but a
    `v1.0.0` tag still exists on origin (commit 21719c6, before the prepublication). Remove or
    keep it before the CI creates any tag; the change to `modVersion` is not on the Workshop
    until the next upload.
  - defect: the local main branch is ahead of origin/main and has not been pushed.
session:      local_4d2743f4-5c98-4ccc-95af-33bbae4bd890
updated:      2026-09-24, Pickle evidence taken out of git and minified; docs/runs added
---

# Housebroken — status

Kept at the root, never inside `Mod/`, so Steam never receives it. Maintained by the session
that holds this mod, not by the sweep that first wrote it.

## Gate to `tested`, as of 2026-09-24

Three conditions, all required. The stage stays `done` until the third holds.

| Condition | State |
| --- | --- |
| No scenario left `@wip` | Met: the four Pickle features carry `@review` and `@requires`, none carries `@wip`. |
| Every conditional scenario has run | Met for the evidence kept: the RIMMSQOL feature was skipped in the two `runtime-evidence` passes and passed alone in `avec-rimmsqol-English`. Re-check against the revision that is tested. |
| No manual test left to validate, all green | **Not met.** TF-01 through TF-22 have never been executed in game. |

## Current result — three distinct Pickle passes, 2026-09-22

After the first queued French/RIMMSQOL tickets disappeared without running, the maintainer
authorized a requeue. The French `runtime-evidence` pass (PID 28556; machine log `LOCK`
23:19:39, `STAGE` 23:21:03, `UNLOCK` 23:24:25) completed with 3 passed, 0 failed and
1 skipped: the optional RIMMSQOL case was not staged in that pass. Its report was copied
from shared archive `0922-2324`, then minified on 2026-09-24 to
`Tests/Pickle/evidence/2026-09-22/runtime-evidence-French/` (summary, JUnit, a log check
and two captures; `docs/runs/`). All three Housebroken
screenshots were opened before that; the French labels and accents are legible, with no visible raw
keys or clipping. The native path and MainButtons shortcut show the same settings page.

The separate English `avec-rimmsqol` pass (PID 13800; `LOCK` 23:27:03, `STAGE` 23:27:37,
`UNLOCK` 23:29:25) completed with 1 passed, 0 failed and 0 skipped. Its report
was copied from archive `0922-2329`, then minified on 2026-09-24 to
`Tests/Pickle/evidence/2026-09-22/avec-rimmsqol-English/`, with only the Housebroken
capture. That capture was opened: the settings page is legible and unclipped after the
RIMMSQOL reveal/activation path. The scenario also asserted the initial hidden state,
main-bar appearance, subsequent hide and forgotten choice. It did **not** test whether
RIMMSQOL persists button visibility across a game restart; that belongs to RIMMSQOL,
not Housebroken.

Together with the earlier English pass below, these are three distinct evidence sets,
so this session retains all three and has no redundant older Housebroken report to cycle.
Only Housebroken screenshots were copied; shared archives and other mods' reports were
left intact. The reports are on disk and ignored by git, minified to text plus a few
captures; `docs/runs/README.md` says which proofs to keep. The Pickle reports establish these UI paths only, not TF-01..22 gameplay,
new/existing save acceptance, or a general compatibility guarantee. `stage: done`
remains unchanged.

`TESTING.md` now names the required minimal English/French and optional RIMMSQOL passes,
links their preserved evidence, and separates the remaining manual acceptance. TF-21 was
corrected so a post-restart RIMMSQOL visibility choice is no longer a Housebroken test.
The 59-case offline runner passed again; the development-only steps project compiled with
zero warnings/errors. Its rebuilt DLL was restored to the tracked hash above so the
delivered companion remains the exact binary used by these Pickle runs.

### Earlier English pass

The WSL `runtime-evidence` English pass launched under the shared lock (PID 33800;
machine log `LOCK` 17:44:53, `STAGE` 17:45:11, `UNLOCK` 17:46:59). Its report has
`exitReason: passed`: three scenarios passed, none failed, and the RIMMSQOL scenario
was skipped because its optional dependencies were not staged. The full report was copied
from archive `0922-1746` before the shared archive rotated, then minified on 2026-09-24 to
`Tests/Pickle/evidence/2026-09-22/runtime-evidence-English/` (see `docs/runs/`). All three
captures were opened before that; each shows the Housebroken settings page with its
controls legible and unclipped. This includes the capture from the MainButtons shortcut;
an earlier description of that image as a blank window was incorrect. These screenshots
show the English page, not animal behavior or French rendering. At that point French,
RIMMSQOL and TF-01..22 remained open; `stage: done` was unchanged.

Earlier on 2026-09-22, French and RIMMSQOL tickets (PIDs 38980 and 13640) entered the
shared queue. Both ticket processes disappeared before obtaining `LOCK`: the machine log
contains no `LOCK`, `STAGE` or `UNLOCK` for either PID, and no Housebroken report was produced.
Read-only checks found neither process alive and no RimWorldLinux process. A single request
to requeue the French pass was rejected by automatic approval review; it did not launch.
Neither ticket provided evidence; the successful replacement runs are documented above.

## Historical workflow audit, 2026-09-22

**done -> preTest.** The prior `done` claim was no longer supported by the current shared
workflow: `Tests/` has no Pickle/Gherkin suite and no written scope justification for its
absence. `AUDIT.md` requires that artifact before `done`; this is an observed documentation/test
gap, not an assertion that a runtime scenario has failed. The next cumulative transition is
therefore `preTest -> done`.

## Current result — Pickle suite written, 2026-09-22

**preTest -> done.** `Tests/Pickle/` now provides a non-distributed companion mod
`Housebroken - Pickle tests`, four Gherkin features and explicit WSL pass maps. The scope is
documented in `Tests/Pickle/README.md`: it exercises only real-game concerns absent from the
offline runner — native settings rendering/write path, the hidden MainButtons shortcut,
RIMMSQOL reveal/hide, and English/French review captures. Deterministic rate, serialization and
XML contracts remain in the 59-case .NET runner; the broad animal/map scenarios remain in
`TESTS_FONCTIONNELS.md` until dedicated observable fixtures justify their Gherkin form.

`dotnet build Tests/Pickle/Source/Housebroken.PickleSteps.csproj -c Release` succeeded with zero
warnings/errors and produced `Tests/Pickle/Mod/Pickle/Assemblies/Housebroken.PickleSteps.dll`
(SHA256 `566A8F07A9BB9F0C71A5A396AAFCF6D7C9DA5D4E4845B76C09D2F6799C539653`). No Pickle or RimWorld
run was launched. Execution, complete reports, review of each `@review` capture, gameplay
scenarios and the RIMMSQOL integration outcome remain **unverified**, not failed.

Audited revision: `61b00c5baa4ea69e7a4a2b65d71a556aa1534533`; the audit began with only
the untracked `Mod/About/PublishedFileId.txt` requested for commit and ended with the working
tree otherwise clean. This audit committed that file as `61b00c5` at the maintainer's request.
It contains `3806137798`, the item reported by the maintainer as the public 0.1.0 Workshop
publication. `git ls-remote` verified that
`origin/main` remains `0cd6a5595caf3d7ee7a7dea178a9d4a1be558ede`, so this publication-ID
commit is not pushed. The local checkout has no `PUBLICATION.md`, no capture order or
thank-you-message drafts, and no local evidence of a subscriber test, public-visibility
change or messages having been posted. Those independent publication facts remain unverified.

### 2026-09-22 audit evidence

- **horsMonoRepo — validated.** This is an autonomous Git checkout with an `origin` GitHub
  remote, a configured `origin/main` upstream, English root documentation, original MIT
  licensing and byte-identical distributed LICENSE/ATTRIBUTION copies. Package ID
  `nelim.housebroken`, name `Housebroken`, folder and repository identity agree.
- **ModIcon générée / Preview générée / preOptions — validated.** Direct inspection found a
  readable 128 x 128 PNG icon (21,277 bytes) and the 896 x 504 Preview PNG (460,606 bytes),
  under the 1 MB limit. The preview has a high overhead RimWorld-like view, distinct blue
  version accent and legible uncropped English overlay. `About.xml` has an English description
  ending in the exact Steam-formatted source link; its original-work licence/title decision is
  coherent with ATTRIBUTION.md.
- **options — validated technically.** Eleven useful persisted settings use the native Mod
  options page; the hidden (`buttonVisible=false`) MainButtons definition opens the same
  `Dialog_ModSettings`. The 59 passing runner cases cover defaults, effect logic, XML-backed
  Scribe round trips, old values, normalization, slider bounds, shared dialog/cache write and
  reset. This certifies the mod-side technical contract only; native UI, disk and RIMMSQOL
  interaction remain unverified in `tested`.
- **l10n — validated technically.** The runner checked XML parsing, Keyed parity,
  placeholders, production-source key coverage and both French MainButton DefInjected paths;
  59 passed, 0 failed. English source fields cover the MainButton English text; no redundant
  English DefInjected file is required. Runtime FR/EN layout remains unverified.
- **preTest — validated.** Harmony is the only hard dependency and its About declaration
  matches source use. The conditional FilthRate patch and DLC load order entries are coherent.
  `TESTS_FONCTIONNELS.md` supplies TF-01..22 with preconditions/actions/expected results.
  `dotnet build Source/Housebroken.csproj -c Release --no-restore -t:Rebuild
  -p:OutputPath=../.build/audit-2026-09-22/` succeeded with zero warnings/errors; its DLL and
  `Mod/Assemblies/Housebroken.dll` share SHA256
  `8DF40BAEF199F4A896390C438AEB42DAB1623227A029521F92F3C779462E871A`.
- **done and later — not established.** No Pickle/Gherkin test artifact exists. No gameplay,
  log, UI, save, translated-layout or integration run was launched or claimed. Since `done` is
  not established, `tested`, `prepublished` and `published` cannot be cumulative statuses.
  Separately, the published-item ID is now committed locally, but a local `v1.0.0` tag and
  `About.xml` `modVersion` `1.0.0` conflict with the reported 0.1.0 publication; the audit
  records the conflict rather than changing release metadata.

### Next transition

Add a focused Pickle/Gherkin suite (or a documented, evidence-based scope justification) that
keeps only behavior a running game can establish, then execute the existing offline checks
against the delivered DLL. Do not treat this missing artifact as a failed in-game test.

## Superseded current result — audit fixes, 2026-09-13

**dansMonoRepo -> done.** All cumulative technical gates are now satisfied under the
user's override placing interactive settings verification at `done -> tested`.
`done` means ready for final in-game acceptance, not already tested in game.

Revision remains `79b58f6cb1bee4ed1aa3b41dfb184c86884cb131` plus the uncommitted
working tree. The pre-existing local changes listed in the audit below were preserved.
The fixes modify About, Preview, the shipped DLL, settings/UI source, English/French
resources, README, changelog, manual scenarios and the test suite; they add the shortcut
source/Def, French injection, technical settings tests, artwork sources/composition and
validation documentation. No commit, push or publication was performed.

### Revalidated transitions

- **horsMonoRepo:** the tracked functional manual is now English, retaining TF-01..20
  and the historical not-executed result. Independent GitHub public-repository and
  pushed-commit checks from this audit remain valid. Identity, original MIT licence
  and identical distributed licence/attribution copies are unchanged.
- **ModIcon générée:** required implementation is complete. Release build succeeds
  with zero warnings/errors; updated DLL is installed in Mod/Assemblies. The previously
  verified 128 x 128 ModIcon is unchanged.
- **Preview générée / preOptions:** built-in image editing produced a corrected high
  view with the dog seen from behind. Art/Preview.png is the new text-free source;
  both older images are retained. Final 896 x 504 PNG is 460,606 bytes and was directly
  inspected at full size and 268 px wide. Camera reservation resolved. The blue rule
  and 1.6 badge are distinct from the warm wood/secondary family. Title, English summary
  and badge are unclipped; no suffix or reduced linking word applies. Segoe UI is used.
  Art/preview-palette.json is the only palette source for Art/preview.html and
  Art/render-preview.cjs. Measured minimum contrast: title 9.59:1, summary 7.40:1,
  badge 8.40:1. See Art/README.md for the generation prompt and reproduction command.
  About now ends with the exact Steam-formatted GitHub source link, checked by a test.
- **options:** all eleven useful settings remain accessible through native Mod options.
  A MainButtonDef with buttonVisible=false inherits native revealable visibility and
  opens Dialog_ModSettings with the same HousebrokenMod.Instance. No extra dependency.
  Six new technical cases exercise field round trips through an XML-backed Scribe
  boundary double, legacy defaults, numeric normalization, production slider logic,
  shared dialog/write/cache behavior and reset confirmation. Original logic tests
  cover setting effects and interactions. Global scope, application timing and stored
  numeric limits are explained in both languages. This is a complete technical gate;
  native disk persistence and interactive access remain pending at tested.
- **l10n:** all existing and new Keyed resources passed nonempty/parity/placeholder and
  source-usage checks. Shortcut label/description have native English Def source and
  French DefInjected entries; Check-DefInjected.ps1 checked 2 keys with 0 errors and
  no unresolved targets reported. New scope and shortcut text reviewed in both languages.
  No redundant English DefInjected file is needed. Runtime layout remains pending.
- **preTest:** Harmony is still the only external mandatory dependency. The shortcut
  uses only native RimWorld APIs. No LoadFolders or additional conditional packages
  were introduced; the existing FilthRate conditional patch remains coherent.
- **done:** 59 tests passed, 0 failed (47 original logic, 6 XML, 6 settings cases).
  TF-01..22 have preconditions, actions and expected results, including a new colony,
  existing saves, translated UI, optional shortcut and older settings. Tests/RESULTS.md
  records commands, observed results, DLL identity and precise boundary-double limits.
- **tested:** not established. All applicable in-game scenarios and log/UI checks must
  run; no RIMMSQOL version or native engine integration is claimed as tested.

Shipped DLL SHA256:
`8DF40BAEF199F4A896390C438AEB42DAB1623227A029521F92F3C779462E871A`.

### Next transition

Execute and record the applicable TF-01..22 variants in RimWorld 1.6, including native
settings persistence and RIMMSQOL reveal/hide behavior, then resolve any observed
failure and run the affected regressions. Missing executions are unverified checks,
not known defects. No remaining technical or artwork defect was observed in this pass.

## Historical audit — 2026-09-13, before the fixes

The findings below describe the pre-fix tree and are preserved as history. Current
validation fields and the section above supersede them for changed components.

Audited revision: `79b58f6cb1bee4ed1aa3b41dfb184c86884cb131`, plus the working
tree present at audit start: modified `Mod/About/About.xml`, `STATUS.md`,
`Tests/Program.cs`, `Tests/README.md`, and untracked `Tests/XmlTests.cs`.
Those changes were preserved. This audit edits only this status document;
build outputs are under ignored `.build/`. No development, image generation,
publication, commit or in-game test was performed.

The standalone repository is `C:/Users/nelim/Documents/rimworld/Housebroken`;
the distributed root is its `Mod/` directory. `detached: yes` remains factual.
The stage now uses the prompt's literal workflow names:
`dansMonoRepo -> horsMonoRepo -> ModIcon générée -> Preview générée -> preOptions
-> options -> l10n -> preTest -> done -> tested`.
`dansMonoRepo` is the cumulative gate baseline here, not a claim that the folder
was moved back into a monorepo. Previous stage: `done`. The first transition is
blocked by the French tracked test document, so no later cumulative stage can
be retained. No monorepo remote is required or requested.

### Ordered transition findings

1. **To horsMonoRepo — defect.** Standalone Git root confirmed with
   `git rev-parse --show-toplevel`. `gh repo view vbardales/Rimworld-Housebroken
   --json name,visibility,url,defaultBranchRef` confirmed PUBLIC, main and the
   configured origin URL. `git ls-remote origin HEAD` returned the audited SHA,
   establishing a pushed commit. README, attribution, changelog and MIT licence
   exist; LICENSE and ATTRIBUTION copies in Mod are byte-identical to the roots.
   Original-work classification agrees with attribution and source inventory:
   FlyingSloth is credited for inspiration, with no upstream files included;
   no new licence is assigned to third-party material. Name Housebroken,
   packageId nelim.housebroken, folder Housebroken and repository
   Rimworld-Housebroken are coherent. However, `git ls-files
   TESTS_FONCTIONNELS.md` confirms that the French manual is repository content,
   contrary to the English-documentation gate. Translating its content while
   preserving scenarios and execution history is the strictly necessary next step.
2. **To ModIcon générée — independent build/icon checks validated; development
   completeness not established.** Release rebuild succeeded, zero warnings and
   errors, and matches the shipped DLL byte for byte (details below). ModIcon
   is PNG, 128 x 128, 21,277 bytes. Direct inspection shows the single mascot
   and accompanying object with a clear silhouette. The missing settings shortcut
   remains required implementation work; these artifact checks do not certify
   that all development is finished.
3. **To Preview générée — file checks validated, visual reservation.** Preview
   is PNG, 896 x 504, 480,677 bytes, below 1 MB. Directly inspected the delivered
   image: title and English summary fit, with no clipping. A concrete camera
   reservation remains: the frontal dog and tall back wall, with floor lines
   converging into depth, look lower and more perspective-driven than the required
   high near-orthographic view. This is an image observation, not a missing
   historical generation report or missing screenshot-comparison requirement.
4. **To preOptions — defect.** English description and unsuffixed original title
   are appropriate. The description ends with the Harmony credit, not
   `[url=https://github.com/vbardales/Rimworld-Housebroken]Source code on GitHub[/url]`.
   The raw URL earlier in the description does not satisfy PUBLISHING.md.
   The Preview also has no version badge. Its amber rule is close to the dominant
   golden wood family; accent separation merits review. No secondary-colour title
   element is needed for the single-word name with no tag or suffix. Art retains
   `Preview-source.png`; no palette JSON or composition HTML exists. Their absence
   is recorded for future reproducibility, not treated as missing generation proof.
5. **To options — defect / partial.** See Settings audit below. No in-game
   verification is required to pass this gate under the user's override.
6. **To l10n — existing-resource checks independently validated.** See Translation
   audit below. The cumulative transition remains gated by settings. New shortcut
   text must be audited when it exists; current resource checks remain valid.
7. **To preTest — dependency declaration independently validated.** Source uses
   Verse/RimWorld, UnityEngine and Harmony. Harmony is the only external required
   mod and is declared with loadAfter; RimWorld 1.6 is supported. DLC loadAfter
   entries do not make DLC mandatory. Trainability uses the native utility, so
   the catalyst is not a separate required mod. No LoadFolders or version-specific
   content exists; the root FilthRate patch handles parts present/absent without
   conditional package dependencies. No optional customization integration was tested.
8. **To done — existing tests validated within scope.** The runner's 52 cases
   passed (47 logic and 5 XML cases). Twenty manual scenarios have preconditions,
   actions and expected results, including settings, FR/EN and existing saves.
   Shortcut scenarios are absent and must accompany its implementation. No actual
   serialization or settings-window callback test is supplied. Green XML tests
   use fixture append semantics, not RimWorld's patch engine. Their repository-link
   assertion only checks URL containment and misses the required final link format.
9. **To tested — non verified.** Manual scenarios explicitly remain unexecuted.
   No game logs, FR/EN runtime rendering, settings persistence, new-game/existing-save
   validation or RIMMSQOL integration success is claimed. These are pending checks,
   not observed runtime defects. The available checks used .NET reference assemblies
   and doubles, not an active RimWorld validation session.

### Commands and artifact evidence

- `dotnet run --project Tests/Housebroken.Tests.csproj -c Release`: exit 0,
  **52 passed, 0 failed**, including the pre-existing untracked XML tests.
- `dotnet build Source/Housebroken.csproj -c Release --no-restore -t:Rebuild
  -p:OutputPath=../.build/audit-release/`: exit 0, zero warnings/errors after retry
  with local SDK access. Initial sandbox denial of Microsoft SDKs was an environment
  restriction, not a source failure. Reference packages: RimWorld 1.6.4871,
  Harmony 2.4.2, Publicizer 2.3.2; SDK 8.0.424.
- `Get-FileHash` on shipped and rebuilt DLL: identical SHA256
  `EC2FEBC669BAC999B76760418589AE6A0BD27CEC94901DB599BD6F3FC46C0948`.
  The shipped DLL was not overwritten. Mod contains no build intermediates,
  game assemblies or bundled Harmony runtime.
- Image dimensions/format read with System.Drawing; both delivered PNGs directly
  viewed. No generation-history evidence was required.

### Settings audit

Useful settings: six numeric factors (obedient .5, well-trained .25, intermediate
.8, advanced .6, indoor 0, outdoor 2) and five booleans (colony-only, outdoor manure,
wipe-feet and alert exemption true; whole-home false). They affect actual production
logic, exercised by the linked-source tests. The primary page uses the native
Mod settings overrides and needs no XML editing or customization dependency.
Reduction sliders clamp to 0..100%; outdoor multiplier to 100..400%. Conditional
indoor/outdoor controls follow manureOutdoors. Reset restores all eleven fields;
the runner verifies this. Settings are global via ModSettings/Scribe; WriteSettings
clears the trait cache, whose normal expiry is 250 ticks. Runtime callback timing
and disk persistence are not established by those observations.

**Defect:** neither definitions nor source implement a MainButton or MainTabWindow
shortcut. Hidden-by-default and revealability cannot be satisfied by total absence.
**Non verified:** Tests exclude HousebrokenMod and use an inert Scribe_Values double,
so serialization round trips, missing/older stored values and UI application callbacks
are not tested. The slider code bounds ordinary input, but no independent UI-boundary
execution is covered. Record applicable technical checks when closing this gate;
interactive game and RIMMSQOL checks belong to `tested`, not `options`.

### Translation audit

Reviewed all production C# and all distributed XML, both language dictionaries,
dynamic key selection in StatPart_Housebroken and key arguments in the slider helpers.
Existing settings labels, tooltips, reset confirmation and stat explanations resolve
through Keyed/Translate. English/French entries are nonempty, matching and have matching
numeric placeholders; the executed XML tests check duplicates through dictionary
construction, source key coverage and placeholders. French text was also read directly.
The unchanged proper mod name in SettingsCategory is an identity, not an untranslated
UI sentence. No owned Def label, nested translatable field, grammar resource or
DefInjected path exists: Check-DefInjected.ps1 is **not applicable, justified**.
The patch only attaches a StatPart to the native FilthRate Def. No dependency-owned
translation key is called by this mod. Current localization fields certify resource
readiness only; final cumulative l10n awaits settings and any newly introduced text.
FR/EN rendering and layout are unverified until game validation.

### Optional follow-up, separate from gate blockers

Strengthen the existing metadata assertion to enforce the exact final Steam link,
and retain palette/composition files on the next artwork revision. Preserve all
historical results below; a documentation-only correction does not invalidate the
unchanged DLL or the logic tests.

## Historical notes — retained from before the 2026-09-13 audit

Manual functional test scenarios were written on 2026-09-12 in
`TESTS_FONCTIONNELS.md`. They have not been executed; runtime verification remains open.

Automated tests added on 2026-09-12: 52 passing cases against linked production
sources with game boundary doubles (`Tests/README.md`). Release compilation against
the RimWorld reference assemblies passes with no warnings or errors. Cache reuse
now rejects clock rewinds and a different pawn sharing an old pawn ID.

Publication audit: the original title `Housebroken` needs no continuation suffix.
The About description includes the GitHub repository link. XML contract tests cover
both FilthRate patch branches, preservation of existing parts, metadata, and English /
French translation keys and placeholders. They do not execute RimWorld's patch engine.
Source and patch comments are already in English; the old defect entry was stale.

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
