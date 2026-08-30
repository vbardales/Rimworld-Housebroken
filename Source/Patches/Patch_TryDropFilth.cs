using HarmonyLib;
using RimWorld;
using Verse;

namespace Housebroken
{
    /// <summary>
    /// Un animal propre ne depose pas dans la base la boue qu'il a ramassee : il la garde
    /// sur ses pattes et l'essuie une fois dehors. C'est le pendant exact de la regle du
    /// fumier, mais sur l'autre chemin de code.
    ///
    /// Le StatPart ne peut rien ici : <c>Notify_EnteredNewCell</c> appelle
    /// <c>TryDropFilth</c> sur une constante fixe (0,05 par case franchie), sans aucun
    /// lien avec le stat FilthRate. Seul un patch atteint cette moitie du probleme.
    ///
    /// La salete transportee est deja serialisee par <c>Pawn_FilthTracker.ExposeData</c> :
    /// la retenir n'ajoute toujours rien a la sauvegarde.
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

            // Dehors, la boue retenue tombe normalement.
            return !Cleanliness.IsInsideBase(pawn);
        }
    }
}
