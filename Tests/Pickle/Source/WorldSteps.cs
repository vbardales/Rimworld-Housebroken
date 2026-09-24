using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using RimWorld.Planet;
using UnityEngine;
using Verse;

namespace Housebroken.PickleSteps
{
    /// <summary>
    /// A second colony map, and an animal that travels to it by caravan. The game entry points are the
    /// ones the caravan dialog ends in: CaravanExitMapUtility turns the pawns into a caravan on the world
    /// map, CaravanEnterMapUtility puts them on a map. The travel across the world is not simulated.
    /// </summary>
    [PickleSteps]
    public sealed class WorldSteps
    {
        private static Map secondMap;

        [BeforeScenario]
        public void Forget(PickleContext ctx) { secondMap = null; }

        [Given("Housebroken founds a second colony map", TimeoutSeconds = 180f)]
        public async Task FoundSecondMap(PickleContext ctx)
        {
            var first = Yard.Map(ctx);
            int tile = -1;
            for (int radius = 1; radius < 40 && tile < 0; radius++)
            {
                var candidates = Enumerable.Range(0, Find.WorldGrid.TilesCount)
                    .Where(t => Find.WorldGrid.ApproxDistanceInTiles(first.Tile, t) == radius
                        && TileFinder.IsValidTileForNewSettlement(t));
                if (candidates.Any()) tile = candidates.First();
            }
            ctx.Require(tile >= 0, "no valid tile for a second settlement within 40 tiles of the first map");

            var settlement = (Settlement)WorldObjectMaker.MakeWorldObject(WorldObjectDefOf.Settlement);
            settlement.SetFaction(Faction.OfPlayer);
            settlement.Tile = tile;
            settlement.Name = "Housebroken test";
            Find.WorldObjects.Add(settlement);
            secondMap = GetOrGenerateMapUtility.GetOrGenerateMap(tile, new IntVec3(75, 1, 75), null);
            ctx.Require(secondMap != null, "the second map was not generated");
            await ctx.WaitFrames(5);
            ctx.Assert(Find.Maps.Count >= 2, "the game holds " + Find.Maps.Count + " map(s) after founding the second one");
        }

        [When("Housebroken sends {string} on a caravan towards the second map")]
        public void Depart(PickleContext ctx, string name)
        {
            ctx.Require(secondMap != null, "no second map: found it first");
            var pawn = AnimalSteps.Named(ctx, name);
            ctx.Require(pawn.Spawned, name + " is not on a map, so it cannot leave one");
            var from = pawn.Map;
            var caravan = CaravanExitMapUtility.ExitMapAndCreateCaravan(
                Gen.YieldSingle(pawn), Faction.OfPlayer, from.Tile, from.Tile, secondMap.Tile, false);
            ctx.Require(caravan != null, "no caravan was created");
            ctx.Assert(!pawn.Spawned && pawn.GetCaravan() == caravan, name + " is not in the caravan after leaving the map");
        }

        [Then("Housebroken filth rate of {string} can be read while it is on a caravan")]
        public void ReadInTransit(PickleContext ctx, string name)
        {
            var pawn = AnimalSteps.Named(ctx, name);
            ctx.Require(pawn.GetCaravan() != null, name + " is not on a caravan");
            var rate = pawn.GetStatValue(StatDefOf.FilthRate);
            ctx.Attach("filth rate on a caravan", rate.ToString("0.####", System.Globalization.CultureInfo.InvariantCulture));
            ctx.Assert(!float.IsNaN(rate) && !float.IsInfinity(rate) && rate >= 0f,
                name + " has a filth rate of " + rate + " while it is on a caravan");
        }

        [When("Housebroken lets the caravan of {string} arrive on the second map")]
        public void Arrive(PickleContext ctx, string name)
        {
            ctx.Require(secondMap != null, "no second map: found it first");
            var pawn = AnimalSteps.Named(ctx, name);
            var caravan = pawn.GetCaravan();
            ctx.Require(caravan != null, name + " is not on a caravan");
            CaravanEnterMapUtility.Enter(caravan, secondMap, CaravanEnterMode.Center, CaravanDropInventoryMode.DoNotDrop, false);
            Current.Game.CurrentMap = secondMap;
            ctx.Assert(pawn.Spawned && pawn.Map == secondMap, name + " is not on the second map after the caravan arrived");
        }

        [When("Housebroken looks at the first map again")]
        public void FirstMapAgain(PickleContext ctx)
        {
            var first = Find.Maps.FirstOrDefault(m => m != secondMap);
            ctx.Require(first != null, "the first map is gone");
            Current.Game.CurrentMap = first;
        }
    }
}
