# 📊 Portfolio Data Analytics — Patrice Arcand

<div align="center">

![Accompagnement IA](https://img.shields.io/badge/Accompagnement%20IA-Intelligence%20d'affaires-1C457C?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-Pandas-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Analyse-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-Power%20Query-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-DAX-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Tableau](https://img.shields.io/badge/Tableau-Public-E97627?style=for-the-badge&logo=tableau&logoColor=white)

**Patrice Arcand** — Analyste de données & conseiller IA
🏢 Accompagnement IA · 📍 Québec, Canada · ✉️ patricearcand@gmail.com

🌐 **[Voir le portfolio en ligne →](https://patricearcand-source.github.io/portfolio-accompagnement-ia/)**

</div>

---

## 🎯 Le concept

Quatre analyses d'affaires réelles, **chacune réalisée dans un outil différent** —
pour démontrer la maîtrise de bout en bout de la chaîne analytique, de la donnée
brute jusqu'à la recommandation chiffrée.

| # | Projet | Secteur | Outil | Découverte clé | Livrables |
|---|--------|---------|-------|----------------|-----------|
| 1 | **Coûts de production** | Manufacturier | 🐍 Python + HTML | Ligne C = 3,2 % d'économie potentielle | [Rapport](01_manufacturing_python/report.html) · [Code](01_manufacturing_python/generer_rapport_html.py) |
| 2 | **Leviers de ventes** | Services + Manuf. | 📊 Excel + SQL | Manufacturier = 73 % des revenus | [Excel](02_ventes_sql_excel/Analyse_Ventes_Accompagnement_IA.xlsx) · [SQL](02_ventes_sql_excel/analyse_ventes.sql) |
| 3 | **Pertes de clients** | SaaS | 🟧 Tableau Public | Churn 16,1 % — cause n°1 : le prix (30 %) | [🟧 Viz en ligne](https://public.tableau.com/app/profile/patrice.arcand/viz/AnalyseduChurn-AccompagnementAI/AnalyseduChurnAccompagnementIA) · [Guide](03_churn_tableau/guide_tableau_churn.md) |
| 4 | **KPI exécutif** | Multi | 📈 Power BI | +296 clients nets · 4 risques concurrentiels | [📈 Rapport .pbix](https://github.com/patricearcand-source/portfolio-accompagnement-ia/raw/main/04_kpi_powerbi/Tableau_de_bord_KPI_executif.pbix) · [Guide](04_kpi_powerbi/guide_powerbi_kpi.md) |

---

## 📁 Structure du dépôt

```
portfolio-accompagnement-ia/
├── index.html                          ← Page d'accueil (GitHub Pages)
├── 01_manufacturing_python/            ← PYTHON + HTML
│   ├── generer_rapport_html.py         ← Analyse + génération du rapport
│   ├── manufacturing_analysis.py       ← Analyse détaillée + graphiques
│   ├── report.html                     ← Rapport interactif (Chart.js)
│   └── data/manufacturing_data.csv     ← 2 000 lots de production
├── 02_ventes_sql_excel/                ← EXCEL + SQL
│   ├── Analyse_Ventes_Accompagnement_IA.xlsx  ← Classeur natif (formules + graphiques)
│   ├── analyse_ventes.sql              ← 10 sections d'analyse + vue
│   ├── power_query_ventes.md           ← Pipeline Power Query M
│   └── data/sales_data.csv             ← 3 000 ventes
├── 03_churn_tableau/                   ← TABLEAU PUBLIC
│   ├── guide_tableau_churn.md          ← Guide de montage + publication
│   └── data/churn_tableau.csv          ← 5 000 clients (enrichi)
└── 04_kpi_powerbi/                     ← POWER BI
    ├── guide_powerbi_kpi.md            ← Guide 4 pages
    ├── mesures_dax.md                  ← Toutes les mesures DAX
    └── data/                           ← ventes, opportunités, NPS, veille
```

---

## 🛠️ Comment consulter chaque projet

- **Projet 1 (Python)** : ouvrez `01_manufacturing_python/report.html` dans un navigateur, ou lancez `python generer_rapport_html.py`.
- **Projet 2 (Excel/SQL)** : ouvrez le `.xlsx` dans Excel (les formules se recalculent), et le `.sql` dans n'importe quel client SQL (SQLite/PostgreSQL).
- **Projet 3 (Tableau)** : suivez `guide_tableau_churn.md` pour reconstruire le viz dans Tableau Public.
- **Projet 4 (Power BI)** : suivez `guide_powerbi_kpi.md` + collez les mesures de `mesures_dax.md` dans Power BI Desktop.

> ✅ **Portfolio complet** : viz **Tableau Public** en ligne + rapport **Power BI** (`.pbix`) et classeur **Tableau** (`.twb`) téléchargeables.

---

## 🧰 Compétences démontrées

| Langages & requêtes | Visualisation | Méthodologie |
|---|---|---|
| Python (Pandas) · SQL | Power BI (DAX) · Tableau | Analyse de coûts · Segmentation |
| Power Query (M) | Excel · Chart.js | Analyse de cohortes · KPI |

---

<div align="center">

**Accompagnement IA** — rendre l'analyse de données et l'IA accessibles aux PME.
*Réalisé avec l'assistance de Claude (Anthropic).*

</div>
