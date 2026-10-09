# Publication

What the Workshop page needs and the rest of the repository does not hold. Written on 2026-09-25 for the `1.0.0`
and for whoever updates this mod next. Rules: `AUDIT.md`, `PUBLISHING.md` and `Rimworld-Release-Admin/docs/OPERATIONS.md`
of the collection, summarised in `docs/PROTOCOLS-READ.md`.

Workshop item: **3806137798**, created by the `0.1.0` prepublication (commit `61b00c5`, `Mod/About/PublishedFileId.txt`).
Steam creates every item private, and nothing here changes that: the owner switches it to public herself.

## Where this stands

| Item | State |
| --- | --- |
| Stage | `published` (`STATUS.md`, 2026-10-08), version 1.0.0, public since 2026-10-08 |
| Version | 1.0.0 published (tag `v1.0.0`, release `Housebroken 1.0.0`, SHA `c360021adbb3ad7f71e27bbfc753f18b8b04da3c`); repository and `About.xml` say 1.0.0 |
| Mode | **CI** (public repository): dry-run of the exact commit, `publish` with the full 40-character SHA, `steam-production` approved by the owner only |
| Workflow | `publish-tag.yml` under `.github/`, template stamp `82de20b8aa50` |
| Gallery | image 0 = `Art/Gallery/0-preview.png`, byte for byte the `Preview.png` (regenerated 2026-10-05 by `scripts/Render-Preview.cjs`); images 1 and 2 (`Art/Gallery/1-indoors.png`, `2-outdoors.png`) played green by `40-gallery.feature` and accepted by the owner on 2026-10-08 (see below) |
| Thanks comments | all done (see below) |

## Publishing by CI

Steam Workshop publications go through GitHub Actions, not the in-game button. The full procedure (dry-run rules, credentials,
approval) is in `docs/OPERATIONS.md` of `vbardales/Rimworld-Release-Admin`; read it first. For an item that already exists, the
manual workflow generated for the mod is the route:

```
Rimworld-Release-Admin/scripts/generate-publish-workflow.sh <this repository> \
  --workshop-id 3806137798 --package-id nelim.housebroken \
  --release-title "Housebroken {version}" \
  --require Assemblies/Housebroken.dll \
  --description-markdown PUBLICATION.md --description-heading '^## Steam description$' --about-from-description
```

**Run for 1.0.0.** Published on 2026-10-08 at SHA `c360021adbb3ad7f71e27bbfc753f18b8b04da3c`: dry-run 37798996377, publish run 37800930249
(`update_preview` and `update_description`, `steam-production` approved by the owner). The CI created tag `v1.0.0` and the release. Procedure for the next
version: same route, a green dry-run of the exact commit first. What the workflow reads from this repository:

- **The change note**: the fenced block under `### <version>` in "Steam change notes" below.
- **The description** (only when `update_description` is on): the ```markdown``` block under "## Steam description" of `PUBLICATION.md`, converted to Steam BBCode for the upload and to plain text for `Mod/About/About.xml`.
- **The GitHub release notes**: the `## [<version>]` section of `CHANGELOG.md`. Date it before publishing.
- **Identity checks**: `Mod/About/PublishedFileId.txt` must hold `3806137798` and `About.xml` the package ID `nelim.housebroken`.
- **What ships**: the `Mod/` of the resolved commit, as committed, prebuilt DLL included. The project references game assemblies
  that live on a Windows machine, so a runner cannot rebuild it: `Mod/Assemblies/Housebroken.dll` is the file Steam receives.

The steps, each on the exact commit (its full 40-character SHA): a dry-run first, its log read and its run ID and SHA recorded in
`STATUS.md`; then `scripts/dispatch-publish.sh` of `Rimworld-Release-Admin`, which refuses without a green dry-run of that SHA and
prints the link of the run to approve. **Only the owner approves the `steam-production` environment.** The workflow creates the
tag and the GitHub release after a successful upload: they are not created by hand.

**Policy: fail fast** (`AUDIT.md`, `prepublished -> published`). Before the `publish`: no red scenario without a green replay on a
build that holds its fix, the Workshop gallery, and the owner's manual checks. The regression pass runs after the publication.
Rollback, decided by the owner: switching the Workshop item from public back to private, not a code revert. The last known good
commit and a tag at each good version are still kept for reference.

## Screenshots, in this order

**Image 0 is `Art/Gallery/0-preview.png`** (owner's instruction, 2026-09-29): a byte-for-byte copy of `Mod/About/Preview.png`, ModIcon corner badge included, written by the renderer in the same pass, so the header image and the first gallery slide are the same file. Steam shows this first image large under the Preview, so the order after it stays the owner's to decide. What
the suite can produce headlessly, and what it cannot:

| Candidate | Source | State |
| --- | --- | --- |
| 0: the Preview, with the ModIcon corner badge | `Art/Gallery/0-preview.png`, written by the renderer, byte for byte the Preview | regenerated 2026-10-05 |
| The settings page, English | `32-language-review.feature`, screenshot mode | played in English on 2026-09-22 (`03-language`), opened and legible; not played at 100 and 200 percent yet |
| The settings page, French | same, `-Language French` | played on 2026-09-22, opened, accents and slider labels legible |
| Indoors: a trained husky beside an untrained cow, the cow's mess on the floor | `Art/Gallery/1-indoors.png`, from `40-gallery.feature` scenario 1 (hearth hall) | played green and accepted by the owner, 2026-10-08 |
| Outdoors: the same husky lets it go | `Art/Gallery/2-outdoors.png`, from `40-gallery.feature` scenario 2 (`calm-zone`, a built floor in the open) | played green and accepted by the owner, 2026-10-08 |

The gallery itself is a manual step on the Steam page: no library the CI uses can send more than the header image.

**`Mod/About/Preview.png` carries the ModIcon in its bottom-left corner** (owner's rule, 2026-09-29), tilted +15°, drawn by the shared renderer from `Art/Preview.config.json` (`iconBadge`, asset `Art/ModIcon-source.png`, kept trimmed of transparent padding), with `Mod/About/ModIcon.png` itself produced from `Art/ModIcon-source.png` (`modIconSource`). Sources and regeneration are described in STATUS.md, "Art sources and regeneration". Regenerate with `node ../scripts/Render-Preview.cjs` from the repository root; it rewrites `Art/Gallery/0-preview.png` in the same pass.

## Dependencies and DLCs

**No DLC is required.** `supportedVersions` declares 1.6 only, there is no `LoadFolders.xml` and no `IfModActive` branch.

| Declared | packageId | Actually required |
| --- | --- | --- |
| Harmony | `brrainz.harmony` | Yes: the mod patches `Alert_AnimalFilth.CalculateTargets` and `Pawn_FilthTracker.TryDropFilth` |

`loadAfter` carries Harmony and the five DLCs, for load order only. The optional integration, RIMMSQOL, is not declared anywhere: the
hidden `Housebroken_Settings` main button is there for it to reveal, and nothing needs it. The Sentience catalyst is read through the
game's own `TrainableUtility.GetTrainability`, so it needs Odyssey only when the player has that content.

## Mature content checkboxes

**None of them.** The mod adds no content of its own beyond a stat part and two patches. The two images that ship were opened on
2026-09-25: `Preview.png` shows a husky walking across a barn floor toward an open door, a straw bale on either side and a small
dropping outside; `ModIcon.png` is an orange mascot with a kennel and a bowl. The gallery pictures were opened on 2026-10-08: `1-indoors.png` a husky and a cow in a wooden hall, `2-outdoors.png` a husky on a cream floor, both with small droppings. No character, no scene.

## Messages for the mods this one draws from

All posted or covered (register `WORKSHOP_COMMENTS.md`): Harmony, Pickle, RimLogging and RIMMSQOL name Housebroken in their collective
comment; PickleTools is the same author's project (no self-comment); the FlyingSloth thank-you was posted by the owner on 2026-10-08
(its text is in `docs/runs/2026-10-08.md`). For a next version: comments only when the register says one is missing, BBCode, link hidden
behind `[url=…]`, under 1000 characters, posted once the item is public.

## What the upload cannot take back

- **`About/PublishedFileId.txt`** holds `3806137798` and is committed and pushed. Lost, the next upload creates a second item.
- **The description** is sent to Steam only when the item is created, or when a workflow sends it with `update_description`. Until then a
  correction is made by hand on the Steam page, never from `About.xml`.
- **Visibility** is never sent by the CI nor by RimWorld; the item is public since 2026-10-08, set by the owner. Rollback, decided by the
  owner: switch it back to private, not a code revert.

## Steam change notes

Sent as written (BBCode), under 8000 bytes, read by the workflow from the fenced block under `### <version>`. The notes of 1.0.0, already
sent, are in `docs/runs/2026-10-08.md`. For the next version, write a `### <version>` block here, from the `## [<version>]` section of
`CHANGELOG.md`, before the dry-run.

## Steam description

Sent only when `update_description` is on for a publish. The source is the ```markdown``` block below (the one-source standard set by
Virginie on 2026-09-25, `Rimworld-Release-Admin` `f196148`): `--description-markdown PUBLICATION.md --description-heading '^## Steam
description$' --about-from-description`. The dry-run prints the converted BBCode, its size, its SHA-256 and a line diff against the
page, so the text sent is read before the approval. `--about-from-description` also generates the plain-text `<description>` of
`Mod/About/About.xml` from this same block, and a publish stops when they differ; `node .github/scripts/sync-about-description.mjs
--write` reports and rewrites it, its diff read and committed before a new dry-run. The block below already reads the same as the
current `About.xml` `<description>`, in the order AUDIT.md requires: the pitch, IF I GO QUIET, AI-GENERATED, THANKS, then the GitHub
link, which is its last line. When one changes, change the other. Steam's limit is 8000 bytes; this block is about 2.4 KB.

Migrated from `Mod/README.template.md` on 2026-09-27 (no workflow existed yet under `.github/`, so nothing live to compare against):
the template and `Mod/.steamignore` are dropped, since nothing in `Mod/` needs hiding from the upload any more.

```markdown
A trained or intelligent animal makes less mess, and keeps it out of your base. The held filth is dropped only on built flooring outside.

- An animal's filth rate is reduced according to its individual training (obedience, then later training steps) and its species' trainability (intermediate, advanced). The sentience catalyst counts, since it raises trainability by one step.
- Manure outside: a clean enough animal holds it while inside the base, then drops it on built flooring outside.
- Mud stays outside: the same animal keeps the mud and blood it picked up on its feet while inside the base, and drops them once out.
- Clean animals are exempted from the "animal filth" alert.

Everything is adjustable in the mod options. No data is added to the save: the mod can be added to or removed from a game in progress.

Interface in English and French.

Source code and issue tracker:
[https://github.com/vbardales/Rimworld-Housebroken](https://github.com/vbardales/Rimworld-Housebroken)

## If I go quiet

If I do not answer within a reasonable time after being contacted, anyone may freely update this or any other of my mods, including publishing a continuation of it. All credit must be preserved.

## AI-generated

This mod's code and test suite were written with Claude Code (Anthropic) and Codex (OpenAI), and its images were generated with DALL-E (OpenAI), under human direction, review and testing. Stated openly: designing with these tools is my job.

## Thanks

FlyingSloth, for [Sentience Catalyst Filth Rate Reducer](https://steamcommunity.com/sharedfiles/filedetails/?id=3525790312), which gave me the idea. Housebroken keeps the principle but changes the criterion, from the sentience catalyst to training and trainability. None of their code is used here.

Andreas Pardeike for [Harmony](https://steamcommunity.com/sharedfiles/filedetails/?id=2009463077).

[Pickle](https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678), [RimLogging](https://steamcommunity.com/sharedfiles/filedetails/?id=3733484696) and [PickleTools](https://steamcommunity.com/sharedfiles/filedetails/?id=3806142401) were used for development and testing only; none is a dependency of the distributed mod. [RIMMSQOL](https://steamcommunity.com/sharedfiles/filedetails/?id=1084452457) was used to exercise the optional MainButtons customization path during testing.

This mod is MIT licensed. Credits and licence details: [ATTRIBUTION.md](https://github.com/vbardales/Rimworld-Housebroken/blob/main/ATTRIBUTION.md).

[Source code on GitHub](https://github.com/vbardales/Rimworld-Housebroken)
```

This file keeps its name: the change note is read from it, under `### <version>`.

## After the upload, in this order

1. Commit `Mod/About/PublishedFileId.txt` if the upload changed it (it must not).
2. Read the public page: description, change note, images. A green release proves nothing about Steam.
3. Record the evidence in `STATUS.md`: run IDs, SHA, date.
4. The owner, by hand on Steam, only for a new item or a visibility change (done for 1.0.0 on 2026-10-08): change the visibility, subscribe to the
   comments, and "Watch all activity" of the mod and of its parent, Harmony. Record the date in `STATUS.md`.
5. Post the comment above once the item is public, then update the register (done for 1.0.0 on 2026-10-08).