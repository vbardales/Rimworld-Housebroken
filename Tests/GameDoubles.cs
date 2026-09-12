// Minimal boundary doubles, not an implementation of RimWorld or Harmony.
namespace HarmonyLib
{
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
    public static class Find { public static TickManager TickManager; }
    public class TickManager { public int TicksGame; }
    public static class DefDatabase<T> { public static List<T> AllDefsListForReading = new(); }
    public class ModSettings { public virtual void ExposeData() { } }
    public static class Scribe_Values
    {
        public static void Look<T>(ref T value, string key, T defaultValue) { }
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
namespace Housebroken
{
    public static class HousebrokenMod { public static HousebrokenSettings Settings = new(); }
}
