# Art

Sources: `Preview-source.png` (text-free illustration), `ModIcon-source.png` (the owner's full-resolution icon),
`ModIcon-badge.png` (the same icon trimmed of transparent padding, for the Preview corner badge) and `Preview.config.json`.
`Preview-original.png` and `ModIcon-original.png` keep the earlier versions.

Outputs, all written by the shared renderer from the mod root:

```powershell
node ../scripts/Render-Preview.cjs
```

`Mod/About/ModIcon.png` (128 x 128 from `ModIcon-source.png`), `Mod/About/Preview.png` (with the ModIcon badge bottom-left),
`Art/Gallery/0-preview.png` (byte-identical copy), `Art/Preview.ico`, `Art/ModIcon.ico`. QA files go to `Art/.render/`, ignored by git.
`ModIcon-badge.png` is made once, again only when the ModIcon changes:
`../scripts/Make-PreviewBadge.ps1 -AboutDir Art -IconFile ModIcon-source.png -PreviewFile Preview-source.png -TrimAlphaOnly -SaveTrimmedIconTo Art/ModIcon-badge.png`.
