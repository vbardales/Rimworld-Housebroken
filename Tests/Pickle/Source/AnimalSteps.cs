using System;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using UnityEngine;
using Verse;

namespace Housebroken.PickleSteps
{
    [PickleSteps]
    public sealed class AnimalSteps
    {
        internal static Pawn Named(PickleContext ctx, string name)
        {
            var map = Yard.Map(ctx);
            var pawn = map.mapPawns.AllPawnsSpawned.FirstOrDefault(p =>
                (p.Name is NameSingle single && single.Name == name) || p.LabelShort == name);
            ctx.Require(pawn != null, "no spawned pawn named \"" + name + "\"");
            return pawn;
        }

        internal static float Parse(PickleContext ctx, string text)
        {
            float value;
            ctx.Require(float.TryParse(text, NumberStyles.Float, CultureInfo.InvariantCulture, out value),
                "\"" + text + "\" is not a number");
            return value;
        }

        private static IntVec3 FreeCell(PickleContext ctx)
        {
            var map = Yard.Map(ctx);
            if (Yard.Built)
            {
                var free = Yard.Cells(ctx, Yard.Outdoors).FirstOrDefault(c => c.GetFirstPawn(map) == null);
                if (free.IsValid) return free;
            }
            IntVec3 cell;
            var found = CellFinder.TryFindRandomCellNear(map.Center, map, 25,
                c => c.Standable(map) && c.GetEdifice(map) == null && c.GetFirstPawn(map) == null, out cell);
            ctx.Require(found, "no free standable cell near the map centre");
            return cell;
        }

        private static Pawn Spawn(PickleContext ctx, string name, string kindName, Faction faction, float age)
        {
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, "no PawnKindDef named \"" + kindName + "\"");
            var pawn = PawnGenerator.GeneratePawn(new PawnGenerationRequest(
                kind, faction, forceGenerateNewPawn: true, fixedBiologicalAge: age));
            pawn.Name = new NameSingle(name);
            GenSpawn.Spawn(pawn, FreeCell(ctx), Yard.Map(ctx));
            if (pawn.RaceProps.Animal && pawn.training == null) pawn.training = new Pawn_TrainingTracker(pawn);
            return pawn;
        }

        [Given("Housebroken spawns the colony animal {string} as {string}")]
        public void SpawnColony(PickleContext ctx, string name, string kind) { Spawn(ctx, name, kind, Faction.OfPlayer, 3f); }

        [Given("Housebroken spawns the wild animal {string} as {string}")]
        public void SpawnWild(PickleContext ctx, string name, string kind) { Spawn(ctx, name, kind, null, 3f); }

        [Given("Housebroken spawns the animal {string} as {string} owned by another faction")]
        public void SpawnOtherFaction(PickleContext ctx, string name, string kind)
        {
            var faction = Find.FactionManager.AllFactionsListForReading.FirstOrDefault(f =>
                !f.IsPlayer && !f.def.hidden && f.def.humanlikeFaction);
            ctx.Require(faction != null, "no visible humanlike non-player faction is available");
            Spawn(ctx, name, kind, null, 3f).SetFaction(faction);
        }

        [Given("Housebroken spawns the colonist {string}")]
        public void SpawnColonist(PickleContext ctx, string name) { Spawn(ctx, name, "Colonist", Faction.OfPlayer, 25f); }

        [Given("Housebroken spawns the mechanoid {string} for the colony")]
        public void SpawnMech(PickleContext ctx, string name)
        {
            ctx.Require(ModsConfig.BiotechActive, "Biotech is not active in this pass, so there is no mechanoid to spawn");
            var kind = DefDatabase<PawnKindDef>.AllDefsListForReading.FirstOrDefault(k => k.RaceProps.IsMechanoid && k.race != null);
            ctx.Require(kind != null, "no mechanoid PawnKindDef is loaded");
            Spawn(ctx, name, kind.defName, Faction.OfPlayer, 1f);
        }

        [When("Housebroken gives {string} to the player faction")]
        public void JoinPlayer(PickleContext ctx, string name) { Named(ctx, name).SetFaction(Faction.OfPlayer); }

        [When("Housebroken removes {string} from every faction")]
        public void LeavePlayer(PickleContext ctx, string name) { Named(ctx, name).SetFaction(null); }

        private static TrainableDef Trainable(PickleContext ctx, string name)
        {
            var def = DefDatabase<TrainableDef>.GetNamedSilentFail(name);
            ctx.Require(def != null, "no TrainableDef named \"" + name + "\"");
            return def;
        }

        private static Pawn_TrainingTracker Tracker(PickleContext ctx, Pawn pawn)
        {
            ctx.Require(pawn.training != null, pawn.LabelShort + " has no training tracker");
            return pawn.training;
        }

        [Given("Housebroken teaches {string} the training {string}")]
        public void Teach(PickleContext ctx, string name, string training)
        {
            var def = Trainable(ctx, training);
            var tracker = Tracker(ctx, Named(ctx, name));
            tracker.steps[def] = def.steps;
            tracker.learned[def] = true;
        }

        [Given("Housebroken half-teaches {string} the training {string}")]
        public void HalfTeach(PickleContext ctx, string name, string training)
        {
            var def = Trainable(ctx, training);
            var tracker = Tracker(ctx, Named(ctx, name));
            tracker.steps[def] = Math.Max(1, def.steps - 1);
            tracker.learned[def] = false;
        }

        [When("Housebroken makes {string} forget the training {string}")]
        public void Forget(PickleContext ctx, string name, string training)
        {
            var def = Trainable(ctx, training);
            var tracker = Tracker(ctx, Named(ctx, name));
            tracker.steps[def] = 0;
            tracker.learned[def] = false;
        }

        [When("Housebroken gives {string} the sentience catalyst")]
        public void Catalyst(PickleContext ctx, string name)
        {
            ctx.Require(ModsConfig.OdysseyActive, "Odyssey is not active in this pass: the sentience catalyst is not available");
            var pawn = Named(ctx, name);
            pawn.health.AddHediff(HediffDefOf.SentienceCatalyst);
            ctx.Require(pawn.health.hediffSet.HasHediff(HediffDefOf.SentienceCatalyst), "the catalyst hediff was not added");
        }

        [When("Housebroken lets {int} game ticks pass", TimeoutSeconds = 120f)]
        public async Task Tick(PickleContext ctx, int ticks)
        {
            var previous = Find.TickManager.CurTimeSpeed;
            Find.TickManager.CurTimeSpeed = TimeSpeed.Superfast;
            try { await ctx.WaitTicks(ticks); }
            finally { Find.TickManager.CurTimeSpeed = previous; }
        }

        internal static void PutAt(PickleContext ctx, Pawn pawn, string place)
        {
            var cell = Yard.Center(ctx, place);
            pawn.jobs?.StopAll();
            pawn.Position = cell;
            pawn.Notify_Teleported(false, true);
        }

        [When("Housebroken puts {string} at {string}")]
        public void Put(PickleContext ctx, string name, string place) { PutAt(ctx, Named(ctx, name), place); }

        [When("Housebroken removes the home area from the cell of {string}")]
        public void RemoveHome(PickleContext ctx, string name)
        {
            var pawn = Named(ctx, name);
            pawn.Map.areaManager.Home[pawn.Position] = false;
        }

        [When("Housebroken restores the home area on the cell of {string}")]
        public void RestoreHome(PickleContext ctx, string name)
        {
            var pawn = Named(ctx, name);
            pawn.Map.areaManager.Home[pawn.Position] = true;
        }

        private static float BaseRate(Pawn pawn) { return pawn.def.GetStatValueAbstract(StatDefOf.FilthRate); }

        private static void AssertRate(PickleContext ctx, Pawn pawn, string factorText)
        {
            var factor = Parse(ctx, factorText);
            var baseRate = BaseRate(pawn);
            ctx.Require(baseRate > 0f, pawn.LabelShort + " has a base filth rate of " + baseRate + ", so no ratio can be read");
            var actual = pawn.GetStatValue(StatDefOf.FilthRate);
            var expected = baseRate * factor;
            ctx.Assert(Mathf.Abs(actual - expected) <= 0.0005f * Mathf.Max(1f, baseRate),
                pawn.LabelShort + " has filth rate " + actual.ToString("0.####", CultureInfo.InvariantCulture)
                + " (" + (actual / baseRate).ToString("0.####", CultureInfo.InvariantCulture) + " x its base "
                + baseRate.ToString("0.####", CultureInfo.InvariantCulture) + "), expected " + factorText + " x = "
                + expected.ToString("0.####", CultureInfo.InvariantCulture));
        }

        [Then("Housebroken filth rate of {string} is {string} times its base rate")]
        public void RateIs(PickleContext ctx, string name, string factor) { AssertRate(ctx, Named(ctx, name), factor); }

        // Placing and reading share one step on purpose: no game tick can pass between the two, so
        // the animal cannot wander off the cell that is being tested.
        [Then("Housebroken filth rate of {string} at {string} is {string} times its base rate")]
        public void RateAtIs(PickleContext ctx, string name, string place, string factor)
        {
            var pawn = Named(ctx, name);
            PutAt(ctx, pawn, place);
            AssertRate(ctx, pawn, factor);
        }

        private static string Explanation(Pawn pawn)
        {
            var stat = StatDefOf.FilthRate;
            return stat.Worker.GetExplanationFull(StatRequest.For(pawn), ToStringNumberSense.Absolute,
                pawn.GetStatValue(stat));
        }

        // The translated line up to its placeholder, so the check follows the language of the pass.
        private static string Prefix(string key)
        {
            var resolved = key.Translate("@@").Resolve();
            var cut = resolved.IndexOf("@@", StringComparison.Ordinal);
            return cut < 0 ? resolved : resolved.Substring(0, cut);
        }

        private static void ExplanationHas(PickleContext ctx, Pawn pawn, string key, bool expected)
        {
            var text = Explanation(pawn);
            var prefix = Prefix(key);
            ctx.Assert(text.Contains(prefix) == expected,
                pawn.LabelShort + " explanation " + (expected ? "lacks" : "carries") + " \"" + prefix + "\" in:\n" + text);
        }

        [Then("Housebroken explanation for {string} names the training factor")]
        public void ExplainsTraining(PickleContext ctx, string name) { ExplanationHas(ctx, Named(ctx, name), "Housebroken.Stat.Trained", true); }

        [Then("Housebroken explanation for {string} names no Housebroken factor")]
        public void ExplainsNothing(PickleContext ctx, string name)
        {
            var pawn = Named(ctx, name);
            ExplanationHas(ctx, pawn, "Housebroken.Stat.Trained", false);
            ExplanationHas(ctx, pawn, "Housebroken.Stat.HoldingIt", false);
            ExplanationHas(ctx, pawn, "Housebroken.Stat.Outside", false);
        }

        [Then("Housebroken explanation for {string} names the holding rule")]
        public void ExplainsHolding(PickleContext ctx, string name)
        {
            var pawn = Named(ctx, name);
            ExplanationHas(ctx, pawn, "Housebroken.Stat.HoldingIt", true);
            ExplanationHas(ctx, pawn, "Housebroken.Stat.Outside", false);
        }

        [Then("Housebroken explanation for {string} names the outside rule")]
        public void ExplainsOutside(PickleContext ctx, string name)
        {
            var pawn = Named(ctx, name);
            ExplanationHas(ctx, pawn, "Housebroken.Stat.Outside", true);
            ExplanationHas(ctx, pawn, "Housebroken.Stat.HoldingIt", false);
        }

        [Then("Housebroken explanation for {string} names no location rule")]
        public void ExplainsNoLocation(PickleContext ctx, string name)
        {
            var pawn = Named(ctx, name);
            ExplanationHas(ctx, pawn, "Housebroken.Stat.HoldingIt", false);
            ExplanationHas(ctx, pawn, "Housebroken.Stat.Outside", false);
        }

        [Then("Housebroken trainability of {string} is {word}")]
        public void TrainabilityIs(PickleContext ctx, string name, string expected)
        {
            var actual = TrainableUtility.GetTrainability(Named(ctx, name));
            ctx.Assert(actual != null && actual.defName == expected,
                name + " has trainability " + (actual == null ? "none at all" : actual.defName) + ", expected " + expected);
        }
    }
}
