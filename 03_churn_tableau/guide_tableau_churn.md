# 📊 Guide de montage — Analyse du Churn dans **Tableau Public**

> **Projet 3** du portfolio · Outil : **Tableau Public** (gratuit, Salesforce)
> Auteur : **Patrice Arcand** — *Accompagnement IA*
> Données : `data/churn_tableau.csv` (5 000 clients, déjà enrichi pour Tableau)
> Objectif : **identifier les causes de pertes de clients** et qui est à risque.

Ce guide vous mène, clic par clic, de la connexion des données jusqu'à la
publication d'un tableau de bord interactif sur votre profil Tableau Public.
Temps estimé : **30–45 min**.

---

## 🔎 Ce que les données disent déjà (vos repères de validation)

| Mesure | Valeur attendue |
|---|---|
| Taux de churn global | **16,1 %** (805 clients perdus / 5 000) |
| Cause #1 de départ | **Prix trop élevé — 30 %** |
| Causes suivantes | Concurrent 21,7 % · Fonctionnalités 18,7 % · Support 10,9 % |
| Contrat le plus risqué | **Mensuel 17,9 %** (vs pluriannuel 13,7 %) |
| Cohorte la plus risquée | **0-6 mois → 21,7 %** (risque d'onboarding) |
| Effet « mention concurrent » | 19,3 % vs 15,6 % (**+3,7 pts**) |
| Effet « hausse de prix annoncée » | 18,2 % vs 15,2 % (**+3,0 pts**) |
| Inactivité moyenne | **117 j** (partis) vs 84 j (actifs) |

Si vos feuilles affichent ces nombres, vous êtes sur la bonne voie. ✅

---

## Étape 0 — Prérequis (gratuit)

1. Créez un compte sur **[public.tableau.com](https://public.tableau.com)**.
2. Téléchargez **Tableau Public Desktop** (gratuit) depuis le même site.
   *(Alternative : l'éditeur web « Web Authoring » de Tableau Public — mêmes menus.)*

---

## Étape 1 — Connecter les données

1. Ouvrez Tableau Public Desktop → **Connexion → À un fichier → Texte (.csv)**.
2. Sélectionnez `03_churn_tableau/data/churn_tableau.csv`.
3. Dans l'aperçu, vérifiez que **`revenu_mensuel`**, **`score_risque_churn`**,
   **`adoption_fonctionnalites_pct`** sont reconnus comme des **nombres** (icône #),
   et que **`a_churne`** est numérique (0/1).
4. Cliquez sur **Feuille 1** en bas pour commencer.

> 💡 Tableau renomme les champs : `a_churne` → **« A Churne »**, `raison_depart`
> → **« Raison Depart »**, etc. Les formules ci-dessous utilisent ces noms.

---

## Étape 2 — Créer les champs calculés

Menu **Analyse → Créer un champ calculé** pour chacun :

**① Taux de churn** (la mesure-clé, en %)
```
SUM([A Churne]) / COUNT([Client Id])
```
→ Clic droit sur le champ → **Format par défaut → Nombre → Pourcentage (1 décimale)**.

**② Nb de clients perdus**
```
SUM([A Churne])
```

**③ Clients à risque (actifs seulement)** — pour la liste d'action
```
IF [A Churne] = 0 AND [Score Risque Churn] >= 0.60 THEN 1 ELSE 0 END
```

> Les segments **`statut_client`** (Actif/Parti), **`cohorte_anciennete`**,
> **`tier_risque`** et **`segment_engagement`** sont **déjà dans le fichier** —
> pas besoin de les recréer.

---

## Étape 3 — Construire les feuilles (onglets en bas = « Nouvelle feuille »)

### Feuille « KPI – Churn global » (Big Number)
- Glissez **Taux de churn** dans **Texte** (carte Repères).
- Mets le titre de la feuille à *« Taux de churn global »*. → doit afficher **16,1 %**.

### Feuille « Causes de départ » ⭐ (le graphique vedette)
- **Filtre** : glissez `Statut Client` dans **Filtres** → cochez **Parti** seulement.
- **Lignes** : `Raison Depart`.
- **Colonnes** : `Nombre d'enregistrements` (ou `CNT(Client Id)`).
- Trier **décroissant**. → « Prix trop élevé » domine (30 %).
- Couleur : orange `#E97627`. Activez les **étiquettes** (Repères → Étiquette).

### Feuille « Churn par type de contrat »
- **Colonnes** : `Type Contrat` · **Lignes** : **Taux de churn**.
- Trie décroissant → Mensuel (17,9 %) > Annuel > Pluriannuel (13,7 %).

### Feuille « Churn par cohorte d'ancienneté »
- **Colonnes** : `Cohorte Anciennete` (ordonner : 0-6, 7-12, 13-24, 25-48, 48+)
- **Lignes** : **Taux de churn**. → pic à 0-6 mois (21,7 %) : risque d'onboarding.

### Feuille « Déclencheurs externes »
- Deux mini-graphiques côte à côte :
  - `Mention Concurrent Txt` (Oui/Non) × **Taux de churn**
  - `Hausse Prix Txt` (Oui/Non) × **Taux de churn**
- Montre l'écart : Oui ≈ 19 % vs Non ≈ 15 %.

### Feuille « Signaux comportementaux »
- **Colonnes** : `Statut Client` (Actif/Parti)
- **Lignes** : `AVG([Jours Sans Connexion])` → 117 j (Parti) vs 84 j (Actif).
- Ajoutez une 2ᵉ mesure `AVG([Connexions 30j])` en double axe si désiré.

### Feuille « Churn par industrie »
- **Lignes** : `Industrie` · **Colonnes** : **Taux de churn**, trié décroissant.
  → Santé en tête (18,6 %), Manufacturier le plus fidèle (13,0 %).

### Feuille « Carte de risque » (table d'action)
- **Lignes** : `Tier Risque`, `Plan` · **Texte** : `CNT(Client Id)`, `SUM(Revenu Mensuel)`.
- Filtre `Statut Client` = **Actif** → revenu mensuel à risque (tier 🔴 Élevé).

---

## Étape 4 — Assembler le tableau de bord

1. Bas de l'écran → **Nouveau tableau de bord**.
2. **Taille** : *Automatique* ou *1200 × 900*.
3. Glissez les feuilles dans cette disposition :
   ```
   ┌───────────────────────────────────────────────┐
   │  Titre : « Analyse du Churn — Accompagnement IA »│
   │  [KPI 16,1%]        [Causes de départ ⭐]         │
   │  [Type de contrat]  [Cohorte ancienneté]         │
   │  [Déclencheurs]     [Signaux comportementaux]    │
   │  [Industrie]        [Carte de risque]            │
   └───────────────────────────────────────────────┘
   ```
4. **Interactivité** : sur la feuille « Causes de départ », icône entonnoir →
   **Utiliser comme filtre**. Ajoutez un filtre `Plan` et `Industrie` (clic droit
   sur le champ dans une feuille → *Afficher le filtre*).
5. **Couleurs Accompagnement IA** : orange `#E97627`, bleu marine `#1C457C`.
6. Ajoutez un objet **Texte** en bas : *« Patrice Arcand · Accompagnement IA · Source : 5 000 clients »*.

---

## Étape 5 — Publier sur Tableau Public

1. **Fichier → Enregistrer sur Tableau Public sous…** (connectez-vous au besoin).
2. Nommez-le : **`Analyse Churn - Accompagnement IA`**.
3. Tableau ouvre la page web du viz publié. **Copiez l'URL** (forme :
   `https://public.tableau.com/views/AnalyseChurn.../Dashboard`).
4. Sur la page du viz → **Modifier les détails** : ajoutez une description +
   une vignette. Cochez *« Permettre le téléchargement »* si vous voulez.

---

## Étape 6 — Brancher au portfolio

Donnez-moi l'**URL Tableau Public** une fois publiée : je l'insère dans la page
d'accueil du portfolio (`index.html`) et dans le `README.md`, pour que la tuile
« Churn / Tableau » pointe vers votre vrai viz interactif.

---

## ✅ Conclusion analytique (à mettre en intro du dashboard)

> Le churn (16,1 %) est d'abord un **problème de prix et de concurrence**
> (52 % des départs combinés). Il frappe surtout les **contrats mensuels** et les
> **nouveaux clients (0-6 mois)**. Deux signaux avancés exploitables : une
> **mention de concurrent** et une **inactivité prolongée** (>90 j). Leviers de
> rétention : sécuriser l'onboarding des 6 premiers mois, pousser l'engagement
> annuel/pluriannuel, et déclencher une alerte dès qu'un client devient inactif
> ou mentionne un concurrent.
