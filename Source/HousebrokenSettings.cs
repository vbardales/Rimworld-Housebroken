using Verse;

namespace Housebroken
{
    public class HousebrokenSettings : ModSettings
    {
        // Facteurs multiplicatifs appliques au taux de salete. 1 = aucun changement.
        public float obedientFactor = 0.5f;
        public float wellTrainedFactor = 0.25f;
        public float intermediateSpeciesFactor = 0.8f;
        public float advancedSpeciesFactor = 0.6f;
        public bool colonyAnimalsOnly = true;

        // Fumier dehors.
        public bool manureOutdoors = true;
        public bool wholeHomeArea;
        public float indoorFactor;
        public float outdoorFactor = 1f;

        public bool exemptFromAlert = true;

        public void Reset()
        {
            obedientFactor = 0.5f;
            wellTrainedFactor = 0.25f;
            intermediateSpeciesFactor = 0.8f;
            advancedSpeciesFactor = 0.6f;
            colonyAnimalsOnly = true;
            manureOutdoors = true;
            wholeHomeArea = false;
            indoorFactor = 0f;
            outdoorFactor = 1f;
            exemptFromAlert = true;
        }

        public override void ExposeData()
        {
            base.ExposeData();
            Scribe_Values.Look(ref obedientFactor, "obedientFactor", 0.5f);
            Scribe_Values.Look(ref wellTrainedFactor, "wellTrainedFactor", 0.25f);
            Scribe_Values.Look(ref intermediateSpeciesFactor, "intermediateSpeciesFactor", 0.8f);
            Scribe_Values.Look(ref advancedSpeciesFactor, "advancedSpeciesFactor", 0.6f);
            Scribe_Values.Look(ref colonyAnimalsOnly, "colonyAnimalsOnly", true);
            Scribe_Values.Look(ref manureOutdoors, "manureOutdoors", true);
            Scribe_Values.Look(ref wholeHomeArea, "wholeHomeArea", false);
            Scribe_Values.Look(ref indoorFactor, "indoorFactor", 0f);
            Scribe_Values.Look(ref outdoorFactor, "outdoorFactor", 1f);
            Scribe_Values.Look(ref exemptFromAlert, "exemptFromAlert", true);
        }
    }
}
