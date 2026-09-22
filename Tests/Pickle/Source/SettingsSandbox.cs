using System.Collections.Generic;
using System.IO;
using System.Reflection;
using RimWorks.Pickle;
using Verse;

namespace Housebroken.PickleSteps
{
    [PickleSteps]
    public sealed class SettingsSandbox
    {
        private Dictionary<string, object> snapshot;
        private string path;
        private string backup;

        [BeforeScenario]
        public void Before(PickleContext ctx)
        {
            if (LoadedModManager.GetMod<HousebrokenMod>() == null || HousebrokenMod.Settings == null) return;
            path = HousebrokenSteps.SettingsPath(ctx);
            backup = path + ".pickle-backup";
            if (File.Exists(backup)) { File.Copy(backup, path, true); File.Delete(backup); }
            if (File.Exists(path)) File.Copy(path, backup, true);
            snapshot = new Dictionary<string, object>();
            foreach (var field in typeof(HousebrokenSettings).GetFields(BindingFlags.Public | BindingFlags.Instance))
                snapshot[field.Name] = field.GetValue(HousebrokenMod.Settings);
        }

        [AfterScenario]
        public void After(PickleContext ctx)
        {
            if (snapshot == null) return;
            foreach (var field in typeof(HousebrokenSettings).GetFields(BindingFlags.Public | BindingFlags.Instance))
                field.SetValue(HousebrokenMod.Settings, snapshot[field.Name]);
            snapshot = null;
            if (File.Exists(backup)) { File.Copy(backup, path, true); File.Delete(backup); }
            else if (File.Exists(path)) File.Delete(path);
        }
    }
}
