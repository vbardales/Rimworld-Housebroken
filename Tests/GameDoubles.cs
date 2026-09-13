// Minimal boundary doubles, not an implementation of RimWorld or Harmony.
namespace HarmonyLib
{
    public class Harmony { public Harmony(string id) { } public void PatchAll() { } }
    [AttributeUsage(AttributeTargets.Class)]
    public sealed class HarmonyPatch : Attribute
    {
        public HarmonyPatch(Type type, string method) { }
    }
}
namespace Verse
{
    public class Thing { }
    public class Pawn : Thing
    {
        public object def = new();
        public RaceProperties RaceProps = new();
        public RimWorld.Faction Faction = RimWorld.Faction.OfPlayer;
        public int thingIDNumber;
        public RimWorld.TrainingTracker training = new();
        public RimWorld.TrainabilityDef Trainability = new();
        public bool Spawned = true;
        public Map Map = new();
        public IntVec3 Position;
    }
    public class RaceProperties { public bool Animal = true; }
    public class Map
    {
        public bool InBounds = true;
        public object Roof = new();
        public Room Room = new();
        public AreaManager areaManager = new();
    }
    public class Room { public bool TouchesMapEdge; public bool IsDoorway; }
    public class AreaManager { public Area Home = new(); }
    public class Area { public bool Value = true; public bool this[IntVec3 cell] => Value; }
    public struct IntVec3
    {
        public bool InBounds(Map map) => map.InBounds;
        public object GetRoof(Map map) => map.Roof;
        public Room GetRoom(Map map) => map.Room;
    }
    public static class Find { public static TickManager TickManager; public static WindowStack WindowStack = new(); }
    public class TickManager { public int TicksGame; }
    public static class DefDatabase<T> { public static List<T> AllDefsListForReading = new(); }
    public class ModSettings { public virtual void ExposeData() { } }
    public static class Scribe_Values
    {
        public static LoadSaveMode Mode;
        public static Dictionary<string, string> Data = new();
        public static void Look<T>(ref T value, string key, T defaultValue)
        {
            if (Mode == LoadSaveMode.Saving) Data[key] = Convert.ToString(value, System.Globalization.CultureInfo.InvariantCulture);
            if (Mode == LoadSaveMode.LoadingVars)
                value = Data.TryGetValue(key, out var text)
                    ? (T)Convert.ChangeType(text, typeof(T), System.Globalization.CultureInfo.InvariantCulture) : defaultValue;
        }
    }
    public class Pawn_FilthTracker { public Pawn pawn; }
    public class Target { public Thing Thing; }
    public enum ToStringStyle { PercentZero }
    public enum ToStringNumberSense { Factor }
    public static class TextExtensions
    {
        public static string Translate(this string key, params object[] args) => key + ":" + string.Join(",", args);
        public static string ToStringByStyle(this float value, ToStringStyle style, ToStringNumberSense sense) => value.ToString(System.Globalization.CultureInfo.InvariantCulture);
        public static string TrimEndNewlines(this string value) => value.TrimEnd('\r', '\n');
    }
}
namespace RimWorld
{
    public class Faction { public static readonly Faction OfPlayer = new(); }
    public class TrainableDef { }
    public static class TrainableDefOf
    {
        public static readonly TrainableDef Tameness = new();
        public static readonly TrainableDef Obedience = new();
    }
    public class TrainingTracker
    {
        public HashSet<TrainableDef> Learned = new();
        public bool HasLearned(TrainableDef def) => Learned.Contains(def);
    }
    public class TrainabilityDef { public int intelligenceOrder; }
    public static class TrainableUtility
    {
        public static TrainabilityDef GetTrainability(Verse.Pawn pawn) => pawn.Trainability;
    }
    public class Alert_AnimalFilth
    {
        public List<Verse.Target> targets = new();
        public List<string> pawnEntries = new();
    }
    public struct StatRequest { public Verse.Thing Thing; }
    public abstract class StatPart
    {
        public abstract void TransformValue(StatRequest req, ref float val);
        public abstract string ExplanationPart(StatRequest req);
        public abstract bool ForceShow(StatRequest req);
    }
}
namespace UnityEngine
{
    public struct Vector2 { }
    public struct Rect
    {
        public float x, y, width, height;
        public Rect(float x, float y, float width, float height) { this.x=x; this.y=y; this.width=width; this.height=height; }
    }
    public static class Mathf
    {
        public static float Max(float a,float b)=>Math.Max(a,b);
        public static int RoundToInt(float v)=>(int)Math.Round(v);
        public static float Round(float v)=>(float)Math.Round(v);
        public static float Clamp01(float v)=>Math.Clamp(v,0,1);
        public static float Clamp(float v,float min,float max)=>Math.Clamp(v,min,max);
    }
}
namespace Verse
{
    public enum LoadSaveMode { Inactive, Saving, LoadingVars }
    public class ModContentPack { }
    public class Mod
    {
        private ModSettings settings;
        public int Writes;
        public Mod(ModContentPack content) { }
        public T GetSettings<T>() where T:ModSettings,new() => (T)(settings ??= new T());
        public virtual string SettingsCategory()=>"";
        public virtual void WriteSettings() { Writes++; Scribe_Values.Mode=LoadSaveMode.Saving; settings.ExposeData(); Scribe_Values.Mode=LoadSaveMode.Inactive; }
        public virtual void DoSettingsWindowContents(UnityEngine.Rect rect) { }
    }
    public class WindowStack { public object Last; public void Add(object window) { Last=window; } }
    public class Dialog_MessageBox
    {
        public Action Confirm;
        public static Dialog_MessageBox CreateConfirmation(string text,Action action,bool destructive=false)=>new(){Confirm=action};
    }
    public static class Widgets
    {
        public static void BeginScrollView(UnityEngine.Rect rect,ref UnityEngine.Vector2 position,UnityEngine.Rect view) { }
        public static void EndScrollView() { }
    }
    public class Listing_Standard
    {
        public static Func<string,float,float> SliderInput;
        public static bool ResetClicked;
        public float CurHeight;
        public void Begin(UnityEngine.Rect rect) { }
        public void End() { }
        public void Label(string text) { CurHeight+=25; }
        public void GapLine() { CurHeight+=12; }
        public void Gap() { CurHeight+=12; }
        public void CheckboxLabeled(string label,ref bool value,string tip) { CurHeight+=25; }
        public bool ButtonText(string text) => ResetClicked;
        public float SliderLabeled(string label,float value,float min,float max,float labelPct,string tooltip)
            => SliderInput?.Invoke(label,value) ?? value;
    }
}
namespace RimWorld
{
    public class MainButtonDef { public bool buttonVisible; }
    public abstract class MainButtonWorker
    {
        public MainButtonDef def;
        public virtual bool Visible=>def.buttonVisible;
        public abstract void Activate();
    }
    // Boundary contract only: native constructor and PreClose verified by decompilation.
    public class Dialog_ModSettings
    {
        public Verse.Mod Mod;
        public Dialog_ModSettings(Verse.Mod mod) { Mod=mod; }
        public void PreClose()=>Mod.WriteSettings();
    }
}
