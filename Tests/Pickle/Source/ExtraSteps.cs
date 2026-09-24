using System.Linq;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using System.Xml;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Housebroken.PickleSteps
{
    [PickleSteps]
    public sealed class ExtraSteps
    {
        private static readonly Dictionary<string, int> recordedIds = new Dictionary<string, int>();

        [BeforeScenario]
        public void Forget(PickleContext ctx) { recordedIds.Clear(); }

        [When("Housebroken keeps its settings for the next launch")]
        public void Keep(PickleContext ctx) { SettingsSandbox.KeepForNextLaunch(ctx); }

        [When("Housebroken lets {int} frames pass", TimeoutSeconds = 30f)]
        public async Task Frames(PickleContext ctx, int frames) { await ctx.WaitFrames(frames); }

        [When("Housebroken records the thing ID of {string}")]
        public void Record(PickleContext ctx, string name)
        {
            recordedIds[name] = AnimalSteps.Named(ctx, name).thingIDNumber;
        }

        // A second game starts numbering from its own state, so an animal of the next game can end
        // up with the number an animal of the previous one had. The cleanliness cache is keyed by
        // that number; this step makes the collision on purpose instead of hoping for it.
        [When("Housebroken gives {string} the thing ID recorded for {string}")]
        public void Reuse(PickleContext ctx, string name, string source)
        {
            int id;
            ctx.Require(recordedIds.TryGetValue(source, out id), "no thing ID was recorded for " + source);
            AnimalSteps.Named(ctx, name).thingIDNumber = id;
        }

        [When("Housebroken saves the game as {string}")]
        public void Save(PickleContext ctx, string file)
        {
            GameDataSaveLoader.SaveGame(file);
            ctx.Require(File.Exists(GenFilePaths.FilePathForSavedGame(file)), "no save file was written for " + file);
        }

        // The mod claims to add nothing to a save. The header lists every active mod by name, so it is
        // set aside; anything else that names Housebroken, as an element, an attribute or a class, is data.
        [Then("Housebroken save {string} holds no Housebroken data outside its mod list")]
        public void NoData(PickleContext ctx, string file)
        {
            var doc = new XmlDocument();
            doc.Load(GenFilePaths.FilePathForSavedGame(file));
            var meta = doc.DocumentElement.SelectSingleNode("meta");
            ctx.Require(meta != null, "the save has no meta header, so the mod list cannot be set aside");
            doc.DocumentElement.RemoveChild(meta);
            var text = doc.OuterXml;
            var at = text.IndexOf("Housebroken", System.StringComparison.OrdinalIgnoreCase);
            ctx.Assert(at < 0, "the save holds Housebroken data outside its header, near: "
                + (at < 0 ? "" : text.Substring(System.Math.Max(0, at - 60), System.Math.Min(160, text.Length - System.Math.Max(0, at - 60)))));
        }

        // Pickle finds a saved game as a fixture: a .rws in the Pickle/Fixtures folder of an active mod.
        // A game saved in this launch is handed to the mod that the next launch will load it with.
        [When("Housebroken hands the saved game {string} to the mod {string}")]
        public void Hand(PickleContext ctx, string file, string packageId)
        {
            var target = LoadedModManager.RunningModsListForReading.FirstOrDefault(m =>
                m.PackageIdPlayerFacing.ToLowerInvariant() == packageId.ToLowerInvariant());
            ctx.Require(target != null, "no active mod has the packageId " + packageId);
            var folder = Path.Combine(target.RootDir, "Pickle", "Fixtures");
            Directory.CreateDirectory(folder);
            var destination = Path.Combine(folder, file + ".rws");
            File.Copy(GenFilePaths.FilePathForSavedGame(file), destination, true);
            ctx.Require(File.Exists(destination), "the saved game was not copied to " + destination);
        }
    }
}
