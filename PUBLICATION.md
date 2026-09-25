# Publication

What the Workshop page needs and the rest of the repository does not hold. Written on 2026-09-25 for the `1.0.0`
and for whoever updates this mod next. Rules: `AUDIT.md`, `PUBLISHING.md` and `Rimworld-Release-Admin/docs/OPERATIONS.md`
of the collection, summarised in `docs/PROTOCOLS-READ.md`.

Workshop item: **3806137798**, created by the `0.1.0` prepublication (commit `61b00c5`, `Mod/About/PublishedFileId.txt`).
Steam creates every item private, and nothing here changes that: the owner switches it to public herself.

## Where this stands

| Item | State |
| --- | --- |
| Stage | `done` (`STATUS.md`). `tested` needs TF-15 to TF-22 played, see `TESTING.md` |
| Version | the item was created as `0.1.0`; the uploaded `About.xml` still says `modVersion` 1.0.0, the repository says 0.1.0 |
| Workflow | none yet under `.github/`. It is generated for a mod, never copied by hand |
| Gallery | no image exists (see below) |
| Thanks comments | drafted below; nothing posted, and nothing can be until the item is public |

## Publishing by CI

Steam Workshop publications go through GitHub Actions, not the in-game button. The full procedure (dry-run rules, credentials,
approval) is in `docs/OPERATIONS.md` of `vbardales/Rimworld-Release-Admin`; read it first. For an item that already exists, the
manual workflow generated for the mod is the route:

```
Rimworld-Release-Admin/scripts/generate-publish-workflow.sh <this repository> \
  --workshop-id 3806137798 --package-id nelim.housebroken \
  --release-title "Housebroken {version}" \
  --require Assemblies/Housebroken.dll \
  --description-file PUBLICATION.md --description-heading '^## Steam description'
```

**Not run.** It writes files under `.github/` and nothing else; reading its diff, committing and pushing are the caller's, and the
owner decides whether this mod gets a workflow now. What the workflow reads from this repository:

- **The change note**: the fenced block under `### <version>` in "Steam change notes" below.
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
Rollback target, chosen before publishing: the last known good commit, and a tag at each good version.

## Screenshots, in this order

**No gallery image exists yet, and the order is the owner's to decide.** Steam shows the first one large under the Preview, so the
most demonstrative goes there rather than the prettiest. What the suite can produce headlessly, and what it cannot:

| Candidate | Source | State |
| --- | --- | --- |
| The settings page, English | `32-language-review.feature`, screenshot mode | played in English on 2026-09-22 (`03-language`), opened and legible; not played at 100 and 200 percent yet |
| The settings page, French | same, `-Language French` | played on 2026-09-22, opened, accents and slider labels legible |
| The stat explanation of a trained animal, inside and outside | a dedicated capture scenario on the test yard | not written |
| A trained animal beside an untrained one in the same room | a dedicated capture scenario | not written |

The gallery itself is a manual step on the Steam page: no library the CI uses can send more than the header image.

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
| Sentience Catalyst Filth Rate Reducer (FlyingSloth) | 3525790312 | `drafted` on 2026-09-25 | post the draft below |
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
- **The uploaded `About.xml` says `modVersion` 1.0.0.** The repository says 0.1.0. The next upload carries the repository's value.

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

The text of record is the `<description>` of `Mod/About/About.xml`. **It is not copied here yet**: its THANKS and AI-GENERATED lines are
still to be corrected (the test tools, RIMMSQOL and Codex are not named), and the mod tree stays frozen while a test run waits in the
queue. It is copied under this heading, ending with `[url=https://github.com/vbardales/Rimworld-Housebroken]Source code on GitHub[/url]`,
in the same change.

## After the upload, in this order

1. Commit `Mod/About/PublishedFileId.txt` if the upload changed it (it must not).
2. Read the public page: description, change note, images. A green release proves nothing about Steam.
3. Record the evidence in `STATUS.md`: run IDs, SHA, date.
4. The owner, by hand on Steam, when a `1.0.0` goes to production: change the visibility, subscribe to the comments, and "Watch all
   activity" of the mod and of its parent, Harmony. Record the date in `STATUS.md` before marking `published`.
5. Post the comment above once the item is public, then update the register.