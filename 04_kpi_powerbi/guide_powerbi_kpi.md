# 📈 Guide de montage — Tableau de bord KPI exécutif dans **Power BI**

> **Projet 4** du portfolio · Outil : **Power BI Desktop** (gratuit, Windows)
> Auteur : **Patrice Arcand** — *Accompagnement IA*
> Données : dossier `data/` (4 fichiers) · Mesures : voir `mesures_dax.md`
> Objectif : un tableau de bord exécutif couvrant **nouvelles ventes**,
> **gains/pertes en opportunités**, **satisfaction client** et **veille
> concurrentielle** (initiatives prises par la compétition, pas par nous).
> Temps estimé : **45–60 min**.

---

## 🔎 Repères de validation (vos chiffres attendus)

| Mesure | Valeur |
|---|---|
| Ventes réelles (24 mois) | **25,8 M$** · croissance nette **+296 clients** (459 gagnés / 163 perdus) |
| Pipeline d'opportunités | **43,5 M$** (pondéré 16,3 M$) |
| Gagné / Perdu | **106** (4,85 M$) / **68** (3,79 M$) · **taux de gain ≈ 61 %** |
| NPS actuel (déc. 2025) | **50** · support **4,1/5** |
| Veille concurrentielle | **12** initiatives · **4 non adressées** · **6 à impact élevé** |

---

## Étape 0 — Prérequis
- **Power BI Desktop** (gratuit) : Microsoft Store ou [powerbi.microsoft.com](https://powerbi.microsoft.com/desktop/) (Windows).
- Un compte **Power BI / Microsoft** gratuit pour publier en ligne (étape 5).

## Étape 1 — Importer les 4 fichiers
1. **Accueil → Obtenir des données → Texte/CSV**. Importez un par un :
   `kpi_sales.csv`, `opportunities.csv`, `satisfaction_nps.csv`, `competitive_initiatives.csv`
   → pour chacun, **Charger**.
2. Dans la vue **Données** (icône tableau à gauche), vérifiez les types :
   - `kpi_sales[mois]` et `satisfaction_nps[mois]` → **Date**
   - `opportunities[valeur_estimee]`, `valeur_ponderee` → **Nombre décimal**
   - `competitive_initiatives[est_opportunite]` → **Vrai/Faux** (sinon laissez en Texte et adaptez la mesure, cf. `mesures_dax.md`)
3. Pas de relations à créer : chaque page s'appuie sur une seule table.

## Étape 2 — Créer les mesures
Ouvrez **`mesures_dax.md`** et copiez chaque mesure
(**Modélisation → Nouvelle mesure**). Rangez-les dans la bonne table.

---

## Étape 3 — Construire les 4 pages de rapport

> Onglets de pages en bas. Renommez-les (double-clic). Palette : marine
> `#1C457C`, orange `#E97627` (Affichage → Thèmes → Personnaliser).

### 📄 Page 1 — « Ventes & croissance »
- **3 cartes** (visuel *Carte*) : `Ventes réelles`, `Écart vs cible %`, `Croissance nette clients`.
- **Graphique en courbes et histogrammes groupés** : Axe X = `mois` ;
  colonnes = `Ventes réelles` ; ligne = `Ventes cibles`. → réel vs cible sur 24 mois.
- **Histogramme empilé** : Axe X = `mois` ; valeurs = `Nouveaux clients` et `Clients perdus`.
- **Graphique en courbes** : `Croissance nette clients` par `mois`.

### 📄 Page 2 — « Opportunités (gains & pertes) »
- **3 cartes** : `Pipeline total`, `Taux de gain`, `Valeur pondérée`.
- **Entonnoir** (visuel *Entonnoir*) : Catégorie = `etape` ; valeurs = `Nb opportunités`.
  Ordonnez Prospect → Qualification → Proposition → Négociation → Fermé-Gagné/Perdu.
- **Histogramme** : `Valeur gagnée` vs `Valeur perdue` (deux mesures).
- **Histogramme empilé** : pipeline par `secteur` × `etape`.
- **Segment** (slicer) : `representant` pour filtrer la page.

### 📄 Page 3 — « Satisfaction client »
- **3 cartes** : `NPS actuel`, `Satisfaction support (/5)`, `Promoteurs % actuel`.
- **Courbe** : `nps_score` par `mois` (tendance 24 mois).
- **Histogramme empilé 100 %** : `promoteurs_pct`, `passifs_pct`, `detracteurs_pct` par `mois`.
- **Jauge** (visuel *Jauge*) : valeur = `NPS actuel`, min 0, max 100, cible 50.

### 📄 Page 4 — « Veille concurrentielle (risques & opportunités) » ⭐
- **4 cartes** : `Initiatives suivies`, `Initiatives non adressées`, `Risques impact élevé`, `Opportunités identifiées`.
- **Table** (visuel *Table*) : colonnes `initiative`, `concurrent`, `date`, `impact`,
  `notre_statut`, `est_opportunite`. → c'est la **liste demandée** des initiatives
  de la compétition et de notre statut.
  - **Mise en forme conditionnelle** sur `impact` (rouge = Élevé) et sur
    `notre_statut` (rouge si « Non planifié »).
- **Histogramme** : nombre d'initiatives par `notre_statut` (met en évidence les non adressées).
- **Segment** : `impact` pour filtrer.

---

## Étape 4 — Finition
- Ajoutez un **bandeau titre** (zone de texte) en haut de chaque page :
  *« KPI Exécutif — Accompagnement IA »*, sous-titre par page.
- Pied de page : *« Patrice Arcand · Accompagnement IA »*.
- Uniformisez les couleurs des visuels (marine / orange).

## Étape 5 — Publier
1. **Fichier → Enregistrer** le `.pbix` (mettez-le dans ce dossier `04_kpi_powerbi/`).
2. **Accueil → Publier** → choisissez *Mon espace de travail* (connexion compte requise).
3. Dans **Power BI Service** (app.powerbi.com), ouvrez le rapport →
   **Fichier → Incorporer un rapport → Publier sur le web (public)** pour obtenir
   un **lien public** + un code d'intégration (idéal pour le portfolio).
   - *Si « Publier sur le web » est désactivé par votre organisation :* exportez en
     **PDF** (Fichier → Exporter) et/ou faites des **captures PNG** des 4 pages —
     on les mettra dans le portfolio en attendant.

## Étape 6 — Brancher au portfolio
Envoyez-moi le **lien public Power BI** (ou les captures). Je l'intègre dans
`index.html` et le `README.md` pour que la tuile « KPI / Power BI » pointe vers
votre vrai rapport.

---

## ✅ Lecture exécutive (à mettre en intro)
> Croissance saine (**+296 clients nets**, ventes au-dessus des cibles), pipeline
> solide (**43,5 M$**, taux de gain 61 %) et satisfaction en hausse (**NPS 50**).
> Le point de vigilance : **4 initiatives concurrentes non adressées** dont
> plusieurs à impact élevé — à arbitrer en priorité (risque) ou à exploiter
> (opportunité).
