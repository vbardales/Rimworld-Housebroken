using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using RimWorld.Planet;
using Verse;

namespace Housebroken.PickleSteps
{
    /// <summary>
    /// Deposits and the alert, driven through the game own entry points: Notify_EnteredNewCell is
    /// the method the game calls when a pawn steps onto a new cell, and GetReport is the one that
    /// builds the alert list. Only the walking is replaced, by teleporting the animal cell to cell;
    /// every roll, every drop and every filter after that is the game code and the mod patches.
    /// </summary>
    [PickleSteps]
    public sealed class FilthSteps
    {
        private sealed class Tally
        {
            public int manure;
            public int droppedThickness;
            public int loadsLost;
            public int steps;
        }

        private static readonly Dictionary<string, Tally> tallies = new Dictionary<string, Tally>();
        private static readonly Dictionary<string, ThingDef> loads = new Dictionary<string, ThingDef>();
        private static Alert_AnimalFilth alert;

        [BeforeScenario]
        public void Forget(PickleContext ctx)
        {
            tallies.Clear();
            loads.Clear();
            alert = null;
        }

        private static ThingDef FilthDef(PickleContext ctx, string word)
        {
            var name = "Filth_" + word;
            var def = DefDatabase<ThingDef>.GetNamedSilentFail(name);
            ctx.Require(def != null, "no filth def named " + name);
            return def;
        }

        private static bool Carries(Pawn pawn, ThingDef def)
        {
            return pawn.filth.CarriedFilthListForReading.Any(f => f.def == def);
        }

        [Given("Housebroken loads {string} with carried {word}")]
        public void Load(PickleContext ctx, string name, string word)
        {
            var pawn = AnimalSteps.Named(ctx, name);
            var def = FilthDef(ctx, word);
            pawn.filth.GainFilth(def);
            loads[name] = def;
            ctx.Assert(Carries(pawn, def), name + " does not carry " + def.defName + " after being given it");
        }

        [Then("Housebroken confirms that {string} carries {word}")]
        public void Confirm(PickleContext ctx, string name, string word)
        {
            var def = FilthDef(ctx, word);
            ctx.Assert(Carries(AnimalSteps.Named(ctx, name), def), name + " does not carry " + def.defName);
        }

        [When("Housebroken walks {string} for {int} steps at {string}", TimeoutSeconds = 60f)]
        public void Walk(PickleContext ctx, string name, int steps, string place)
        {
            var pawn = AnimalSteps.Named(ctx, name);
            var route = Yard.Cells(ctx, place);
            var map = pawn.Map;
            ThingDef load;
            loads.TryGetValue(name, out load);
            var tally = new Tally();
            tallies[name] = tally;
            pawn.jobs?.StopAll();
            for (int i = 0; i < steps; i++)
            {
                var cell = route[i % route.Count];
                pawn.Position = cell;
                pawn.filth.Notify_EnteredNewCell();
                tally.steps++;
                foreach (var filth in cell.GetThingList(map).OfType<Filth>().ToList())
                {
                    if (filth.def == ThingDefOf.Filth_AnimalFilth) tally.manure += filth.thickness;
                    else tally.droppedThickness += filth.thickness;
                    filth.Destroy();
                }
                if (load != null && !Carries(pawn, load))
                {
                    tally.loadsLost++;
                    pawn.filth.GainFilth(load);
                }
            }
        }

        private static Tally TallyOf(PickleContext ctx, string name)
        {
            Tally tally;
            ctx.Require(tallies.TryGetValue(name, out tally), "nothing was walked for " + name);
            return tally;
        }

        private static string Describe(string name, Tally t)
        {
            return name + " over " + t.steps + " steps: manure " + t.manure + ", dropped filth "
                + t.droppedThickness + ", carried load lost " + t.loadsLost + " times";
        }

        // The mod's own path, in place: the game's step-by-cell entry point run where the animal stands, so a dropping
        // that appears on its cell is what the mod lets through (nothing is staged).
        [When("Housebroken lets {string} step {int} times where it stands", TimeoutSeconds = 60f)]
        public void StepInPlace(PickleContext ctx, string name, int steps)
        {
            var pawn = AnimalSteps.Named(ctx, name);
            pawn.jobs?.StopAll();
            for (int i = 0; i < steps; i++) pawn.filth.Notify_EnteredNewCell();
        }

        [Then("Housebroken finds animal filth on the cell of {string}")]
        public void FilthOnCell(PickleContext ctx, string name)
        {
            var pawn = AnimalSteps.Named(ctx, name);
            ctx.Assert(pawn.Position.GetThingList(pawn.Map).OfType<Filth>().Any(f => f.def == ThingDefOf.Filth_AnimalFilth),
                "no animal filth on the cell of " + name + " " + pawn.Position);
        }

        // Outdoors the dropping may land on a neighbouring cell (the game looks for a place when its own is taken).
        [Then("Housebroken finds animal filth within {int} cells of {string}")]
        public void FilthNear(PickleContext ctx, int radius, string name)
        {
            var pawn = AnimalSteps.Named(ctx, name);
            var found = GenRadial.RadialCellsAround(pawn.Position, radius, true).Where(c => c.InBounds(pawn.Map))
                .Any(c => c.GetThingList(pawn.Map).OfType<Filth>().Any(x => x.def == ThingDefOf.Filth_AnimalFilth));
            ctx.Assert(found, "no animal filth within " + radius + " cells of " + name + " " + pawn.Position);
        }

        [Then("Housebroken finds no animal filth on the cell of {string}")]
        public void NoFilthOnCell(PickleContext ctx, string name)
        {
            var pawn = AnimalSteps.Named(ctx, name);
            ctx.Assert(!pawn.Position.GetThingList(pawn.Map).OfType<Filth>().Any(f => f.def == ThingDefOf.Filth_AnimalFilth),
                "animal filth on the cell of " + name + " " + pawn.Position);
        }

        [Then("Housebroken counted no manure from {string}")]
        public void NoManure(PickleContext ctx, string name)
        {
            var t = TallyOf(ctx, name);
            ctx.Assert(t.manure == 0, Describe(name, t));
        }

        [Then("Housebroken counted manure from {string}")]
        public void SomeManure(PickleContext ctx, string name)
        {
            var t = TallyOf(ctx, name);
            ctx.Assert(t.manure > 0, Describe(name, t));
        }

        [Then("Housebroken counted no dropped filth from {string}")]
        public void NoDrop(PickleContext ctx, string name)
        {
            var t = TallyOf(ctx, name);
            ctx.Assert(t.droppedThickness == 0 && t.loadsLost == 0, Describe(name, t));
        }

        [Then("Housebroken counted dropped filth from {string}")]
        public void SomeDrop(PickleContext ctx, string name)
        {
            var t = TallyOf(ctx, name);
            ctx.Assert(t.droppedThickness > 0 || t.loadsLost > 0, Describe(name, t));
        }

        [When("Housebroken recalculates the animal filth alert")]
        public void Recalculate(PickleContext ctx)
        {
            alert = new Alert_AnimalFilth();
            alert.GetReport();
        }

        private static List<Pawn> Listed(PickleContext ctx)
        {
            ctx.Require(alert != null, "the alert was not recalculated: add the step that does it first");
            var targets = alert.targets;
            var entries = alert.pawnEntries;
            ctx.Assert(targets.Count == entries.Count,
                "the alert holds " + targets.Count + " targets but " + entries.Count + " names");
            var pawns = new List<Pawn>();
            for (int i = 0; i < targets.Count; i++)
            {
                var pawn = targets[i].Thing as Pawn;
                ctx.Assert(pawn != null, "alert entry " + i + " does not point at a pawn");
                if (pawn == null) continue;
                pawns.Add(pawn);
                if (i < entries.Count)
                    ctx.Assert(entries[i].Contains(pawn.LabelShort),
                        "alert entry " + i + " is named \"" + entries[i] + "\" but points at " + pawn.LabelShort);
            }
            return pawns;
        }

        [Then("Housebroken alert lists {string}")]
        public void Lists(PickleContext ctx, string name)
        {
            var listed = Listed(ctx);
            ctx.Assert(listed.Any(p => p.LabelShort == name),
                name + " is not in the alert, which lists: " + string.Join(", ", listed.Select(p => p.LabelShort).ToArray()));
        }

        [Then("Housebroken alert does not list {string}")]
        public void DoesNotList(PickleContext ctx, string name)
        {
            var listed = Listed(ctx);
            ctx.Assert(listed.All(p => p.LabelShort != name),
                name + " is in the alert, which lists: " + string.Join(", ", listed.Select(p => p.LabelShort).ToArray()));
        }

        [Then("Housebroken alert entries all name their own target")]
        public void EntriesAlign(PickleContext ctx) { Listed(ctx); }
    }
}
