using Verse;

namespace Housebroken
{
    public class HousebrokenSettings : ModSettings
    {
        // Multiplicative factors applied to the filth rate. 1 = no change.
        public float obedientFactor = 0.5f;
        public float wellTrainedFactor = 0.25f;
        public float intermediateSpeciesFactor = 0.8f;
        public float advancedSpeciesFactor = 0.6f;
        public bool colonyAnimalsOnly = true;

        // Manure outdoors.
        public bool manureOutdoors = true;
        public bool wholeHomeArea;
        public float indoorFactor;
        public float outdoorFactor = 2f;

        public bool wipeFeetIndoors = true;

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
            outdoorFactor = 2f;
            wipeFeetIndoors = true;
            exemptFromAlert = true;
        }

        // Old or externally edited settings must not produce negative or non-finite rates.
        public void Normalize()
        {
            obedientFactor = Bounded(obedientFactor, 0f, 1f, 0.5f);
            wellTrainedFactor = Bounded(wellTrainedFactor, 0f, 1f, 0.25f);
            intermediateSpeciesFactor = Bounded(intermediateSpeciesFactor, 0f, 1f, 0.8f);
            advancedSpeciesFactor = Bounded(advancedSpeciesFactor, 0f, 1f, 0.6f);
            indoorFactor = Bounded(indoorFactor, 0f, 1f, 0f);
            outdoorFactor = Bounded(outdoorFactor, 1f, 4f, 2f);
        }

        private static float Bounded(float value, float min, float max, float fallback)
        {
            if (float.IsNaN(value) || float.IsInfinity(value)) return fallback;
            return System.Math.Max(min, System.Math.Min(max, value));
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
            Scribe_Values.Look(ref outdoorFactor, "outdoorFactor", 2f);
            Scribe_Values.Look(ref wipeFeetIndoors, "wipeFeetIndoors", true);
            Scribe_Values.Look(ref exemptFromAlert, "exemptFromAlert", true);
            Normalize();
        }
    }
}
