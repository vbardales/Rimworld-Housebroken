# Housebroken

Un animal dresse ou intelligent salit moins, et fait son fumier dehors plutot que dans la base.
RimWorld 1.6.

## Ce que fait le mod

**1. Reduction du taux de salete.** Deux facteurs multiplicatifs, tous deux reglables :

| Critere | Defaut |
| --- | --- |
| Obeissance apprise | −50 % |
| Au moins un dressage au-dela de l'obeissance | −75 % |
| Espece a trainabilite intermediaire | −20 % |
| Espece a trainabilite avancee | −40 % |

Un husky (avancee) ayant appris l'obeissance et le transport : 0,25 x 0,6 = **0,15**, soit
85 % de salete en moins. Le catalyseur de sentience monte la trainabilite d'un cran, il compte
donc automatiquement.

**2. Fumier dehors.** Un animal qui beneficie deja d'une reduction se retient tant qu'il est
dans la base, et se soulage une fois sorti. « Dans la base » = piece couverte de la zone de
residence, la definition qu'utilise deja l'alerte vanille ; une option elargit le critere a
toute la zone de residence. Le curseur « dehors » vaut 200 % par defaut : ce qui a ete retenu
dans la base ressort dehors, au lieu de disparaitre. A 100 %, la colonie produit simplement
moins de salete au total.

**3. Boue rapportee.** Le meme animal garde sur ses pattes la boue et le sang qu'il a
ramasses tant qu'il est dans la base, et les depose une fois dehors. C'est un reglage
distinct : on peut vouloir des pattes propres sans la regle du fumier.

**4. Alerte.** Les animaux concernes ne declenchent plus l'alerte « salete animale ».

## Comment c'est branche

La salete qu'un pion **produit** passe par un seul point :

```
Pawn_FilthTracker.Notify_EnteredNewCell()
    → Rand.Value < pawn.GetStatValue(StatDefOf.FilthRate) * 0.005f
```

et l'alerte compare ce meme stat a 4. Le mod se greffe donc par un **StatPart** sur
`FilthRate` (`Patches/FilthRate.xml`), pas par un patch Harmony du tracker : c'est la
methode vanille (cf. `StatPart_Trainable`), le tooltip du stat explique la reduction, et
la compatibilite avec les autres mods est maximale.

Le StatPart depend de la position du pion, ce qui est licite ici : les deux appelants passent
`cacheStaleAfterTicks = -1`, donc `StatWorker.GetValue` ne met rien en cache. La partie
dressage/espece du calcul, elle, est mise en cache par le mod (250 ticks) parce que le
StatPart est interroge a chaque case franchie.

Deux patchs Harmony seulement. Un postfix sur `Alert_AnimalFilth.CalculateTargets`, qui
retire les animaux propres des deux listes paralleles de l'alerte. Et un prefixe sur
`Pawn_FilthTracker.TryDropFilth` pour la boue rapportee : celle-la, le StatPart ne peut pas
l'atteindre, car `Notify_EnteredNewCell` appelle `TryDropFilth` sur une constante fixe
(0,05 par case) sans aucun lien avec `FilthRate`. La salete transportee etant deja serialisee
par `Pawn_FilthTracker.ExposeData`, la retenir n'ajoute rien a la sauvegarde non plus.

## Sauvegardes

Le mod n'ajoute aucun comp ni aucune donnee a la sauvegarde. Il peut etre ajoute ou retire
d'une partie en cours sans consequence.

## Build

```
dotnet build Housebroken/Source/Housebroken.csproj -c Release
```

La DLL sort dans `Housebroken/Assemblies/`. Une jonction NTFS relie
`RimWorld\Mods\Housebroken` a ce dossier : aucune copie n'est necessaire.
