# Mesures DAX — Tableau de bord KPI exécutif

> **Projet 4** · Power BI · *Accompagnement IA* — Patrice Arcand
> Copiez chaque mesure dans Power BI : **Modélisation → Nouvelle mesure**.
> Tables (une par CSV) : `kpi_sales`, `opportunities`, `satisfaction_nps`, `competitive_initiatives`.

---

## 1. Ventes & croissance clients  *(table `kpi_sales`)*

```dax
Ventes réelles = SUM ( kpi_sales[ventes_reelles] )

Ventes cibles = SUM ( kpi_sales[ventes_cibles] )

Écart vs cible % =
DIVIDE ( [Ventes réelles] - [Ventes cibles], [Ventes cibles] )

Nouveaux clients = SUM ( kpi_sales[nouveaux_clients] )

Clients perdus = SUM ( kpi_sales[clients_perdus] )

Croissance nette clients = [Nouveaux clients] - [Clients perdus]

Taux de rétention =
DIVIDE (
    [Nouveaux clients] - [Clients perdus],
    [Nouveaux clients]
)
```
*Repères : Ventes réelles ≈ 25,8 M$ · Nouveaux 459 · Perdus 163 · Net +296.*

---

## 2. Opportunités — gains & pertes  *(table `opportunities`)*

```dax
Pipeline total = SUM ( opportunities[valeur_estimee] )

Valeur pondérée = SUM ( opportunities[valeur_ponderee] )

Nb opportunités = COUNTROWS ( opportunities )

Valeur gagnée =
CALCULATE ( SUM ( opportunities[valeur_estimee] ), opportunities[etape] = "Fermé-Gagné" )

Valeur perdue =
CALCULATE ( SUM ( opportunities[valeur_estimee] ), opportunities[etape] = "Fermé-Perdu" )

Opp gagnées (nb) =
CALCULATE ( COUNTROWS ( opportunities ), opportunities[etape] = "Fermé-Gagné" )

Opp perdues (nb) =
CALCULATE ( COUNTROWS ( opportunities ), opportunities[etape] = "Fermé-Perdu" )

Taux de gain =
DIVIDE ( [Opp gagnées (nb)], [Opp gagnées (nb)] + [Opp perdues (nb)] )
```
*Repères : Pipeline 43,5 M$ · Pondérée 16,3 M$ · Gagnées 106 / Perdues 68 · Taux de gain ≈ 61 %.*

---

## 3. Satisfaction client  *(table `satisfaction_nps`)*

```dax
NPS actuel =
VAR DernierMois = MAX ( satisfaction_nps[mois] )
RETURN
    CALCULATE ( AVERAGE ( satisfaction_nps[nps_score] ), satisfaction_nps[mois] = DernierMois )

NPS moyen = AVERAGE ( satisfaction_nps[nps_score] )

Promoteurs % actuel =
VAR DernierMois = MAX ( satisfaction_nps[mois] )
RETURN CALCULATE ( AVERAGE ( satisfaction_nps[promoteurs_pct] ), satisfaction_nps[mois] = DernierMois )

Détracteurs % actuel =
VAR DernierMois = MAX ( satisfaction_nps[mois] )
RETURN CALCULATE ( AVERAGE ( satisfaction_nps[detracteurs_pct] ), satisfaction_nps[mois] = DernierMois )

Satisfaction support (/5) = AVERAGE ( satisfaction_nps[satisfaction_support_5] )
```
*Repères : NPS actuel 50 · NPS moyen ≈ 49 · Support ≈ 4,1/5.*

---

## 4. Veille concurrentielle — risques & opportunités  *(table `competitive_initiatives`)*

```dax
Initiatives suivies = COUNTROWS ( competitive_initiatives )

Initiatives non adressées =
CALCULATE (
    COUNTROWS ( competitive_initiatives ),
    competitive_initiatives[notre_statut] IN { "Non planifié", "Surveillance" }
)

Risques impact élevé =
CALCULATE (
    COUNTROWS ( competitive_initiatives ),
    competitive_initiatives[impact] = "Élevé"
)

Opportunités identifiées =
CALCULATE (
    COUNTROWS ( competitive_initiatives ),
    competitive_initiatives[est_opportunite] = TRUE ()
)
```
*Repères : 12 initiatives · 4 non adressées · 6 à impact élevé.*
*(Si `est_opportunite` s'importe en texte, remplacez `= TRUE()` par `= "True"`.)*

---

### Astuce mise en forme
Sur chaque mesure monétaire : onglet **Mesures → Format → Devise** (ou
`$ #,##0,,"M"` pour afficher en millions). Sur les % : **Pourcentage, 1 décimale**.
