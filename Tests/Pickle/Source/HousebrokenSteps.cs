using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Housebroken.PickleSteps
{
    [PickleSteps]
    public sealed class HousebrokenSteps
    {
        private const string ShortcutDef = "Housebroken_Settings";
        private const BindingFlags AnyInstance = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;

        private static HousebrokenMod Mod(PickleContext ctx)
        {
            var mod = LoadedModManager.GetMod<HousebrokenMod>();
            ctx.Require(mod != null, "HousebrokenMod is not loaded");
            ctx.Require(HousebrokenMod.Settings != null, "Housebroken settings are null");
            return mod;
        }

        private static MainButtonDef Shortcut(PickleContext ctx)
        {
            var def = DefDatabase<MainButtonDef>.GetNamedSilentFail(ShortcutDef);
            ctx.Require(def != null, "Housebroken_Settings MainButtonDef is not loaded");
            return def;
        }

        [Given("Housebroken settings are at their documented defaults")]
        public void Reset(PickleContext ctx) => HousebrokenMod.Settings.Reset();

        [When("I open the Housebroken settings dialog")]
        public async Task OpenDialog(PickleContext ctx)
        {
            Find.WindowStack.Add(new Dialog_ModSettings(Mod(ctx)));
            await ctx.WaitFrames(3);
        }

        [Then("Housebroken sees its settings dialog open")]
        public void AssertDialog(PickleContext ctx)
        {
            var mine = Mod(ctx);
            var dialogs = Find.WindowStack.Windows.OfType<Dialog_ModSettings>().ToArray();
            ctx.Assert(dialogs.Any(dialog => dialog.GetType().GetFields(AnyInstance)
                .Where(field => typeof(Mod).IsAssignableFrom(field.FieldType))
                .Select(field => field.GetValue(dialog)).OfType<Mod>().Any(value => value == mine)),
                "no Dialog_ModSettings belongs to Housebroken");
        }

        [When("Housebroken setting {string} is set to {string}")]
        public void Set(PickleContext ctx, string name, string value)
        {
            var field = typeof(HousebrokenSettings).GetField(name, BindingFlags.Public | BindingFlags.Instance);
            ctx.Require(field != null, "HousebrokenSettings has no public field '" + name + "'");
            field.SetValue(HousebrokenMod.Settings, Convert.ChangeType(value, field.FieldType, CultureInfo.InvariantCulture));
        }

        [Then("Housebroken setting {string} reads {string}")]
        public void AssertValue(PickleContext ctx, string name, string expected)
        {
            var field = typeof(HousebrokenSettings).GetField(name, BindingFlags.Public | BindingFlags.Instance);
            ctx.Require(field != null, "HousebrokenSettings has no public field '" + name + "'");
            var actual = Convert.ToString(field.GetValue(HousebrokenMod.Settings), CultureInfo.InvariantCulture);
            ctx.Assert(actual == expected, "HousebrokenSettings." + name + " is '" + actual + "', expected '" + expected + "'");
        }

        [When("Housebroken settings are written to disk")]
        public void Write(PickleContext ctx)
        {
            var mod = Mod(ctx);
            mod.WriteSettings();
            var path = SettingsPath(ctx);
            ctx.Require(File.Exists(path), "WriteSettings created no file at " + path);
        }

        internal static string SettingsPath(PickleContext ctx)
        {
            var mod = Mod(ctx);
            var method = typeof(LoadedModManager).GetMethod("GetSettingsFilename",
                BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
            ctx.Require(method != null, "LoadedModManager.GetSettingsFilename is unavailable in this game version");
            return (string)method.Invoke(null, new object[] { mod.Content.FolderName, mod.GetType().Name });
        }

        [Then("Housebroken shortcut is hidden and not greyed on a clean configuration")]
        public void AssertHidden(PickleContext ctx)
        {
            var shortcut = Shortcut(ctx);
            ctx.Assert(!shortcut.buttonVisible && !shortcut.Worker.Visible,
                "Housebroken shortcut is visible on a clean configuration");
            ctx.Assert(!shortcut.Worker.Disabled, "Housebroken shortcut is greyed out");
        }

        [When("Housebroken reveals its shortcut as a customization mod would")]
        public void Reveal(PickleContext ctx) => Shortcut(ctx).buttonVisible = true;

        [When("Housebroken hides its shortcut again")]
        public void Hide(PickleContext ctx) => Shortcut(ctx).buttonVisible = false;

        [Then("Housebroken shortcut is drawn and live")]
        public void AssertDrawn(PickleContext ctx)
        {
            var shortcut = Shortcut(ctx);
            ctx.Assert(shortcut.Worker.Visible, "revealed Housebroken shortcut is not drawn");
            ctx.Assert(!shortcut.Worker.Disabled, "revealed Housebroken shortcut is greyed out");
        }

        [Then("Housebroken shortcut is not drawn")]
        public void AssertNotDrawn(PickleContext ctx) => ctx.Assert(!Shortcut(ctx).Worker.Visible, "hidden Housebroken shortcut is drawn");

        [When("Housebroken activates its shortcut")]
        public void Activate(PickleContext ctx) => Shortcut(ctx).Worker.Activate();
    }
}
