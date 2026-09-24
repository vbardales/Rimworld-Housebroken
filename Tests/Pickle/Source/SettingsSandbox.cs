using System.Collections.Generic;
using System.IO;
using System.Reflection;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Housebroken.PickleSteps
{
    /// <summary>
    /// Keeps the settings file and the settings object as a scenario found them, except for a restart
    /// chain: the writer keeps them on purpose (a marker file says so), and the reader in the next
    /// process finds the marker, does not snapshot, and puts the original file back at its end.
    /// The state is static because the writer and its cleanup are separate scenarios of one process.
    /// </summary>
    [PickleSteps]
    public sealed class SettingsSandbox
    {
        private static Dictionary<string, object> snapshot;
        private static bool? shortcutWasVisible;
        private static string path;
        private static string backup;
        private static string marker;
        private static bool keepForNextLaunch;
        private static bool chainReader;

        private static FieldInfo[] Fields
        {
            get { return typeof(HousebrokenSettings).GetFields(BindingFlags.Public | BindingFlags.Instance); }
        }

        private static bool Loaded
        {
            get { return LoadedModManager.GetMod<HousebrokenMod>() != null && HousebrokenMod.Settings != null; }
        }

        [BeforeScenario]
        public void Before(PickleContext ctx)
        {
            if (!Loaded) return;
            path = HousebrokenSteps.SettingsPath(ctx);
            backup = path + ".pickle-backup";
            marker = path + ".pickle-chain";
            keepForNextLaunch = false;
            chainReader = File.Exists(marker);
            var shortcut = DefDatabase<MainButtonDef>.GetNamedSilentFail("Housebroken_Settings");
            shortcutWasVisible = shortcut == null ? (bool?)null : shortcut.buttonVisible;
            if (chainReader) return;
            if (File.Exists(backup)) { File.Copy(backup, path, true); File.Delete(backup); }
            if (File.Exists(path)) File.Copy(path, backup, true);
            snapshot = new Dictionary<string, object>();
            foreach (var field in Fields) snapshot[field.Name] = field.GetValue(HousebrokenMod.Settings);
        }

        [AfterScenario]
        public void After(PickleContext ctx)
        {
            if (!Loaded) return;
            var shortcut = DefDatabase<MainButtonDef>.GetNamedSilentFail("Housebroken_Settings");
            if (shortcut != null && shortcutWasVisible.HasValue) shortcut.buttonVisible = shortcutWasVisible.Value;
            Cleanliness.ClearCache();
            if (keepForNextLaunch) return;
            if (snapshot != null)
            {
                foreach (var field in Fields) field.SetValue(HousebrokenMod.Settings, snapshot[field.Name]);
                snapshot = null;
            }
            if (File.Exists(backup)) { File.Copy(backup, path, true); File.Delete(backup); }
            else if (File.Exists(path)) File.Delete(path);
            if (File.Exists(marker)) File.Delete(marker);
            chainReader = false;
        }

        public static void KeepForNextLaunch(PickleContext ctx)
        {
            ctx.Require(!string.IsNullOrEmpty(marker), "the settings sandbox has no marker path");
            File.WriteAllText(marker, "Housebroken Pickle restart chain");
            keepForNextLaunch = true;
        }
    }
}
