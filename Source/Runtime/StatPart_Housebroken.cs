using System.Text;
using RimWorld;
using Verse;

namespace Housebroken
{
    /// <summary>
    /// Grafted onto the FilthRate stat (see Patches/FilthRate.xml). Everything goes through
    /// it: <c>Pawn_FilthTracker.Notify_EnteredNewCell</c> rolls filth against
    /// <c>GetStatValue(FilthRate) * 0.005</c>, and <c>Alert_AnimalFilth</c> compares that
    /// same stat to 4.
    /// </summary>
    public class StatPart_Housebroken : StatPart
    {
        public override void TransformValue(StatRequest req, ref float val)
        {
            if (!(req.Thing is Pawn pawn) || !Cleanliness.AppliesTo(pawn)) return;
            val *= Cleanliness.TotalFactor(pawn);
        }

        public override string ExplanationPart(StatRequest req)
        {
            if (!(req.Thing is Pawn pawn) || !Cleanliness.AppliesTo(pawn)) return null;

            float trait = Cleanliness.TraitFactor(pawn);
            if (trait >= 1f) return null;

            var text = new StringBuilder();
            text.AppendLine("Housebroken.Stat.Trained".Translate(
                trait.ToStringByStyle(ToStringStyle.PercentZero, ToStringNumberSense.Factor)));

            if (Cleanliness.PlaceRuleApplies(pawn))
            {
                float place = Cleanliness.PlaceFactor(pawn);
                string key = Cleanliness.IsInsideBase(pawn)
                    ? "Housebroken.Stat.HoldingIt"
                    : "Housebroken.Stat.Outside";
                text.AppendLine(key.Translate(
                    place.ToStringByStyle(ToStringStyle.PercentZero, ToStringNumberSense.Factor)));
            }

            return text.ToString().TrimEndNewlines();
        }

        public override bool ForceShow(StatRequest req)
        {
            return req.Thing is Pawn pawn && Cleanliness.AppliesTo(pawn)
                && Cleanliness.TraitFactor(pawn) < 1f;
        }
    }
}
