using Housebroken;
using RimWorld;
using Verse;

// Package-free executable test suite. Nonzero exit code means failure.
internal static class Program
{
    static int passed, failed, nextId;
    static readonly TrainableDef Haul = new(), Rescue = new();
    static HousebrokenSettings Settings => HousebrokenMod.Settings;
    static Pawn Animal(int order = 30, bool obedient = false, int extras = 0)
    {
        var pawn = new Pawn { thingIDNumber = ++nextId, Trainability = new() { intelligenceOrder = order } };
        pawn.training.Learned.Add(TrainableDefOf.Tameness);
        if (obedient) pawn.training.Learned.Add(TrainableDefOf.Obedience);
        if (extras > 0) pawn.training.Learned.Add(Haul);
        if (extras > 1) pawn.training.Learned.Add(Rescue);
        return pawn;
    }
    static void Equal<T>(T expected, T actual)
    {
        if (!EqualityComparer<T>.Default.Equals(expected, actual)) throw new Exception($"Expected {expected}; got {actual}");
    }
    static void Near(float expected, float actual)
    {
        if (!float.IsFinite(actual) || Math.Abs(expected - actual) > 0.00001f) throw new Exception($"Expected {expected}; got {actual}");
    }
    static void Test(string name, Action body)
    {
        Scribe_Values.Mode = LoadSaveMode.Inactive;
        Scribe_Values.Data.Clear();
        new HousebrokenMod(new ModContentPack());
        Find.TickManager = new() { TicksGame = 1000 };
        Cleanliness.ClearCache();
        DefDatabase<TrainableDef>.AllDefsListForReading = new() { TrainableDefOf.Tameness, TrainableDefOf.Obedience, Haul, Rescue };
        try { body(); passed++; Console.WriteLine($"PASS {name}"); }
        catch (Exception e) { failed++; Console.WriteLine($"FAIL {name}: {e.Message}"); }
    }
    static bool Drop(Pawn pawn) => Patch_TryDropFilth.Prefix(new() { pawn = pawn });
    static int Main()
    {
        foreach (var row in new[] { (0,false,0,1f), (20,false,0,.8f), (30,false,0,.6f), (20,true,0,.4f), (30,true,0,.3f), (30,true,1,.15f), (30,true,2,.15f), (30,false,1,.3f), (9,false,0,1f), (10,false,0,.8f), (24,false,0,.8f), (25,false,0,.6f) })
            Test($"Trait matrix {row}", () => Near(row.Item4, Cleanliness.TraitFactor(Animal(row.Item1,row.Item2,row.Item3))));
        Test("No tameness prevents training bonus", () => { var p = Animal(30,true,1); p.training.Learned.Remove(TrainableDefOf.Tameness); Near(.6f,Cleanliness.TraitFactor(p)); });
        Test("Missing training retains species bonus", () => { var p = Animal(); p.training = null; Near(.6f,Cleanliness.TraitFactor(p)); });
        Test("Missing trainability retains training bonus", () => { var p = Animal(30,true); p.Trainability = null; Near(.5f,Cleanliness.TraitFactor(p)); });
        Test("Custom reductions multiply", () => { Settings.wellTrainedFactor=.4f; Settings.advancedSpeciesFactor=.75f; Near(.3f,Cleanliness.TraitFactor(Animal(30,true,1))); });
        Test("Zero factor is valid", () => { Settings.wellTrainedFactor=0; Near(0,Cleanliness.TotalFactor(Animal(30,true,1))); });
        Test("Scope and invalid requests", () => {
            Equal(false,Cleanliness.AppliesTo(null)); var p=Animal(); Equal(true,Cleanliness.AppliesTo(p));
            p.Faction=null; Equal(false,Cleanliness.AppliesTo(p)); p.Faction=new(); Equal(false,Cleanliness.AppliesTo(p));
            Settings.colonyAnimalsOnly=false; Equal(true,Cleanliness.AppliesTo(p));
            p.RaceProps.Animal=false; Equal(false,Cleanliness.AppliesTo(p)); p.RaceProps=null; Equal(false,Cleanliness.AppliesTo(p));
            p=Animal(); p.def=null; Equal(false,Cleanliness.AppliesTo(p));
            typeof(HousebrokenMod).GetProperty(nameof(HousebrokenMod.Settings)).SetValue(null, null); Equal(false,Cleanliness.AppliesTo(Animal()));
        });
        Test("Cache expires at exactly 250 ticks", () => { var p=Animal(); Near(.6f,Cleanliness.TraitFactor(p)); p.training.Learned.Add(TrainableDefOf.Obedience); Find.TickManager.TicksGame+=249; Near(.6f,Cleanliness.TraitFactor(p)); Find.TickManager.TicksGame++; Near(.3f,Cleanliness.TraitFactor(p)); });
        Test("Cache clear applies settings immediately", () => { var p=Animal(); Near(.6f,Cleanliness.TraitFactor(p)); Settings.advancedSpeciesFactor=.9f; Cleanliness.ClearCache(); Near(.9f,Cleanliness.TraitFactor(p)); });
        Test("No tick manager computes fresh", () => { Find.TickManager=null; var p=Animal(); Near(.6f,Cleanliness.TraitFactor(p)); p.Trainability.intelligenceOrder=20; Near(.8f,Cleanliness.TraitFactor(p)); });
        Test("Clock rewind invalidates cached trait", () => { var p=Animal(); Near(.6f,Cleanliness.TraitFactor(p)); Find.TickManager.TicksGame=100; p.training.Learned.Add(TrainableDefOf.Obedience); Near(.3f,Cleanliness.TraitFactor(p)); });
        Test("Reused pawn ID does not inherit another animal factor", () => { var first=Animal(); Near(.6f,Cleanliness.TraitFactor(first)); var second=Animal(30,true,1); second.thingIDNumber=first.thingIDNumber; Near(.15f,Cleanliness.TraitFactor(second)); });
        Test("Position changes bypass trait cache", () => { var p=Animal(30,true,1); Near(0,Cleanliness.TotalFactor(p)); p.Map.areaManager.Home.Value=false; Near(.3f,Cleanliness.TotalFactor(p)); p.Map.areaManager.Home.Value=true; Near(0,Cleanliness.TotalFactor(p)); });
        foreach (var variant in new[] { "unspawned", "no map", "out of bounds", "no area", "outside home", "no roof", "no room", "edge", "door" })
            Test($"Outside base: {variant}", () => {
                var p=Animal();
                switch(variant) {
                    case "unspawned": p.Spawned=false; break; case "no map": p.Map=null; break;
                    case "out of bounds": p.Map.InBounds=false; break; case "no area": p.Map.areaManager=null; break;
                    case "outside home": p.Map.areaManager.Home.Value=false; break; case "no roof": p.Map.Roof=null; break;
                    case "no room": p.Map.Room=null; break; case "edge": p.Map.Room.TouchesMapEdge=true; break;
                    case "door": p.Map.Room.IsDoorway=true; break;
                }
                Equal(false,Cleanliness.IsInsideBase(p)); Near(2,Cleanliness.PlaceFactor(p));
            });
        Test("Whole home includes unroofed and doorway cells", () => { var p=Animal(); p.Map.Roof=null; p.Map.Room.IsDoorway=true; Settings.wholeHomeArea=true; Equal(true,Cleanliness.IsInsideBase(p)); p.Map.areaManager.Home.Value=false; Equal(false,Cleanliness.IsInsideBase(p)); });
        Test("Custom location multipliers", () => { var p=Animal(30,true,1); Settings.indoorFactor=.5f; Settings.outdoorFactor=3; Near(.075f,Cleanliness.TotalFactor(p)); p.Map.areaManager.Home.Value=false; Near(.45f,Cleanliness.TotalFactor(p)); Settings.manureOutdoors=false; Near(.15f,Cleanliness.TotalFactor(p)); });
        Test("Unreduced animal ignores all cleanliness rules", () => { var p=Animal(0); Near(1,Cleanliness.TotalFactor(p)); Equal(false,Cleanliness.PlaceRuleApplies(p)); Equal(true,Drop(p)); });
        foreach (bool manure in new[]{false,true}) foreach (bool feet in new[]{false,true})
            Test($"Independent options manure={manure}, feet={feet}", () => { var p=Animal(); Settings.manureOutdoors=manure; Settings.wipeFeetIndoors=feet; Equal(!feet,Drop(p)); Near(manure?0:.6f,Cleanliness.TotalFactor(p)); p.Map.areaManager.Home.Value=false; Equal(true,Drop(p)); });
        Test("Feet respect scope and retained whole-home setting", () => { var p=Animal(); p.Faction=null; Equal(true,Drop(p)); Settings.colonyAnimalsOnly=false; Equal(false,Drop(p)); Settings.wholeHomeArea=true; Settings.manureOutdoors=false; p.Map.Roof=null; Equal(false,Drop(p)); typeof(HousebrokenMod).GetProperty(nameof(HousebrokenMod.Settings)).SetValue(null, null); Equal(true,Drop(p)); });
        Test("Mixed alert preserves names and targets", () => {
            var dirty=Animal(0); var clean=Animal(); var visitor=Animal(); visitor.Faction=new(); var thing=new Thing();
            var alert=new Alert_AnimalFilth { targets=new(){new(){Thing=clean},new(){Thing=dirty},new(){Thing=Animal()},new(){Thing=visitor},new(){Thing=thing}}, pawnEntries=new(){"clean","dirty","clean2","visitor","thing"} };
            Patch_AlertAnimalFilth.Postfix(alert); Equal(3,alert.targets.Count); Equal(dirty,alert.targets[0].Thing); Equal(visitor,alert.targets[1].Thing); Equal(thing,alert.targets[2].Thing); Equal("dirty,visitor,thing",string.Join(",",alert.pawnEntries));
        });
        Test("Alert toggle and all-clean list", () => { var a=new Alert_AnimalFilth { targets=new(){new(){Thing=Animal()},new(){Thing=Animal()}}, pawnEntries=new(){"a","b"} }; Settings.exemptFromAlert=false; Patch_AlertAnimalFilth.Postfix(a); Equal(2,a.targets.Count); Settings.exemptFromAlert=true; Patch_AlertAnimalFilth.Postfix(a); Equal(0,a.targets.Count); Equal(0,a.pawnEntries.Count); });
        Test("Alert tolerates absent lists", () => { Patch_AlertAnimalFilth.Postfix(new(){targets=null}); var a=new Alert_AnimalFilth { targets=new(){new(){Thing=Animal()}},pawnEntries=null }; Patch_AlertAnimalFilth.Postfix(a); Equal(0,a.targets.Count); });
        Test("Stat transforms and explains applicable pawn", () => { Settings.manureOutdoors=false; var part=new StatPart_Housebroken(); var req=new StatRequest{Thing=Animal(30,true,1)}; float value=10; part.TransformValue(req,ref value); Near(1.5f,value); Equal(true,part.ForceShow(req)); Equal(true,part.ExplanationPart(req).Contains("Housebroken.Stat.Trained")); Equal(false,part.ExplanationPart(req).Contains("Housebroken.Stat.Outside")); Settings.manureOutdoors=true; Equal(true,part.ExplanationPart(req).Contains("Housebroken.Stat.HoldingIt")); ((Pawn)req.Thing).Map.areaManager.Home.Value=false; Equal(true,part.ExplanationPart(req).Contains("Housebroken.Stat.Outside")); });
        Test("Stat ignores non-pawn and excluded pawn", () => { var part=new StatPart_Housebroken(); var visitor=Animal(); visitor.Faction=null; foreach(var thing in new Thing[]{null,new Thing(),visitor}) { var req=new StatRequest{Thing=thing}; float value=10; part.TransformValue(req,ref value); Near(10,value); Equal(false,part.ForceShow(req)); Equal<string>(null,part.ExplanationPart(req)); } });
        Test("Reset restores every persisted setting", () => { var defaults=new HousebrokenSettings(); foreach(var f in typeof(HousebrokenSettings).GetFields()) { if(f.FieldType==typeof(bool)) f.SetValue(Settings,!(bool)f.GetValue(defaults)); else f.SetValue(Settings, .123f); } Settings.Reset(); foreach(var f in typeof(HousebrokenSettings).GetFields()) Equal(f.GetValue(defaults),f.GetValue(Settings)); });
        XmlTests.Register(Test);
        SettingsTests.Register(Test);
        Console.WriteLine($"\n{passed} passed; {failed} failed.");
        return failed==0?0:1;
    }
}
