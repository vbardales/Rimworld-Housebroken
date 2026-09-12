# Housebroken — scénarios de test fonctionnels

Recette manuelle pour RimWorld 1.6. Scénarios rédigés le 12 septembre 2026 à partir du code et de la documentation ; **aucun scénario n'a encore été exécuté en jeu**.

## Préparation et méthode

- Utiliser une copie de sauvegarde dédiée, avec Harmony et Housebroken, puis ajouter les autres mods seulement pour les essais de compatibilité. Consigner la version exacte du jeu, les DLC, l'ordre des mods et la version de la DLL testée.
- Activer le mode développeur pour préparer les animaux et leur dressage. Désactiver le nettoyage et éloigner les autres sources de saleté des parcours observés.
- Préparer une pièce fermée et couverte dans la zone de résidence, un enclos découvert dans cette zone, une pièce couverte hors zone, une porte et un parcours extérieur hors zone. Vérifier les toits et la zone case par case.
- Préparer des animaux de dressabilité nulle, intermédiaire et avancée ; relever leur dressabilité réelle dans le jeu. Préparer un animal avancé sans obéissance, avec obéissance seule, puis avec obéissance et au moins un autre dressage appris. Un dressage seulement coché ou partiellement appris ne suffit pas.
- Relever pour chaque sujet son taux de saleté de référence **B**, sans Housebroken, dans les mêmes conditions et avec les mêmes autres mods. Utiliser un sujet dont B est strictement positif pour les comparaisons.
- Sauf indication contraire, rétablir les réglages par défaut avant chaque scénario. Pour isoler les facteurs de dressage, désactiver « Fumier à l'extérieur de la base ».
- Après un changement de dressage ou de dressabilité, laisser passer au moins 250 ticks de simulation avant de relire la statistique. Après un changement de réglages, fermer la fenêtre pour les enregistrer, puis rouvrir la fiche de l'animal.
- Comparer les taux dans la fiche détaillée, en tenant compte de l'arrondi affiché. Les dépôts sont aléatoires : faire marcher les sujets sur un parcours répété, noter le nombre de cases parcourues et répéter avec un témoin. L'absence de dépôt sur un court trajet ne prouve pas une réduction ; un dépôt interdit, dont l'origine est identifiée, suffit à signaler un échec.

## Calcul du taux de saleté

### TF-01 — Chargement et valeurs par défaut

**Préconditions :** configuration minimale, réglages réinitialisés.

**Étapes :** lancer une partie, ouvrir les options Housebroken, parcourir tous les réglages et consulter le journal développeur.

**Attendu :** aucune erreur de chargement XML ou Harmony liée à Housebroken. Réductions obéissance 50 %, dressage poussé 75 %, intermédiaire 20 %, avancée 40 %. Options colonie uniquement, fumier extérieur, boue et exemption d'alerte activées ; toute la zone de résidence désactivée ; réduction intérieure 100 %, multiplicateur extérieur 200 %.

### TF-02 — Facteurs individuels et d'espèce

**Préconditions :** fumier extérieur désactivé ; animaux apprivoisés de la colonie.

**Étapes :** consulter le taux et son explication pour chaque ligne réalisable avec les espèces disponibles.

| Dressabilité | Dressage appris | Taux attendu |
| --- | --- | --- |
| Nulle | Apprivoisement seul | B |
| Intermédiaire | Apprivoisement seul | B × 0,8 |
| Avancée | Apprivoisement seul | B × 0,6 |
| Intermédiaire | Obéissance seule | B × 0,4 |
| Avancée | Obéissance seule | B × 0,3 |
| Avancée | Obéissance + un dressage supplémentaire | B × 0,15 |
| Avancée | Obéissance + plusieurs dressages supplémentaires | B × 0,15 |

**Attendu :** le dressage poussé remplace le facteur d'obéissance ; les dressages supplémentaires ne cumulent pas leurs réductions. Le facteur d'espèce se multiplie avec celui du dressage. L'explication Housebroken apparaît pour un facteur inférieur à 1, sans ligne de lieu lorsque le fumier extérieur est désactivé.

### TF-03 — Acquisition et perte du dressage

**Préconditions :** animal avancé apprivoisé, fumier extérieur désactivé.

**Étapes :** mesurer sans obéissance, commencer sans terminer l'obéissance, la terminer, apprendre un dressage supplémentaire, puis retirer ce dernier et enfin l'obéissance. Attendre 250 ticks après chaque changement effectif.

**Attendu :** taux successifs B × 0,6 ; B × 0,6 ; B × 0,3 ; B × 0,15 ; B × 0,3 ; B × 0,6. Pas de réduction accordée à un apprentissage incomplet.

### TF-04 — Curseurs et absence totale de réduction

**Préconditions :** animal avancé avec obéissance et transport, B > 0.

**Étapes :** désactiver le fumier extérieur ; régler le dressage poussé à 60 % de réduction et l'espèce avancée à 25 %. Fermer les options et mesurer. Puis mettre les quatre réductions à 0 %, réactiver les options de lieu, de boue et d'alerte. Enfin tester une réduction de dressage poussé à 100 %.

**Attendu :** premier taux B × 0,4 × 0,75 = B × 0,3. Avec les quatre réductions à 0 %, taux B partout, aucune explication de réduction et aucune exemption Housebroken pour les dépôts ou l'alerte. Avec une réduction applicable à 100 %, taux nul. Les curseurs de réduction restent entre 0 et 100 % et celui d'extérieur entre 100 et 400 %.

### TF-05 — Périmètre des animaux concernés

**Préconditions :** sujets de dressabilité avancée : animal de colonie, animal sauvage, animal d'une autre faction ; colon humain et méchanoïde témoins. Fumier extérieur désactivé.

**Étapes :** comparer les statistiques avec « Animaux de la colonie uniquement » activé puis désactivé. Apprivoiser un sujet sauvage, puis tester un sujet quittant la faction de la colonie si la préparation le permet.

**Attendu :** option activée, seuls les animaux du joueur reçoivent la réduction. Option désactivée, les autres animaux en bénéficient selon leur dressage et dressabilité. Humains et méchanoïdes restent inchangés. Le changement de faction modifie l'éligibilité ; laisser expirer le cache pour tout changement simultané de dressage.

### TF-06 — Catalyseur de sentience

**Préconditions :** contenu donnant accès au catalyseur disponible ; animal compatible, fumier extérieur désactivé, dressage inchangé.

**Étapes :** relever dressabilité et taux avant et après application du catalyseur ; attendre 250 ticks.

**Attendu :** la réduction suit la nouvelle dressabilité réellement affichée : facteur d'espèce 1, 0,8 ou 0,6 selon le palier. Aucun bonus indépendant ne s'ajoute au titre du catalyseur. Marquer « Non applicable » si le contenu requis n'est pas disponible.

## Lieu et fumier produit

### TF-07 — Frontières de la base

**Préconditions :** animal avancé avec obéissance et transport, facteur de traits 0,15 ; réglages par défaut.

**Étapes :** déplacer le même animal dans chaque emplacement et rouvrir sa statistique dès son arrivée, sans attendre 250 ticks.

| Emplacement | Taux attendu |
| --- | --- |
| Pièce fermée, couverte, dans la zone de résidence | 0 |
| Enclos découvert dans la zone de résidence | B × 0,3 |
| Pièce couverte hors zone de résidence | B × 0,3 |
| Extérieur hors zone de résidence | B × 0,3 |
| Case de porte, même couverte et en zone de résidence | B × 0,3 |
| Case couverte en zone de résidence, dans une pièce touchant le bord de carte | B × 0,3 |

**Attendu :** explication « Se retient dans la base » à l'intérieur et « Dehors » ailleurs. Le changement de position est pris en compte immédiatement. Préparer le dernier cas avec une pièce dont le contact avec le bord de carte est vérifiable.

### TF-08 — Toute la zone de résidence

**Préconditions :** même sujet que TF-07.

**Étapes :** activer « Toute la zone de résidence ». Refaire les positions de TF-07 ; retirer puis réajouter la case occupée à la zone de résidence.

**Attendu :** taux nul sur toutes les cases de résidence, y compris découvertes et portes ; B × 0,3 hors zone. Modifier la zone change le taux sans délai de cache de dressage.

### TF-09 — Réglages intérieur, extérieur et désactivation

**Préconditions :** même sujet ; définition de base par défaut.

**Étapes :** régler la réduction intérieure à 50 % et l'extérieur à 300 %. Mesurer dedans puis dehors. Désactiver ensuite le fumier extérieur et répéter.

**Attendu :** taux intérieur B × 0,075 ; extérieur B × 0,45. Option désactivée : B × 0,15 aux deux endroits, sans ligne de lieu dans l'explication.

### TF-10 — Dépôts produits pendant les déplacements

**Préconditions :** parcours propres et sujets ne transportant pas de boue ou de sang ; sujet réduit et témoin sans réduction.

**Étapes :** faire marcher le sujet réduit dans la pièce intérieure puis dehors ; refaire avec le fumier extérieur désactivé. Observer aussi le témoin sans réduction dans la pièce.

**Attendu :** aux réglages par défaut, aucun fumier produit par le sujet réduit à l'intérieur. Dehors, les dépôts redeviennent possibles. Option désactivée, ils redeviennent possibles à l'intérieur. Le témoin reste soumis à son fonctionnement habituel. Ne pas exiger un dépôt dès la première case extérieure ni une quantité compensant exactement le séjour intérieur : aucun stock de fumier n'est mémorisé, seul le taux extérieur est multiplié.

## Boue et sang transportés

### TF-11 — Rétention puis dépôt extérieur

**Préconditions :** animal bénéficiant d'une réduction, fumier extérieur désactivé pour isoler les mécanismes ; parcours intérieur propre. Préparer séparément de la boue puis du sang transportés, avec un témoin confirmant que la source est effectivement ramassable et transportable.

**Étapes :** faire traverser la source puis la pièce au sujet ; prolonger son parcours dehors. Répéter avec « Ne rapporte pas la boue dans la base » désactivé, puis avec un animal sans réduction.

**Attendu :** option activée, le sujet réduit ne dépose pas la saleté transportée dans la base ; le dépôt reste possible dehors. Option désactivée ou animal sans réduction, le dépôt reste possible dedans. Distinguer le sang transporté d'un saignement actif, qui n'est pas l'objet du test. Si la charge transportée n'a pas pu être confirmée, noter le résultat comme bloqué plutôt que réussi.

### TF-12 — Indépendance des options et zone étendue

**Préconditions :** sujet réduit chargé de saleté transportée ; tester chaque combinaison sur un parcours remis au propre.

**Étapes :** tester les quatre combinaisons fumier extérieur activé/désactivé × protection contre la boue activée/désactivée. Puis activer toute la zone de résidence et faire traverser un enclos découvert en zone. Désactiver le fumier extérieur en conservant ce réglage de zone.

**Attendu :** la protection contre la boue dépend uniquement de son option, de l'éligibilité du sujet et de la définition de la base. Elle fonctionne même si la règle de fumier est désactivée. La zone étendue continue à la gouverner lorsque son contrôle est masqué par la désactivation du fumier. Le taux de fumier suit uniquement son propre réglage.

## Alerte de saleté animale

### TF-13 — Exemption et retour à la règle normale

**Préconditions :** fumier extérieur désactivé. Préparer dans une pièce admissible à l'alerte un animal réduit dont le taux final reste strictement supérieur à 4 ; ajuster légèrement les réductions si nécessaire. Vérifier d'abord qu'il apparaît avec l'exemption désactivée.

**Étapes :** activer puis désactiver l'exemption, en laissant l'alerte se recalculer entre les mesures.

**Attendu :** l'animal disparaît avec l'exemption et réapparaît sans elle. Un animal dont le taux passe sous le seuil normal ne doit pas être utilisé pour prouver l'effet de cette option.

### TF-14 — Liste mixte et cibles cliquables

**Préconditions :** plusieurs animaux déclenchant l'alerte sans exemption, dont au moins deux bénéficient d'une réduction et deux n'en bénéficient pas ; fumier extérieur désactivé.

**Étapes :** relever les noms, activer l'exemption, examiner les entrées restantes et cliquer leurs cibles. Refaire après le départ d'un animal ; terminer avec uniquement des animaux réduits.

**Attendu :** seuls les animaux non réduits restent listés ; chaque nom correspond à la bonne cible. Aucune entrée fantôme ni erreur. Lorsque tous les candidats sont exemptés, l'alerte disparaît.

## Réglages, sauvegardes et compatibilité

### TF-15 — Enregistrement et réinitialisation

**Préconditions :** partie ouverte.

**Étapes :** modifier chaque curseur et case avec des valeurs différentes des défauts ; fermer les options et vérifier les effets. Redémarrer le jeu et vérifier les valeurs. Demander une réinitialisation puis l'annuler ; recommencer et confirmer ; fermer les options et contrôler les taux.

**Attendu :** réglages persistants après redémarrage ; annulation sans changement ; confirmation rétablissant toutes les valeurs de TF-01. Aucun ancien facteur de réduction conservé après enregistrement des options.

### TF-16 — Interface française et anglaise

**Préconditions :** exécuter une fois en français puis en anglais.

**Étapes :** lire tous les réglages, les infobulles, le dialogue de réinitialisation et les explications de taux dedans/dehors ; parcourir la fenêtre à une petite résolution supportée.

**Attendu :** aucune clé brute « Housebroken.… », aucun texte manquant, curseurs et bouton accessibles par défilement, pourcentages cohérents avec les taux constatés. Les contrôles de lieu apparaissent et disparaissent correctement avec la règle de fumier.

### TF-17 — Sauvegarde et reprise avec saleté transportée

**Préconditions :** sujet réduit en intérieur avec une charge de saleté transportée confirmée, protection active.

**Étapes :** sauvegarder, quitter, recharger ; faire marcher le sujet dedans puis dehors.

**Attendu :** chargement sans erreur liée au mod, taux cohérents, protection maintenue dedans et dépôt de la charge toujours possible dehors. La sauvegarde ne doit pas effacer artificiellement la charge retenue.

### TF-18 — Ajout et retrait sur une sauvegarde existante

**Préconditions :** copies séparées d'une sauvegarde sans Housebroken et d'une sauvegarde avec Housebroken.

**Étapes :** activer le mod et charger la première copie ; vérifier TF-02 et TF-07. Désactiver le mod, redémarrer et charger la seconde copie ; poursuivre la simulation puis sauvegarder dans un nouveau fichier.

**Attendu :** ajout fonctionnel, retrait sans donnée Housebroken manquante ni erreur associée ; fonctionnement du jeu sans les réductions après retrait. Un avertissement habituel de différence de liste de mods au chargement n'est pas à lui seul un échec.

### TF-19 — Plusieurs cartes et changements de partie

**Préconditions :** deux cartes avec des zones de résidence différentes et un sujet réduit.

**Étapes :** transférer le sujet entre cartes, par exemple via une caravane ; consulter sa fiche en transit puis à l'arrivée. Charger ensuite une autre sauvegarde sans fermer le jeu, avec des animaux de dressage différent ; vérifier immédiatement puis après 250 ticks.

**Attendu :** aucune erreur sur un animal hors carte ; à l'arrivée, la définition de base de la carte courante s'applique. Aucun facteur provenant de la partie précédente ne doit contaminer la nouvelle ; relever tout taux transitoire incorrect, même s'il disparaît après 250 ticks.

### TF-20 — Coexistence avec une autre modification de FilthRate

**Préconditions :** configuration minimale validée, puis mod de test identifié ajoutant une autre partie à la statistique FilthRate ; relever son effet sans Housebroken.

**Étapes :** charger les deux mods dans chaque ordre autorisé par leurs dépendances ; examiner le journal, l'explication de taux et refaire un cas chiffré TF-02. Consigner les noms et versions des mods testés.

**Attendu :** pas d'échec du patch XML, contribution Housebroken présente une seule fois, contribution de l'autre mod conservée. Calcul conforme à l'ordre effectif des opérations ; ne pas exiger le même résultat entre ordres si l'autre mod ajoute une constante. Ce test valide uniquement les combinaisons effectivement essayées.

## Fiche d'exécution

Copier une ligne par scénario, et par variante lorsqu'elles ont des résultats différents.

| ID / variante | Version jeu, DLC, DLL et mods | Sauvegarde / sujets / réglages | Résultat observé et preuve | Statut | Anomalie |
| --- | --- | --- | --- | --- | --- |
| TF-… | À renseigner | À renseigner | Capture de taux, journal ou observation du parcours | Non exécuté | — |

Statuts : **Non exécuté**, **Réussi**, **Échoué**, **Bloqué**, **Non applicable**. Pour un échec, joindre les étapes exactes, le résultat attendu et observé, ainsi que le journal si une erreur apparaît. Pour « Bloqué » ou « Non applicable », consigner la raison.

La recette est validée lorsque tous les scénarios applicables ont été exécutés sans anomalie fonctionnelle ouverte. Les cas bloqués restent explicitement non vérifiés. La rédaction de ce document ne constitue pas une validation du fonctionnement en jeu.
