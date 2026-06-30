# 🚀 Guide de Publication GitHub
## Patrice Arcand — Portfolio Accompagnement IA

---

## ÉTAPE 1 — Créer le dépôt GitHub

1. Va sur [github.com](https://github.com) et connecte-toi avec `patricearcand`
2. Clique sur **"New repository"** (bouton vert, coin supérieur droit)
3. Remplis:
   - **Repository name**: `portfolio-accompagnement-ia`
   - **Description**: `Portfolio analytique — Python, SQL, Tableau, Power BI | Accompagnement IA`
   - **Visibility**: ✅ Public (pour que les employeurs puissent le voir)
   - **Add a README file**: ❌ Non (on en a déjà un)
4. Clique **"Create repository"**

---

## ÉTAPE 2 — Installer Git (si pas déjà fait)

Vérifie si Git est installé:
```bash
git --version
```

Si non installé: [git-scm.com/downloads](https://git-scm.com/downloads)

---

## ÉTAPE 3 — Configurer Git (première fois seulement)

```bash
git config --global user.name "Patrice Arcand"
git config --global user.email "patricearcand@gmail.com"
```

---

## ÉTAPE 4 — Publier le portfolio

Ouvre un terminal (PowerShell ou CMD) et navigue vers le dossier:

```bash
# Naviguer vers le dossier
cd "C:\Users\patri\OneDrive\Documents\Claude\Projects\Portfolio Data\portfolio-accompagnement-ia"

# Initialiser Git
git init

# Ajouter tous les fichiers
git add .

# Premier commit
git commit -m "🚀 Initial portfolio — Patrice Arcand | Accompagnement IA

- Projet 1: Analyse manufacturière (Python)
- Projet 2: Analyse des ventes (Tableau Public)
- Projet 3: Analyse churn clients (SQL + Power Query)
- Projet 4: Dashboard KPI exécutif (Power BI / HTML)
- Page d'accueil portfolio (GitHub Pages)"

# Connecter au dépôt GitHub
git remote add origin https://github.com/patricearcand/portfolio-accompagnement-ia.git

# Publier
git branch -M main
git push -u origin main
```

---

## ÉTAPE 5 — Activer GitHub Pages (site web gratuit)

1. Va sur ton dépôt: `github.com/patricearcand/portfolio-accompagnement-ia`
2. Clique sur **"Settings"** (engrenage)
3. Dans le menu gauche: **"Pages"**
4. Sous "Source": sélectionne **"Deploy from a branch"**
5. Branch: **"main"** / Folder: **"/ (root)"**
6. Clique **"Save"**
7. Attends 2-3 minutes, puis ton portfolio sera accessible à:
   ```
   https://patricearcand.github.io/portfolio-accompagnement-ia/
   ```

---

## ÉTAPE 6 — Publier sur Tableau Public (Projet 2)

1. Télécharge [Tableau Public Desktop](https://public.tableau.com/app/discover)
2. Ouvre le fichier `02_sales_tableau/data/sales_data.csv`
3. Crée ton dashboard de ventes
4. Publie sur Tableau Public (File → Publish to Tableau Public)
5. Une fois publié, copie l'URL de ton viz
6. Mets à jour le lien dans `02_sales_tableau/README.md` et `index.html`

---

## ÉTAPE 7 — Mettre à jour le profil GitHub

Va sur ton profil GitHub et ajoute:
- **Bio**: `Analyste de données & Conseiller IA | Accompagnement IA | Python, SQL, Power BI, Tableau`
- **Location**: `Québec, Canada`
- **Email**: `patricearcand@gmail.com`
- **Website**: `https://patricearcand.github.io/portfolio-accompagnement-ia/`

---

## Structure finale du dépôt

```
portfolio-accompagnement-ia/
│
├── index.html                          ← Page d'accueil (GitHub Pages)
├── README.md                           ← Description du portfolio
│
├── 01_manufacturing_python/
│   ├── manufacturing_analysis.py       ← Script Python complet
│   ├── report.html                     ← Rapport interactif
│   ├── data/
│   │   └── manufacturing_data.csv      ← Données (2 000 lignes)
│   └── output/
│       └── manufacturing_analysis_report.png
│
├── 02_sales_tableau/
│   ├── README.md
│   ├── sales_dashboard.html            ← Dashboard HTML preview
│   └── data/
│       └── sales_data.csv              ← Données (3 000 lignes)
│
├── 03_churn_sql_powerquery/
│   ├── churn_analysis.sql              ← 8 sections SQL complètes
│   ├── power_query_churn.md            ← Code Power Query M
│   └── data/
│       └── churn_data.csv              ← Données (5 000 clients)
│
└── 04_kpi_dashboard_powerbi/
    ├── kpi_dashboard.html              ← Dashboard KPI interactif
    └── data/
        ├── kpi_sales.csv
        ├── opportunities.csv
        ├── satisfaction_nps.csv
        └── competitive_initiatives.csv
```

---

## URLs importantes après publication

| Ressource | URL |
|-----------|-----|
| Portfolio principal | `https://patricearcand.github.io/portfolio-accompagnement-ia/` |
| Analyse manufacturière | `https://patricearcand.github.io/portfolio-accompagnement-ia/01_manufacturing_python/report.html` |
| Dashboard KPI | `https://patricearcand.github.io/portfolio-accompagnement-ia/04_kpi_dashboard_powerbi/kpi_dashboard.html` |
| Dépôt GitHub | `https://github.com/patricearcand/portfolio-accompagnement-ia` |

---

## Mettre à jour le portfolio (versions futures)

```bash
# Ajouter les nouvelles modifications
git add .

# Commit avec message descriptif
git commit -m "✨ Ajout: [description de ce que tu as modifié]"

# Publier la mise à jour
git push
```

---

*Guide créé avec l'assistance de Claude AI (Anthropic) | Patrice Arcand — Accompagnement IA*
