using HarmonyLib;
using RimWorld;
using Verse;

namespace Housebroken
{
    /// <summary>
    /// A clean animal does not drop the mud it picked up inside the base: it keeps it on its
    /// feet and wipes them once out. This is the exact counterpart of the manure rule, on the
    /// other code path.
    ///
    /// The StatPart can do nothing here: <c>Notify_EnteredNewCell</c> calls
    /// <c>TryDropFilth</c> against a fixed constant (0.05 per cell walked into), with no link
    /// to the FilthRate stat. Only a patch reaches this half of the problem.
    ///
    /// Carried filth is already serialised by <c>Pawn_FilthTracker.ExposeData</c>: holding it
    /// back still adds nothing to the save.
    /// </summary>
    [HarmonyPatch(typeof(Pawn_FilthTracker), "TryDropFilth")]
    public static class Patch_TryDropFilth
    {
        public static bool Prefix(Pawn_FilthTracker __instance)
        {
            var settings = HousebrokenMod.Settings;
            if (settings == null || !settings.wipeFeetIndoors) return true;

            var pawn = __instance.pawn;
            if (!Cleanliness.AppliesTo(pawn)) return true;
            if (Cleanliness.TraitFactor(pawn) >= 1f) return true;

            // Outside, the held mud drops as usual.
            return !Cleanliness.IsInsideBase(pawn);
        }
    }
}
