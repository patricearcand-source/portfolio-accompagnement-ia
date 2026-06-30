-- ============================================================================
-- ANALYSE DES VENTES — Qu'est-ce qui favorise le plus les ventes ?
-- Secteurs Services & Manufacturier
-- ----------------------------------------------------------------------------
-- Auteur   : Patrice Arcand
-- Société  : Accompagnement IA
-- Source   : sales_data.csv  (3 000 transactions, 2023-01-01 -> 2025-12-31)
-- Dialecte : ANSI SQL — testé sur SQLite & PostgreSQL
-- ============================================================================
--
-- OBJECTIF : identifier les leviers réels du chiffre d'affaires (secteur,
-- canal, région, taille de client, saisonnalité) afin d'orienter l'effort
-- commercial là où le rendement est le plus élevé.
--
-- ----------------------------------------------------------------------------
-- CHARGEMENT DES DONNÉES (SQLite — adapter selon votre moteur)
-- ----------------------------------------------------------------------------
-- .mode csv
-- .import sales_data.csv ventes
--
-- Table « ventes » :
--   date, secteur, region, canal_vente, representant, taille_client,
--   revenu, marge_pct, rabais_pct, nb_reunions, duree_cycle_jours,
--   score_nps, est_renouvellement, mois, trimestre, annee
-- ============================================================================


-- ============================================================================
-- SECTION 1 — VUE D'ENSEMBLE
-- ============================================================================
-- Résultat attendu : ~338,3 M$ de revenus sur 3 000 ventes.

SELECT
    COUNT(*)                         AS nb_ventes,
    ROUND(SUM(revenu)/1e6, 1)        AS revenus_M$,
    ROUND(AVG(revenu), 0)            AS panier_moyen$,
    ROUND(AVG(marge_pct), 1)         AS marge_moy_pct,
    ROUND(AVG(rabais_pct), 1)        AS rabais_moy_pct,
    MIN(date)                        AS premiere_vente,
    MAX(date)                        AS derniere_vente
FROM ventes;


-- ============================================================================
-- SECTION 2 — LE PREMIER LEVIER : LE SECTEUR
-- ============================================================================
-- Le Manufacturier pèse ~73 % des revenus (246,7 M$) pour un panier moyen
-- ~3,3× supérieur à celui des Services. C'est le moteur principal.

SELECT
    secteur,
    COUNT(*)                                           AS nb_ventes,
    ROUND(SUM(revenu)/1e6, 1)                          AS revenus_M$,
    ROUND(100.0 * SUM(revenu) / SUM(SUM(revenu)) OVER (), 1) AS part_pct,
    ROUND(AVG(revenu), 0)                              AS panier_moyen$,
    ROUND(AVG(marge_pct), 1)                           AS marge_moy_pct
FROM ventes
GROUP BY secteur
ORDER BY revenus_M$ DESC;


-- ============================================================================
-- SECTION 3 — LE CANAL DE VENTE (revenu vs marge vs rabais)
-- ============================================================================
-- Le canal Direct génère ~48 % des revenus (161 M$). Les marges sont proches
-- entre canaux (~34-36 %) : le Direct gagne par le VOLUME, pas par la marge.

SELECT
    canal_vente,
    COUNT(*)                                            AS nb_ventes,
    ROUND(SUM(revenu)/1e6, 1)                           AS revenus_M$,
    ROUND(100.0 * SUM(revenu) / SUM(SUM(revenu)) OVER (), 1) AS part_pct,
    ROUND(AVG(marge_pct), 1)                            AS marge_moy_pct,
    ROUND(AVG(rabais_pct), 1)                           AS rabais_moy_pct,
    ROUND(AVG(revenu), 0)                               AS panier_moyen$
FROM ventes
GROUP BY canal_vente
ORDER BY revenus_M$ DESC;


-- ============================================================================
-- SECTION 4 — LA RÉGION
-- ============================================================================
-- Québec (36,7 %) + Ontario (27,8 %) = ~64 % des revenus.
-- L'Ontario reste sous-exploité vs son potentiel : piste de croissance.

SELECT
    region,
    COUNT(*)                                            AS nb_ventes,
    ROUND(SUM(revenu)/1e6, 1)                           AS revenus_M$,
    ROUND(100.0 * SUM(revenu) / SUM(SUM(revenu)) OVER (), 1) AS part_pct
FROM ventes
GROUP BY region
ORDER BY revenus_M$ DESC;


-- ============================================================================
-- SECTION 5 — LA TAILLE DE CLIENT (le levier du panier moyen)
-- ============================================================================
-- Grande entreprise : panier moyen ~232 k$, soit 3,4× la PME (~68 k$).
-- Un même effort commercial rend beaucoup plus sur les grands comptes.

SELECT
    taille_client,
    COUNT(*)                                            AS nb_ventes,
    ROUND(SUM(revenu)/1e6, 1)                           AS revenus_M$,
    ROUND(AVG(revenu), 0)                               AS panier_moyen$,
    ROUND(AVG(revenu) / (SELECT AVG(revenu) FROM ventes WHERE taille_client='PME'), 2)
                                                        AS ratio_vs_PME
FROM ventes
GROUP BY taille_client
ORDER BY panier_moyen$ DESC;


-- ============================================================================
-- SECTION 6 — LA SAISONNALITÉ (indice base 100 = moyenne mensuelle)
-- ============================================================================
-- Pic en fin d'année : décembre 125, octobre 118, novembre 117.
-- Creux en février (64). => concentrer les efforts de closing sur Q4.

WITH par_mois AS (
    SELECT mois, SUM(revenu) AS rev
    FROM ventes
    GROUP BY mois
)
SELECT
    mois,
    ROUND(rev/1e6, 1)                                  AS revenus_M$,
    ROUND(100.0 * rev / (SELECT AVG(rev) FROM par_mois), 0) AS indice_saison
FROM par_mois
ORDER BY mois;

-- Meilleur trimestre absolu (attendu : Q4 2024, ~43,2 M$)
SELECT
    annee,
    trimestre,
    ROUND(SUM(revenu)/1e6, 1)                          AS revenus_M$
FROM ventes
GROUP BY annee, trimestre
ORDER BY revenus_M$ DESC
LIMIT 5;


-- ============================================================================
-- SECTION 7 — SERVICES vs MANUFACTURIER : profils comparés
-- ============================================================================
-- Met côte à côte les deux secteurs sur leurs canaux et tailles de clients
-- dominants — pour adapter la stratégie commerciale à chaque secteur.

SELECT
    secteur,
    canal_vente,
    ROUND(SUM(revenu)/1e6, 2)                          AS revenus_M$,
    ROUND(100.0 * SUM(revenu)
          / SUM(SUM(revenu)) OVER (PARTITION BY secteur), 1) AS part_du_secteur_pct,
    ROUND(AVG(marge_pct), 1)                           AS marge_moy_pct
FROM ventes
GROUP BY secteur, canal_vente
ORDER BY secteur, revenus_M$ DESC;


-- ============================================================================
-- SECTION 8 — PERFORMANCE DES REPRÉSENTANTS (Top 10)
-- ============================================================================

SELECT
    representant,
    COUNT(*)                                            AS nb_ventes,
    ROUND(SUM(revenu)/1e6, 1)                           AS revenus_M$,
    ROUND(AVG(revenu), 0)                               AS panier_moyen$,
    ROUND(AVG(marge_pct), 1)                            AS marge_moy_pct,
    ROUND(AVG(duree_cycle_jours), 0)                    AS cycle_moy_jours
FROM ventes
GROUP BY representant
ORDER BY revenus_M$ DESC
LIMIT 10;


-- ============================================================================
-- SECTION 9 — NOUVELLES VENTES vs RENOUVELLEMENTS
-- ============================================================================
-- Les renouvellements affichent une marge légèrement supérieure
-- (35,4 % vs 34,9 %) : la rétention protège la rentabilité.

SELECT
    CASE est_renouvellement WHEN 1 THEN 'Renouvellement' ELSE 'Nouvelle vente' END AS type_vente,
    COUNT(*)                                            AS nb_ventes,
    ROUND(SUM(revenu)/1e6, 1)                           AS revenus_M$,
    ROUND(AVG(revenu), 0)                               AS panier_moyen$,
    ROUND(AVG(marge_pct), 1)                            AS marge_moy_pct
FROM ventes
GROUP BY est_renouvellement
ORDER BY revenus_M$ DESC;


-- ============================================================================
-- SECTION 10 — VUE SYNTHÈSE : le « client idéal » par secteur
-- ============================================================================
-- Vue réutilisable qui isole la combinaison gagnante (secteur x canal x
-- taille) générant le plus de revenus — la cible prioritaire de prospection.

CREATE VIEW v_segments_gagnants AS
SELECT
    secteur,
    canal_vente,
    taille_client,
    COUNT(*)                            AS nb_ventes,
    ROUND(SUM(revenu)/1e6, 2)           AS revenus_M$,
    ROUND(AVG(revenu), 0)               AS panier_moyen$,
    ROUND(AVG(marge_pct), 1)            AS marge_moy_pct
FROM ventes
GROUP BY secteur, canal_vente, taille_client;

-- Top 10 segments à prioriser
SELECT *
FROM v_segments_gagnants
ORDER BY revenus_M$ DESC
LIMIT 10;

-- ============================================================================
-- CONCLUSION (data-backed)
-- ----------------------------------------------------------------------------
-- 1. Concentrer la prospection sur le MANUFACTURIER (73 % des revenus).
-- 2. Prioriser le canal DIRECT pour le volume, sans sacrifier la marge.
-- 3. Cibler les GRANDES ENTREPRISES : panier 3,4× la PME pour un effort égal.
-- 4. Investir le marché ONTARIEN, sous-exploité vs son potentiel.
-- 5. Charger l'agenda de closing sur Q4 (déc./oct./nov.), pas en février.
-- ============================================================================
