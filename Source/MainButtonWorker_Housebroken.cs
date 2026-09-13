using RimWorld;
using Verse;

namespace Housebroken
{
    // Inherit native visibility so customization mods can reveal this optional shortcut.
    public class MainButtonWorker_Housebroken : MainButtonWorker
    {
        public override void Activate()
        {
            if (HousebrokenMod.Instance != null)
                Find.WindowStack.Add(new Dialog_ModSettings(HousebrokenMod.Instance));
        }
    }
}
