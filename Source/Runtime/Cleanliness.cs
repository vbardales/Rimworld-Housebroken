using System.Collections.Generic;
using RimWorld;
using Verse;

namespace Housebroken
{
    /// <summary>
    /// Calcule a quel point un animal est propre. Deux facteurs multiplicatifs :
    /// son dressage individuel, et la trainabilite de son espece (que le catalyseur
    /// de sentience fait monter d'un cran - <see cref="TrainableUtility.GetTrainability"/>).
    /// </summary>
    public static class Cleanliness
    {
        private struct Cached
        {
            public int tick;
            public float factor;
        }

        // Le StatPart est interroge a chaque case franchie par chaque pion : on met
        // en cache la partie qui ne depend pas de la position.
        private const int StaleTicks = 250;
        private const int ClearTicks = 60000;

        private static readonly Dictionary<int, Cached> cache = new Dictionary<int, Cached>();
        private static int lastClearTick;

        private static HousebrokenSettings Settings => HousebrokenMod.Settings;

        /// <summary>Appele quand les reglages changent, pour ne pas garder de facteur perime.</summary>
        public static void ClearCache()
        {
            cache.Clear();
        }

        public static bool AppliesTo(Pawn pawn)
        {
            if (pawn == null || pawn.def == null || pawn.RaceProps == null) return false;
            if (!pawn.RaceProps.Animal) return false;
            var settings = Settings;
            if (settings == null) return false;
            if (settings.colonyAnimalsOnly && pawn.Faction != Faction.OfPlayer) return false;
            return true;
        }

        /// <summary>Facteur du au dressage et a l'intelligence, hors regle du fumier dehors.</summary>
        public static float TraitFactor(Pawn pawn)
        {
            var tickManager = Find.TickManager;
            if (tickManager == null) return ComputeTraitFactor(pawn);

            int tick = tickManager.TicksGame;
            if (tick - lastClearTick > ClearTicks)
            {
                cache.Clear();
                lastClearTick = tick;
            }

            int id = pawn.thingIDNumber;
            if (cache.TryGetValue(id, out var cached) && tick - cached.tick < StaleTicks)
            {
                return cached.factor;
            }

            float factor = ComputeTraitFactor(pawn);
            cache[id] = new Cached { tick = tick, factor = factor };
            return factor;
        }

        /// <summary>Facteur complet applique au taux de salete, position comprise.</summary>
        public static float TotalFactor(Pawn pawn)
        {
            return TraitFactor(pawn) * PlaceFactor(pawn);
        }

        /// <summary>
        /// Regle du fumier dehors : un animal deja rendu propre par son dressage ou son
        /// espece se retient dans la base, et se soulage une fois sorti.
        /// </summary>
        public static float PlaceFactor(Pawn pawn)
        {
            var settings = Settings;
            if (settings == null || !settings.manureOutdoors) return 1f;
            if (TraitFactor(pawn) >= 1f) return 1f;
            return IsInsideBase(pawn) ? settings.indoorFactor : settings.outdoorFactor;
        }

        /// <summary>La regle du fumier dehors est-elle active pour cet animal ?</summary>
        public static bool PlaceRuleApplies(Pawn pawn)
        {
            var settings = Settings;
            return settings != null && settings.manureOutdoors && TraitFactor(pawn) < 1f;
        }

        public static bool IsInsideBase(Pawn pawn)
        {
            if (pawn == null || !pawn.Spawned) return false;
            var map = pawn.Map;
            if (map == null) return false;

            var cell = pawn.Position;
            if (!cell.InBounds(map)) return false;
            if (map.areaManager == null || !map.areaManager.Home[cell]) return false;
            if (Settings?.wholeHomeArea ?? false) return true;

            if (cell.GetRoof(map) == null) return false;
            var room = cell.GetRoom(map);
            return room != null && !room.TouchesMapEdge && !room.IsDoorway;
        }

        private static float ComputeTraitFactor(Pawn pawn)
        {
            var settings = Settings;
            if (settings == null) return 1f;
            return TrainingFactor(pawn, settings) * SpeciesFactor(pawn, settings);
        }

        private static float TrainingFactor(Pawn pawn, HousebrokenSettings settings)
        {
            var training = pawn.training;
            if (training == null) return 1f;
            if (!training.HasLearned(TrainableDefOf.Tameness)) return 1f;

            bool obedient = training.HasLearned(TrainableDefOf.Obedience);
            int extras = 0;
            var all = DefDatabase<TrainableDef>.AllDefsListForReading;
            for (int i = 0; i < all.Count; i++)
            {
                var def = all[i];
                if (def == TrainableDefOf.Tameness || def == TrainableDefOf.Obedience) continue;
                if (training.HasLearned(def)) extras++;
            }

            if (!obedient) return extras > 0 ? settings.obedientFactor : 1f;
            return extras > 0 ? settings.wellTrainedFactor : settings.obedientFactor;
        }

        private static float SpeciesFactor(Pawn pawn, HousebrokenSettings settings)
        {
            var trainability = TrainableUtility.GetTrainability(pawn);
            int order = trainability?.intelligenceOrder ?? 0;
            // Vanille : Aucune = 0, Intermediaire = 20, Avancee = 30. Les seuils
            // laissent de la place aux paliers ajoutes par d'autres mods.
            if (order >= 25) return settings.advancedSpeciesFactor;
            if (order >= 10) return settings.intermediateSpeciesFactor;
            return 1f;
        }
    }
}
