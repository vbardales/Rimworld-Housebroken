// Requires Node.js, playwright, sharp and an installed Chrome. No network requests.
const fs = require('fs');
const path = require('path');
const { chromium } = require('playwright');
const sharp = require('sharp');
const root = path.resolve(__dirname, '..');
const out = path.join(root, '.build', 'preview-qa');
fs.mkdirSync(out, { recursive: true });
const palette = JSON.parse(fs.readFileSync(path.join(__dirname, 'preview-palette.json')));
const about = fs.readFileSync(path.join(root, 'Mod/About/About.xml'), 'utf8');
const versions = about.match(/<supportedVersions>([\s\S]*?)<\/supportedVersions>/)[1];
const version = [...versions.matchAll(/<li>([\d.]+)<\/li>/g)].map(x => x[1])
  .sort((a,b) => a.localeCompare(b, undefined, {numeric:true})).at(-1);
const rgba = (hex,a) => `rgba(${hex.slice(1).match(/../g).map(x=>parseInt(x,16)).join(',')},${a})`;
const values = {...palette, version, veil95:rgba(palette.veil,.95), veil94:rgba(palette.veil,.94), veil0:rgba(palette.veil,0),
  source:'data:image/png;base64,'+fs.readFileSync(path.join(__dirname,'Preview.png')).toString('base64')};
const html = fs.readFileSync(path.join(__dirname, 'preview.html'),'utf8').replace(/\{\{(\w+)\}\}/g,(_,key)=>values[key]);
const luminance = rgb => rgb.map(v=>v/255).map(v=>v<=.04045?v/12.92:((v+.055)/1.055)**2.4)
  .reduce((sum,v,i)=>sum+v*[.2126,.7152,.0722][i],0);
const color = hex => hex.slice(1).match(/../g).map(x=>parseInt(x,16));
const contrast = (a,b) => (Math.max(a,b)+.05)/(Math.min(a,b)+.05);
(async()=>{
  const browser = await chromium.launch({executablePath:process.env.CHROME_PATH || 'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
  try {
    const page = await browser.newPage({viewport:{width:896,height:504},deviceScaleFactor:1});
    await page.setContent(html);
    await page.evaluate(()=>document.fonts.ready);
    const fontLoaded = await page.evaluate(()=>document.fonts.check('46px "Segoe UI"'));
    if (!fontLoaded) throw new Error('Segoe UI is unavailable');
    const regions = await page.locator('h1,p').evaluateAll(nodes=>nodes.map(n=>{
      const r=n.getBoundingClientRect(); return {x:Math.floor(r.x),y:Math.floor(r.y),width:Math.ceil(r.width),height:Math.ceil(r.height)};
    }));
    const finalPath=path.join(root,'Mod/About/Preview.png');
    await page.screenshot({path:finalPath});
    await sharp(finalPath).resize(268,151).png().toFile(path.join(out,'thumbnail.png'));
    await page.addStyleTag({content:'.copy { visibility:hidden; }'});
    const background=await page.screenshot({path:path.join(out,'background.png')});
    const {data,info}=await sharp(background).removeAlpha().raw().toBuffer({resolveWithObject:true});
    const ink=luminance(color(palette.inkPrimary));
    const minimumContrast=regions.map(r=>{
      let min=Infinity;
      for(let y=r.y;y<r.y+r.height;y++) for(let x=r.x;x<r.x+r.width;x++) {
        const i=(y*info.width+x)*info.channels;
        min=Math.min(min,contrast(ink,luminance([...data.slice(i,i+3)])));
      }
      return min;
    });
    const badgeContrast=contrast(luminance(color(palette.badgeInk)),luminance(color(palette.accent)));
    const report={version,font:'Segoe UI',fontLoaded,width:896,height:504,bytes:fs.statSync(finalPath).size,regions,minimumContrast,badgeContrast};
    fs.writeFileSync(path.join(out,'results.json'),JSON.stringify(report,null,2)+'\n');
    console.log(JSON.stringify(report));
    if(report.bytes>=1000000 || Math.min(...minimumContrast,badgeContrast)<4.5) throw new Error('Preview size or contrast failed');
  } finally { await browser.close(); }
})().catch(e=>{console.error(e);process.exitCode=1;});
