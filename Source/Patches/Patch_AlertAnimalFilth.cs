using HarmonyLib;
using RimWorld;
using Verse;

namespace Housebroken
{
    /// <summary>
    /// Takes the animals this mod has made cleaner out of the "animal filth" alert.
    /// <c>Alert_AnimalFilth.CalculateTargets</c> fills two parallel lists; they are
    /// filtered by the same index.
    /// </summary>
    [HarmonyPatch(typeof(Alert_AnimalFilth), "CalculateTargets")]
    public static class Patch_AlertAnimalFilth
    {
        public static void Postfix(Alert_AnimalFilth __instance)
        {
            var settings = HousebrokenMod.Settings;
            if (settings == null || !settings.exemptFromAlert) return;

            var targets = __instance.targets;
            var entries = __instance.pawnEntries;
            if (targets == null) return;

            for (int i = targets.Count - 1; i >= 0; i--)
            {
                if (!(targets[i].Thing is Pawn pawn)) continue;
                if (!Cleanliness.AppliesTo(pawn) || Cleanliness.TraitFactor(pawn) >= 1f) continue;

                targets.RemoveAt(i);
                if (entries != null && i < entries.Count) entries.RemoveAt(i);
            }
        }
    }
}
