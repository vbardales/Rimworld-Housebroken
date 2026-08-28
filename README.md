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
toute la zone de residence. Un curseur « dehors » permet de faire ressortir dehors ce qui a
ete retenu au lieu de le faire disparaitre.

**3. Alerte.** Les animaux concernes ne declenchent plus l'alerte « salete animale ».

## Comment c'est branche

Toute la generation de salete du jeu passe par un seul point :

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

Seul patch Harmony : un postfix sur `Alert_AnimalFilth.CalculateTargets` pour retirer les
animaux propres des deux listes paralleles de l'alerte.

## Sauvegardes

Le mod n'ajoute aucun comp ni aucune donnee a la sauvegarde. Il peut etre ajoute ou retire
d'une partie en cours sans consequence.

## Build

```
dotnet build Housebroken/Source/Housebroken.csproj -c Release
```

La DLL sort dans `Housebroken/Assemblies/`. Une jonction NTFS relie
`RimWorld\Mods\Housebroken` a ce dossier : aucune copie n'est necessaire.
