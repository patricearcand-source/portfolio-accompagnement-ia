# Power Query (Excel) — Pipeline de préparation des ventes

> Volet **Excel / Power Query** du projet *Analyse des ventes*.
> Auteur : **Patrice Arcand** — *Accompagnement IA*. Source : `data/sales_data.csv`.

Ce document montre comment les données brutes sont nettoyées et enrichies dans
**Power Query** (Excel → *Données → Obtenir des données → À partir d'un CSV*),
puis exploitées par le tableau de bord du classeur `Analyse_Ventes_Accompagnement_IA.xlsx`.

---

## 1. Importer et typer les colonnes

```m
let
    Source = Csv.Document(
        File.Contents("sales_data.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Promu = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Type = Table.TransformColumnTypes(Promu, {
        {"date", type date},
        {"secteur", type text}, {"region", type text}, {"canal_vente", type text},
        {"representant", type text}, {"taille_client", type text},
        {"revenu", type number}, {"marge_pct", type number}, {"rabais_pct", type number},
        {"nb_reunions", Int64.Type}, {"duree_cycle_jours", Int64.Type},
        {"score_nps", Int64.Type}, {"est_renouvellement", Int64.Type},
        {"mois", Int64.Type}, {"trimestre", type text}, {"annee", Int64.Type}
    })
in
    Type
```

## 2. Colonnes enrichies (segmentation commerciale)

```m
    // Segment de panier : prioriser les gros tickets
    SegPanier = Table.AddColumn(Type, "segment_panier", each
        if [revenu] >= 200000 then "Grand compte"
        else if [revenu] >= 75000 then "Compte moyen"
        else "Petit compte", type text),

    // Indicateur Q4 (saison forte)
    Saison = Table.AddColumn(SegPanier, "saison_forte", each
        if List.Contains({"Q4"}, [trimestre]) then "Q4 (pic)" else "Hors Q4", type text),

    // Marge nette estimée après rabais
    MargeNette = Table.AddColumn(Saison, "marge_nette_pct", each
        [marge_pct] - [rabais_pct], type number)
```

## 3. Requête combinée prête à charger (copier-coller)

```m
let
    Source = Csv.Document(File.Contents("sales_data.csv"), [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    Promu  = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Type   = Table.TransformColumnTypes(Promu, {
        {"date", type date}, {"revenu", type number}, {"marge_pct", type number},
        {"rabais_pct", type number}, {"nb_reunions", Int64.Type}, {"mois", Int64.Type}, {"annee", Int64.Type}
    }),
    SegPanier  = Table.AddColumn(Type, "segment_panier", each if [revenu]>=200000 then "Grand compte" else if [revenu]>=75000 then "Compte moyen" else "Petit compte", type text),
    Saison     = Table.AddColumn(SegPanier, "saison_forte", each if [trimestre]="Q4" then "Q4 (pic)" else "Hors Q4", type text),
    MargeNette = Table.AddColumn(Saison, "marge_nette_pct", each [marge_pct]-[rabais_pct], type number)
in
    MargeNette
```

---

## 4. Équivalents formules Excel (feuille « Calculs »)

| Indicateur | Formule Excel |
|---|---|
| Revenus d'un secteur | `=SUMIFS(Donnees!G:G; Donnees!B:B; "Manufacturier")` |
| Nb de ventes d'un canal | `=COUNTIFS(Donnees!D:D; "Direct")` |
| Marge moyenne d'une région | `=AVERAGEIFS(Donnees!H:H; Donnees!C:C; "Québec")` |
| Part d'un secteur (%) | `=SUMIFS(Donnees!G:G; Donnees!B:B; "Manufacturier")/SUM(Donnees!G:G)` |
| Panier moyen d'une taille | `=AVERAGEIFS(Donnees!G:G; Donnees!F:F; "Grande entreprise")` |
| Indice saisonnier d'un mois | `=100*SUMIFS(Donnees!G:G;Donnees!N:N;12)/AVERAGE(revenus_mensuels)` |

> Le classeur livré (`Analyse_Ventes_Accompagnement_IA.xlsx`) utilise exactement
> ces formules — les tableaux et graphiques se recalculent automatiquement si on
> remplace les données de la feuille **Donnees**. Alternative *no-code* : un
> **Tableau croisé dynamique** sur la plage `Donnees` (Lignes = secteur/canal,
> Valeurs = Somme de revenu) reproduit la même synthèse.
