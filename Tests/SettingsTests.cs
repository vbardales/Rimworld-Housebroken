using Housebroken;
using RimWorld;
using Verse;
using System.Xml.Linq;

internal static class SettingsTests
{
    static void Require(bool value, string message) { if (!value) throw new Exception(message); }
    static void Near(float a,float b) => Require(float.IsFinite(b) && Math.Abs(a-b)<0.00001f,$"Expected {a}, got {b}");
    public static void Register(Action<string,Action> test)
    {
        test("Settings: all fields round-trip through XML serialization boundary", () => {
            var original=HousebrokenMod.Settings;
            foreach(var f in typeof(HousebrokenSettings).GetFields())
                f.SetValue(original,f.FieldType==typeof(bool)? (object)!(bool)f.GetValue(original) : f.Name=="outdoorFactor" ? 3.4f : .37f);
            HousebrokenMod.Instance.WriteSettings();
            var xml=new XElement("settings",Scribe_Values.Data.Select(p=>new XElement(p.Key,p.Value)));
            // Parse a serialized document, with a fresh settings object and dictionary.
            Scribe_Values.Data=XElement.Parse(xml.ToString()).Elements().ToDictionary(e=>e.Name.LocalName,e=>e.Value);
            var restored=new HousebrokenSettings();
            Scribe_Values.Mode=LoadSaveMode.LoadingVars; restored.ExposeData();
            foreach(var f in typeof(HousebrokenSettings).GetFields())
                Require(Equals(f.GetValue(original),f.GetValue(restored)),"Round-trip failed: "+f.Name);
            Require(Scribe_Values.Data.Count==11,"Serialization field count changed");
        });
        test("Settings: missing legacy fields restore their defaults", () => {
            Scribe_Values.Data=new(){{"obedientFactor","0.3"}};
            Scribe_Values.Mode=LoadSaveMode.LoadingVars;
            var loaded=new HousebrokenSettings(); loaded.ExposeData();
            var defaults=new HousebrokenSettings();
            foreach(var f in typeof(HousebrokenSettings).GetFields())
                Require(Equals(f.GetValue(loaded),f.Name=="obedientFactor" ? .3f : f.GetValue(defaults)),"Legacy default failed: "+f.Name);
        });
        test("Settings: invalid stored numeric values are sanitized", () => {
            var s=HousebrokenMod.Settings;
            s.obedientFactor=-1; s.wellTrainedFactor=2; s.indoorFactor=float.NaN;
            s.advancedSpeciesFactor=float.PositiveInfinity; s.intermediateSpeciesFactor=float.NegativeInfinity; s.outdoorFactor=99;
            s.Normalize();
            Near(0,s.obedientFactor); Near(1,s.wellTrainedFactor); Near(0,s.indoorFactor);
            Near(.6f,s.advancedSpeciesFactor); Near(.8f,s.intermediateSpeciesFactor); Near(4,s.outdoorFactor);
            s.outdoorFactor=-1; s.Normalize(); Near(1,s.outdoorFactor);
            s.outdoorFactor=float.NaN; s.Normalize(); Near(2,s.outdoorFactor);
        });
        test("Settings: production UI clamps and converts slider inputs", () => {
            try {
                Listing_Standard.SliderInput=(_,_)=>999;
                HousebrokenMod.Instance.DoSettingsWindowContents(new(0,40,860,600));
                var s=HousebrokenMod.Settings;
                Near(0,s.obedientFactor); Near(0,s.wellTrainedFactor); Near(0,s.intermediateSpeciesFactor); Near(0,s.advancedSpeciesFactor); Near(0,s.indoorFactor); Near(4,s.outdoorFactor);
                Listing_Standard.SliderInput=(_,_)=>-100;
                HousebrokenMod.Instance.DoSettingsWindowContents(new(0,40,860,600));
                Near(1,s.obedientFactor); Near(1,s.indoorFactor); Near(1,s.outdoorFactor);
                Listing_Standard.SliderInput=(_,value)=>value;
                s.obedientFactor=.37f; s.outdoorFactor=2.35f;
                HousebrokenMod.Instance.DoSettingsWindowContents(new(0,40,860,600));
                Near(.37f,s.obedientFactor); Near(2.35f,s.outdoorFactor);
            } finally { Listing_Standard.SliderInput=null; }
        });
        test("Settings: shortcut shares native mod dialog and applies cached changes on close", () => {
            var pawn=new Pawn { thingIDNumber=9876, Trainability=new(){intelligenceOrder=30} };
            Near(.6f,Cleanliness.TraitFactor(pawn));
            var worker=new MainButtonWorker_Housebroken { def=new(){buttonVisible=false} };
            Require(!worker.Visible,"Shortcut visible by default");
            worker.def.buttonVisible=true; Require(worker.Visible,"Shortcut cannot be revealed");
            worker.Activate();
            var dialog=(Dialog_ModSettings)Find.WindowStack.Last;
            Require(ReferenceEquals(dialog.Mod,HousebrokenMod.Instance),"Shortcut opened different configuration");
            HousebrokenMod.Settings.advancedSpeciesFactor=.2f;
            Near(.6f,Cleanliness.TraitFactor(pawn));
            dialog.PreClose(); Near(.2f,Cleanliness.TraitFactor(pawn));
            Require(HousebrokenMod.Instance.Writes==1,"Close did not write settings");
            Require(Scribe_Values.Data["advancedSpeciesFactor"]=="0.2","Close saved wrong settings");
            worker.def.buttonVisible=false; Require(!worker.Visible,"Shortcut cannot be hidden again");
        });
        test("Settings: reset requires confirmation then restores shared values", () => {
            try {
                HousebrokenMod.Settings.obedientFactor=.1f;
                Listing_Standard.ResetClicked=true;
                HousebrokenMod.Instance.DoSettingsWindowContents(new(0,40,860,600));
                Near(.1f,HousebrokenMod.Settings.obedientFactor);
                ((Dialog_MessageBox)Find.WindowStack.Last).Confirm();
                Near(.5f,HousebrokenMod.Settings.obedientFactor);
            } finally { Listing_Standard.ResetClicked=false; }
        });
    }
}
