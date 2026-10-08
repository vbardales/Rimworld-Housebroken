# Publication

What the Workshop page needs and the rest of the repository does not hold. Written on 2026-09-25 for the `1.0.0`
and for whoever updates this mod next. Rules: `AUDIT.md`, `PUBLISHING.md` and `Rimworld-Release-Admin/docs/OPERATIONS.md`
of the collection, summarised in `docs/PROTOCOLS-READ.md`.

Workshop item: **3806137798**, created by the `0.1.0` prepublication (commit `61b00c5`, `Mod/About/PublishedFileId.txt`).
Steam creates every item private, and nothing here changes that: the owner switches it to public herself.

## Where this stands

| Item | State |
| --- | --- |
| Stage | `tested` (`STATUS.md`, 2026-09-28). TF-01 to TF-22 all passed under Pickle, the `tested` gate's three conditions all met |
| Version | the item was created as `0.1.0`; the owner decided the next upload publishes `1.0.0` (repository and `About.xml` both say 1.0.0 now) |
| Mode | **CI** (public repository): dry-run of the exact commit, `publish` with the full 40-character SHA, `steam-production` approved by the owner only |
| Workflow | `publish-tag.yml` generated under `.github/` (2026-09-27) |
| Gallery | image 0 = `Art/Gallery/0-preview.png`, byte for byte the `Preview.png` (regenerated 2026-10-05 by `scripts/Render-Preview.cjs`); `40-gallery.feature` written for images 1 and 2, not yet played (see below) |
| Thanks comments | drafted below; nothing posted, and nothing can be until the item is public. The FlyingSloth page was removed by Steam (checked 2026-10-07), so that comment may be impossible |

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

**Not run.** It writes files under `.github/` and nothing else; reading its diff, committing and pushing are the caller's, and the
owner decides whether this mod gets a workflow now. What the workflow reads from this repository:

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

**Image 0 is `Art/Gallery/0-preview.png`** (owner's instruction, 2026-09-29): a plain copy of `Mod/About/Preview.png` as it
stood before the corner badge below, so the header image and the first gallery slide are not the same file once that badge
is added. Steam shows this first image large under the Preview, so the order after it stays the owner's to decide. What
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
dropping outside; `ModIcon.png` is an orange mascot with a kennel and a bowl. No character, no scene.

## Messages for the mods this one draws from

Steam comments take BBCode, and a bare Workshop URL becomes a widget, hence the link alone on the last line. Under 1000 characters each.
**Post them once the item is public.** A link to a private item opens for nobody and the widget does not render.

The register of the collection (`WORKSHOP_COMMENTS.md`) decides whether a comment is still needed: one main comment per recipient page
for the whole collection.

| Recipient | Workshop ID | Register | What to do |
| --- | --- | --- | --- |
| Sentience Catalyst Filth Rate Reducer (FlyingSloth) | 3525790312 | `drafted` on 2026-09-25 | **page removed by Steam** (notice "violates Steam Community & Content Guidelines", read 2026-10-07): comments are probably impossible. Owner to confirm; if so, record that impossibility in the register instead of posting. The thanks stay in the description (its link is kept: it names the source of the idea) |
| Harmony | 2009463077 | `posted` | Housebroken added to its `Covers`; nothing to post |
| Pickle | 3791648678 | `posted` | added to `Covers`; nothing to post |
| RimLogging | 3733484696 | `posted` | added to `Covers`; nothing to post |
| RIMMSQOL | 1084452457 | `posted` | added to `Covers`; nothing to post |
| PickleTools | 3806142401 | `not_applicable` | the same author's project, no self-comment |

### Sentience Catalyst Filth Rate Reducer (FlyingSloth) — drafted

The source of the idea, and only of the idea: no code and no file of that mod was read.

```
Hello! 🐾 I just released Housebroken, and the idea came straight from your Sentience Catalyst Filth Rate Reducer, so thank you for it!

Your mod made me look at where a colony's mess really comes from: one stat, FilthRate, read every time an animal steps onto a new cell. Housebroken keeps that principle but changes the criterion. An animal makes less mess as it learns obedience and more training, and as its species is easier to train (the sentience catalyst still counts, through the trainability it adds). It also holds it until it is outside the base, and keeps its feet clean. 💛

No code or file of yours was used, only the idea. Thank you for pointing me at the right stat! 🙏

https://steamcommunity.com/sharedfiles/filedetails/?id=3806137798
```

## What the upload cannot take back

- **`About/PublishedFileId.txt`** holds `3806137798` and is committed and pushed. Lost, the next upload creates a second item.
- **The description** is sent to Steam only when the item is created, or when a workflow sends it with `update_description`. Until then a
  correction is made by hand on the Steam page, never from `About.xml`.
- **The item is private.** RimWorld never sets its visibility, and neither does the CI.
- **The uploaded item's `About.xml` says `modVersion` 1.0.0** (from before the prepublication's own version was fixed at 0.1.0).
  The repository now says 1.0.0 again too, so the next upload should read the same, unlike the mismatch this line used to record.

## Steam change notes

Sent as written (BBCode), under 8000 bytes. The `1.0.0` note is drafted and must be read once more against the final `CHANGELOG.md`.

### 1.0.0

```
[b]Housebroken 1.0.0[/b]

A trained or intelligent animal makes less mess, and does its business outside instead of in your base.

[list]
[*]Filth rate reduced by the animal's training (obedience, then further training) and by its species' trainability. The sentience catalyst counts.
[*]Manure outside: a clean enough animal holds it inside the base and relieves itself once out.
[*]Mud and blood on its feet stay outside the base too.
[*]Clean animals leave the "animal filth" alert.
[*]Every value is adjustable in Mod options; a hidden main-bar shortcut opens the same page for customization mods.
[*]No data is added to the save: safe to add to or remove from a game in progress.
[/list]
```

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
A trained or intelligent animal makes less mess, and does its business outside instead of in your base.

- Filth rate reduced according to the individual animal's training (obedience, then the later training steps) and to its species' trainability (intermediate, advanced). The sentience catalyst counts, since it raises trainability by one step.
- Manure outside: a clean enough animal holds it while inside the base, and relieves itself once out.
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
4. The owner, by hand on Steam, when a `1.0.0` goes to production: change the visibility, subscribe to the comments, and "Watch all
   activity" of the mod and of its parent, Harmony. Record the date in `STATUS.md` before marking `published`.
5. Post the comment above once the item is public, then update the register.