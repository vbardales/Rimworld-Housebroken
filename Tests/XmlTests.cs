using System.Xml.Linq;
using System.Xml.XPath;
using System.Text.RegularExpressions;

internal static class XmlTests
{
    static string Root
    {
        get
        {
            var dir = new DirectoryInfo(AppContext.BaseDirectory);
            while (dir != null && !File.Exists(Path.Combine(dir.FullName, "Mod", "About", "About.xml"))) dir = dir.Parent;
            return dir?.FullName ?? throw new Exception("Repository root not found");
        }
    }
    static XDocument Load(string path) => XDocument.Load(Path.Combine(Root, path));
    static void Require(bool condition, string message) { if (!condition) throw new Exception(message); }

    public static void Register(Action<string, Action> test)
    {
        test("XML: hidden settings shortcut and French injection paths", () => {
            var def = Load("Mod/Defs/MainButtonDefs/Housebroken.xml").Root.Element("MainButtonDef");
            Require((string)def.Element("defName") == "Housebroken_Settings", "Shortcut ID changed");
            Require((string)def.Element("buttonVisible") == "false", "Shortcut must be hidden, not disabled");
            Require((string)def.Element("workerClass") == typeof(Housebroken.MainButtonWorker_Housebroken).FullName, "Shortcut worker mismatch");
            Require((string)def.Element("validWithoutMap") == "true", "Settings should work without a map");
            var fr = Load("Mod/Languages/French/DefInjected/MainButtonDef/Housebroken.xml").Root;
            foreach(var field in new[]{"label","description"}) {
                Require(!string.IsNullOrWhiteSpace((string)def.Element(field)), "Missing English source: "+field);
                Require(!string.IsNullOrWhiteSpace((string)fr.Element("Housebroken_Settings."+field)), "Missing French injection: "+field);
            }
            Require(fr.Elements().Count()==2,"Unexpected injection paths");
        });
        test("XML: every shipped XML document parses", () => {
            foreach (var file in Directory.GetFiles(Path.Combine(Root,"Mod"),"*.xml",SearchOption.AllDirectories)) XDocument.Load(file);
        });
        foreach (bool existing in new[] { false, true })
            test($"XML: FilthRate patch contract, existing parts={existing}", () => {
                var defs = XDocument.Parse(existing
                    ? "<Defs><StatDef><defName>FilthRate</defName><parts><li Class='Other.StatPart'/></parts></StatDef><StatDef><defName>Other</defName><parts/></StatDef></Defs>"
                    : "<Defs><StatDef><defName>FilthRate</defName></StatDef><StatDef><defName>Other</defName><parts/></StatDef></Defs>");
                var untouched = defs.XPathSelectElement("/Defs/StatDef[defName='Other']").ToString();
                var operations = Load("Mod/Patches/FilthRate.xml").Root.Elements("Operation").ToArray();
                Require(operations.Length == 1, "Expected one conditional operation");
                var operation = operations[0];
                Require((string)operation.Attribute("Class") == "PatchOperationConditional", "Unexpected operation type");
                var matches = defs.XPathSelectElements((string)operation.Element("xpath")).Any();
                Require(matches == existing, "Conditional XPath chose wrong branch");
                var branch = operation.Element(matches ? "match" : "nomatch");
                Require((string)branch.Attribute("Class") == "PatchOperationAdd", "Unexpected branch type");
                // Contract check using .NET XPath and append semantics, not RimWorld's patch engine.
                var targets = defs.XPathSelectElements((string)branch.Element("xpath")).ToArray();
                Require(targets.Length == 1, "Patch must target exactly the FilthRate node");
                foreach (var target in targets) foreach (var child in branch.Element("value").Elements()) target.Add(new XElement(child));
                var parts = defs.XPathSelectElements("/Defs/StatDef[defName='FilthRate']/parts").ToArray();
                Require(parts.Length == 1, "Expected one parts node");
                Require(parts[0].Elements("li").Count(x => (string)x.Attribute("Class") == typeof(Housebroken.StatPart_Housebroken).FullName) == 1, "Missing or duplicate Housebroken StatPart");
                Require(parts[0].Elements("li").Count() == (existing ? 2 : 1), "Existing part was lost or extra part added");
                Require(!existing || (string)parts[0].Elements("li").First().Attribute("Class") == "Other.StatPart", "Existing part changed");
                Require(defs.XPathSelectElement("/Defs/StatDef[defName='Other']").ToString() == untouched, "Unrelated stat changed");
            });
        test("XML: metadata and visible repository link", () => {
            var about = Load("Mod/About/About.xml").Root;
            const string url = "https://github.com/vbardales/Rimworld-Housebroken";
            Require((string)about.Element("name") == "Housebroken", "Unexpected title");
            Require((string)about.Element("packageId") == "nelim.housebroken", "Unexpected package ID");
            Require((string)about.Element("url") == url && about.Element("description").Value.Contains(url), "Repository link missing");
            Require(about.Element("description").Value.TrimEnd().EndsWith($"[url={url}]Source code on GitHub[/url]", StringComparison.Ordinal), "Final Steam repository link missing");
            Require(about.Element("supportedVersions").Elements("li").Any(x => x.Value == "1.6"), "Missing supported version");
            Require(about.Element("modDependencies").Elements("li").Any(x => (string)x.Element("packageId") == "brrainz.harmony"), "Harmony dependency missing");
        });
        test("XML: French and English keys, placeholders and source coverage", () => {
            var dictionaries = new[] { "English", "French" }.Select(language => {
                var entries = Load($"Mod/Languages/{language}/Keyed/Housebroken.xml").Root.Elements().ToArray();
                Require(entries.All(x => !string.IsNullOrWhiteSpace(x.Value)), $"Empty translation in {language}");
                return entries.ToDictionary(x => x.Name.LocalName, x => x.Value);
            }).ToArray();
            Require(dictionaries[0].Keys.Order().SequenceEqual(dictionaries[1].Keys.Order()), "Language keys differ");
            foreach(var key in dictionaries[0].Keys) {
                string[] Slots(string value) => Regex.Matches(value, @"\{\d+(?:[^}]*)\}").Select(x => x.Value).Order().ToArray();
                Require(Slots(dictionaries[0][key]).SequenceEqual(Slots(dictionaries[1][key])), $"Placeholder mismatch: {key}");
            }
            foreach(var file in Directory.GetFiles(Path.Combine(Root,"Source"),"*.cs",SearchOption.AllDirectories))
                foreach(Match match in Regex.Matches(File.ReadAllText(file), "\"(Housebroken\\.[A-Za-z0-9_.]+)\""))
                    Require(dictionaries[0].ContainsKey(match.Groups[1].Value), $"Untranslated source key: {match.Groups[1].Value}");
        });
    }
}
