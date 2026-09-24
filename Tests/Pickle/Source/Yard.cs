using System;
using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Housebroken.PickleSteps
{
    /// <summary>
    /// A small proving ground built on the fixture map: six places whose only differences are the
    /// ones Housebroken reads (roof, room, home area), so an animal moved from one to the next
    /// changes nothing but that. The definition of "inside the base" used by the mod is deliberately
    /// not used to build it: walls, roofs and areas are made from the plain game API and the rooms
    /// are asserted afterwards, so a wrong layout fails here instead of passing as a result.
    /// </summary>
    [PickleSteps]
    public sealed class Yard
    {
        public const string ClosedRoom = "closed room";
        public const string Doorway = "doorway";
        public const string UnroofedPen = "unroofed pen";
        public const string RoofedOutside = "roofed room outside home";
        public const string Outdoors = "outdoors";
        public const string EdgeRoom = "edge room";

        private static readonly Dictionary<string, List<IntVec3>> cells = new Dictionary<string, List<IntVec3>>();

        [BeforeScenario]
        public void Forget(PickleContext ctx)
        {
            cells.Clear();
        }

        public static Map Map(PickleContext ctx)
        {
            ctx.Require(Current.Game != null && Find.CurrentMap != null,
                "no current map: load the test-colony fixture before this step");
            return Find.CurrentMap;
        }

        public static bool Built { get { return cells.Count > 0; } }

        public static List<IntVec3> Cells(PickleContext ctx, string place)
        {
            ctx.Require(Built, "the test yard is not built: add the step that builds it first");
            List<IntVec3> list;
            ctx.Require(cells.TryGetValue(place, out list),
                "no yard place named \"" + place + "\"; known: " + string.Join(", ", cells.Keys.ToArray()));
            return list;
        }

        public static IntVec3 Center(PickleContext ctx, string place)
        {
            var list = Cells(ctx, place);
            return list[list.Count / 2];
        }

        [Given("Housebroken builds its test yard")]
        public void Build(PickleContext ctx)
        {
            var map = Map(ctx);
            IntVec3 origin;
            ctx.Require(FindClear(map, 23, 5, false, out origin),
                "no clear 23x5 rectangle of walkable, roofless, unowned ground on this map");
            IntVec3 edgeOrigin;
            ctx.Require(FindClear(map, 4, 5, true, out edgeOrigin),
                "no clear 4x5 rectangle touching the west map edge on this map");

            var cleared = new List<IntVec3>();
            cleared.AddRange(Rect(origin.x, origin.z, 23, 5));
            cleared.AddRange(Rect(edgeOrigin.x, edgeOrigin.z, 4, 5));
            foreach (var c in cleared) Prepare(map, c);

            int ox = origin.x, oz = origin.z;
            // Block 0: closed room, roofed, in the home area, one door in the south wall.
            Ring(map, ox, oz, ox + 4, oz + 4, new IntVec3(ox + 2, 0, oz), true);
            // Block 1: unroofed pen, in the home area, no walls at all.
            OpenArea(map, ox + 6, oz, ox + 10, oz + 4, true);
            // Block 2: roofed room, outside the home area.
            Ring(map, ox + 12, oz, ox + 16, oz + 4, new IntVec3(ox + 14, 0, oz), false);
            // Block 3: open ground, outside the home area.
            OpenArea(map, ox + 18, oz, ox + 22, oz + 4, false);
            // Edge room: its west side is the map edge itself, so no wall is built there.
            Ring(map, edgeOrigin.x - 1, edgeOrigin.z, edgeOrigin.x + 3, edgeOrigin.z + 4, null, true);

            map.regionAndRoomUpdater.RebuildAllRegionsAndRooms();

            cells.Clear();
            cells[ClosedRoom] = Interior(ox + 1, oz + 1, ox + 3, oz + 3);
            cells[Doorway] = new List<IntVec3> { new IntVec3(ox + 2, 0, oz) };
            cells[UnroofedPen] = Interior(ox + 7, oz + 1, ox + 9, oz + 3);
            cells[RoofedOutside] = Interior(ox + 13, oz + 1, ox + 15, oz + 3);
            cells[Outdoors] = Interior(ox + 19, oz + 1, ox + 21, oz + 3);
            cells[EdgeRoom] = Interior(edgeOrigin.x, edgeOrigin.z + 1, edgeOrigin.x + 2, edgeOrigin.z + 3);

            AssertLayout(ctx, map);
        }

        private static void AssertLayout(PickleContext ctx, Map map)
        {
            var closedCell = Center(ctx, ClosedRoom);
            var closed = closedCell.GetRoom(map);
            ctx.Require(closed != null, "the closed room has no room");
            ctx.Assert(closed.ProperRoom && !closed.TouchesMapEdge && !closed.IsDoorway,
                "the closed room is not a proper room away from the map edge");
            ctx.Assert(closedCell.Roofed(map) && map.areaManager.Home[closedCell],
                "the closed room is not roofed and in the home area");

            var doorCell = Center(ctx, Doorway);
            var door = doorCell.GetRoom(map);
            ctx.Require(door != null, "the doorway has no room");
            ctx.Assert(door.IsDoorway, "the door cell is not a doorway room");
            ctx.Assert(doorCell.Roofed(map) && map.areaManager.Home[doorCell],
                "the doorway is not roofed and in the home area");

            var pen = Center(ctx, UnroofedPen);
            ctx.Assert(!pen.Roofed(map) && map.areaManager.Home[pen], "the pen is roofed or outside the home area");

            var outside = Center(ctx, RoofedOutside);
            var outsideRoom = outside.GetRoom(map);
            ctx.Assert(outside.Roofed(map) && !map.areaManager.Home[outside] && outsideRoom != null && outsideRoom.ProperRoom,
                "the roofed room outside the home area is not a roofed proper room outside it");

            var open = Center(ctx, Outdoors);
            ctx.Assert(!open.Roofed(map) && !map.areaManager.Home[open], "the outdoor place is roofed or in the home area");

            var edge = Center(ctx, EdgeRoom);
            var edgeRoom = edge.GetRoom(map);
            ctx.Require(edgeRoom != null, "the edge room has no room");
            ctx.Assert(edge.Roofed(map) && map.areaManager.Home[edge] && edgeRoom.TouchesMapEdge && !edgeRoom.IsDoorway,
                "the edge room is not a roofed home-area room touching the map edge (touches edge: " + edgeRoom.TouchesMapEdge + ")");
        }

        private static IEnumerable<IntVec3> Rect(int x0, int z0, int w, int h)
        {
            for (int x = x0; x < x0 + w; x++)
                for (int z = z0; z < z0 + h; z++)
                    yield return new IntVec3(x, 0, z);
        }

        private static List<IntVec3> Interior(int x0, int z0, int x1, int z1)
        {
            var list = new List<IntVec3>();
            for (int z = z0; z <= z1; z++)
                for (int x = x0; x <= x1; x++)
                    list.Add(new IntVec3(x, 0, z));
            return list;
        }

        private static bool FindClear(Map map, int w, int h, bool atWestEdge, out IntVec3 origin)
        {
            int maxX = map.Size.x - w - 3, maxZ = map.Size.z - h - 3;
            for (int z = 3; z <= maxZ; z += 2)
            {
                if (atWestEdge)
                {
                    if (ClearRect(map, 0, z, w, h)) { origin = new IntVec3(0, 0, z); return true; }
                    continue;
                }
                for (int x = 3; x <= maxX; x += 2)
                    if (ClearRect(map, x, z, w, h)) { origin = new IntVec3(x, 0, z); return true; }
            }
            origin = IntVec3.Invalid;
            return false;
        }

        private static bool ClearRect(Map map, int x0, int z0, int w, int h)
        {
            foreach (var c in Rect(x0, z0, w, h))
            {
                if (!c.InBounds(map) || !c.Standable(map) || c.GetEdifice(map) != null) return false;
                if (c.Roofed(map) || map.areaManager.Home[c]) return false;
                var terrain = c.GetTerrain(map);
                if (terrain.passability == Traversability.Impassable || terrain.IsWater) return false;
            }
            return true;
        }

        /// <summary>Concrete floor (it carries no mud of its own), nothing lying about, no fog, no roof, not home.</summary>
        private static void Prepare(Map map, IntVec3 c)
        {
            foreach (var thing in c.GetThingList(map).ToList())
                if (!(thing is Pawn)) thing.Destroy();
            map.terrainGrid.SetTerrain(c, TerrainDefOf.Concrete);
            map.roofGrid.SetRoof(c, null);
            map.areaManager.Home[c] = false;
            map.fogGrid.Unfog(c);
        }

        private static void Ring(Map map, int x0, int z0, int x1, int z1, IntVec3? door, bool home)
        {
            for (int x = x0; x <= x1; x++)
                for (int z = z0; z <= z1; z++)
                {
                    var c = new IntVec3(x, 0, z);
                    if (!c.InBounds(map)) continue;
                    bool perimeter = x == x0 || x == x1 || z == z0 || z == z1;
                    if (perimeter)
                    {
                        var isDoor = door.HasValue && door.Value == c;
                        var building = ThingMaker.MakeThing(isDoor ? ThingDefOf.Door : ThingDefOf.Wall, ThingDefOf.WoodLog);
                        building.SetFaction(Faction.OfPlayer);
                        GenSpawn.Spawn(building, c, map, WipeMode.Vanish);
                    }
                    map.roofGrid.SetRoof(c, RoofDefOf.RoofConstructed);
                    map.areaManager.Home[c] = home;
                }
        }

        private static void OpenArea(Map map, int x0, int z0, int x1, int z1, bool home)
        {
            for (int x = x0; x <= x1; x++)
                for (int z = z0; z <= z1; z++)
                    map.areaManager.Home[new IntVec3(x, 0, z)] = home;
        }
    }
}
