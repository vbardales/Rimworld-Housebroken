# Protocols read

Which protocols this mod has read is recorded by `protocols_read_sha` in `STATUS.md` (written by `scripts/Mark-ProtocolsRead.ps1`;
`scripts/Check-Status.ps1` lists the protocol files changed since). This file keeps only the documents judged useless for this mod,
with the trigger that would make them useful. Trimmed on 2026-10-10; the earlier read tables are in git history.

| Document | Why it does not help | Read it when |
| --- | --- | --- |
| `STYLE_RIMWORLD.md` | Preview, ModIcon and echo style. The images are the owner's sources; a session only renders derivatives | The Preview, the ModIcon source or the echo changes |
| `scripts/SEARCHING.md` | Corpus search. Housebroken asks nobody else's defName | A defName, class or texture path has to be searched across other mods |
| `GALLERY-PROPS.md`, `ANIMALS.md` | Props for animal galleries, and the four animal-mod integrations. Housebroken adds no animal | The gallery is redone, or the mod ever adds an animal |
| `PickleTools/README.md`, `PickleTools/docs/steps.md` | Tool and step catalogues | A Pickle step is written or a tool is looked up |
| `SETTINGS_STEAM_DECK.md`, `EXTERNAL_TOOLS.md` | The owner's Steam Deck settings, and reviewed third-party tools | Never for this mod unless a task names them |
