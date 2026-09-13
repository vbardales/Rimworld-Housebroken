# Preview artwork

The September 13, 2026 revision uses the built-in image generation tool in edit mode.
`Preview.png` is the selected text-free illustration, visually checked and copied into
this repository. `Preview-source.png` preserves the earlier illustration, and
`Preview-delivered-2026-09-04.png` preserves the earlier distributed composition.
The unchanged ModIcon remains in `Mod/About/ModIcon.png`.

Final generation prompt (input: the earlier `Preview-source.png`):

> Edit this RimWorld mod illustration to fix its camera and composition. Keep the concept: one trained husky in a clean rustic wooden animal shelter, open doorway to a muddy yard with a small dung pile outside. Landscape 16:9. Camera high oblique overhead 65 degrees above horizon, near-orthographic like RimWorld gameplay: floor fills almost the entire image; walls only low narrow bands, no strong converging perspective. Husky small on right half seen from above and behind walking toward the doorway; no frontal animal portrait. Large calm left third for later typography. Matte gouache-like game art, low detail, boxy functional worn shelter, regular plank grid, soft contact shadows. Dominant warm wood family and cool slate blue outdoor ground/doorway detail for a distinct blue accent. Warm light on the clean interior, cool exterior. No text, no badge, no logo, no watermark, no border. Do not retain the original low camera.

`preview-palette.json` is the sole palette source. The warm brown veil and warm
secondary ink follow the dominant wood; the bright blue accent comes from the cool
outdoor ground and water detail. There is no secondary title span or status tag in
this original single-word title, so secondary ink is reserved but not painted.

`preview.html` defines the composition. `render-preview.cjs` injects the palette,
embeds the image and reads the highest supported version from About.xml. It renders
through installed Chrome with Segoe UI, then produces the final
`../Mod/About/Preview.png` and ignored QA files under `../.build/preview-qa/`.

Run with Node.js, Playwright and Sharp available (set NODE_PATH if using a bundled
runtime), and Chrome installed (or set CHROME_PATH):

```powershell
node Art/render-preview.cjs
```

Final checks on September 13: 896 × 504 PNG, 460,606 bytes; direct inspection at full
size and 268 px wide passed. High camera, visible dog walking out, clean interior,
no clipped text, readable title and 1.6 badge. Minimum background contrast over the
entire title/summary rectangles: 9.59:1 / 7.40:1; badge 8.40:1. Segoe UI was available.
The muted amber secondary and vivid blue accent belong to visibly different families.
