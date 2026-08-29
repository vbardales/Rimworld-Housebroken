using HarmonyLib;
using UnityEngine;
using Verse;

namespace Housebroken
{
    public class HousebrokenMod : Mod
    {
        public const string HarmonyId = "nelim.housebroken";

        public static HousebrokenMod Instance { get; private set; }
        public static HousebrokenSettings Settings { get; private set; }
        public static Harmony HarmonyInstance { get; private set; }

        private Vector2 scrollPosition;
        private float viewHeight;

        public HousebrokenMod(ModContentPack content) : base(content)
        {
            Instance = this;
            Settings = GetSettings<HousebrokenSettings>();

            HarmonyInstance = new Harmony(HarmonyId);
            HarmonyInstance.PatchAll();
        }

        public override string SettingsCategory() => "Housebroken";

        public override void WriteSettings()
        {
            base.WriteSettings();
            Cleanliness.ClearCache();
        }

        public override void DoSettingsWindowContents(Rect inRect)
        {
            var settings = Settings;
            var viewRect = new Rect(0f, 0f, inRect.width - 20f, Mathf.Max(viewHeight, inRect.height));

            Widgets.BeginScrollView(inRect, ref scrollPosition, viewRect);
            var listing = new Listing_Standard();
            listing.Begin(viewRect);

            listing.Label("Housebroken.Settings.Intro".Translate());
            listing.GapLine();

            listing.Label("Housebroken.Settings.TrainingHeader".Translate());
            settings.obedientFactor = ReductionRow(listing,
                "Housebroken.Settings.Obedient", settings.obedientFactor,
                "Housebroken.Settings.ObedientTip");
            settings.wellTrainedFactor = ReductionRow(listing,
                "Housebroken.Settings.WellTrained", settings.wellTrainedFactor,
                "Housebroken.Settings.WellTrainedTip");

            listing.Gap();
            listing.Label("Housebroken.Settings.SpeciesHeader".Translate());
            settings.intermediateSpeciesFactor = ReductionRow(listing,
                "Housebroken.Settings.Intermediate", settings.intermediateSpeciesFactor);
            settings.advancedSpeciesFactor = ReductionRow(listing,
                "Housebroken.Settings.Advanced", settings.advancedSpeciesFactor,
                "Housebroken.Settings.AdvancedTip");

            listing.Gap();
            listing.CheckboxLabeled("Housebroken.Settings.ColonyOnly".Translate(),
                ref settings.colonyAnimalsOnly, "Housebroken.Settings.ColonyOnlyTip".Translate());

            listing.GapLine();

            listing.CheckboxLabeled("Housebroken.Settings.ManureOutdoors".Translate(),
                ref settings.manureOutdoors, "Housebroken.Settings.ManureOutdoorsTip".Translate());

            if (settings.manureOutdoors)
            {
                listing.CheckboxLabeled("Housebroken.Settings.WholeHomeArea".Translate(),
                    ref settings.wholeHomeArea, "Housebroken.Settings.WholeHomeAreaTip".Translate());
                settings.indoorFactor = ReductionRow(listing,
                    "Housebroken.Settings.Indoor", settings.indoorFactor,
                    "Housebroken.Settings.IndoorTip");
                settings.outdoorFactor = MultiplierRow(listing,
                    "Housebroken.Settings.Outdoor", settings.outdoorFactor,
                    "Housebroken.Settings.OutdoorTip");
            }

            listing.GapLine();

            listing.CheckboxLabeled("Housebroken.Settings.ExemptAlert".Translate(),
                ref settings.exemptFromAlert, "Housebroken.Settings.ExemptAlertTip".Translate());

            listing.Gap();
            if (listing.ButtonText("Housebroken.Settings.Reset".Translate()))
            {
                Find.WindowStack.Add(Dialog_MessageBox.CreateConfirmation(
                    "Housebroken.Settings.ConfirmReset".Translate(),
                    settings.Reset,
                    destructive: true));
            }

            viewHeight = listing.CurHeight + 12f;
            listing.End();
            Widgets.EndScrollView();
        }

        /// <summary>Curseur exprime en pourcentage de reduction, stocke en facteur multiplicatif.</summary>
        private static float ReductionRow(Listing_Standard listing, string key, float factor, string tooltipKey = null)
        {
            int reduction = Mathf.RoundToInt((1f - factor) * 100f);
            string label = key.Translate(reduction);
            string tooltip = tooltipKey == null ? null : (string)tooltipKey.Translate();
            float updated = listing.SliderLabeled(label, reduction, 0f, 100f, 0.62f, tooltip);
            return Mathf.Clamp01(1f - Mathf.Round(updated) / 100f);
        }

        private static float MultiplierRow(Listing_Standard listing, string key, float factor, string tooltipKey = null)
        {
            int percent = Mathf.RoundToInt(factor * 100f);
            string label = key.Translate(percent);
            string tooltip = tooltipKey == null ? null : (string)tooltipKey.Translate();
            float updated = listing.SliderLabeled(label, percent, 100f, 400f, 0.62f, tooltip);
            return Mathf.Clamp(Mathf.Round(updated) / 100f, 1f, 4f);
        }
    }
}
