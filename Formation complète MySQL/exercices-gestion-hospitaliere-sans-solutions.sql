-- =====================================================================
-- EXERCICES SQL — GESTION HOSPITALIÈRE (santeSQL)
-- Version SANS SOLUTIONS : leçons, explications et énoncés d'exercices
-- (avec indices) sont conservés, mais les requêtes SQL ont été retirées.
-- À toi d'écrire la requête sous chaque exercice.
-- Les solutions complètes se trouvent dans exercices-gestion-hospitaliere.sql.
-- =====================================================================

-- Schéma de référence : voir sante-hop_export.sql pour CREATE TABLE + INSERT.

-- #####################################################################
-- NIVEAU : DÉBUTANT
-- #####################################################################

-- ---------------------------------------------------------------
-- LEÇON : 1. SELECT – Lire des données
-- ---------------------------------------------------------------
-- En termes simples :
-- SELECT est la commande pour lire des données dans une base. C'est toujours le point de départ d'une question posée à la base : "Montre-moi ces informations."
--
-- FROM précise dans quelle table chercher. Une base de données est un ensemble de tables — chaque table ressemble à un tableau Excel avec des lignes et des colonnes.
--
-- 📂 Imaginez un classeur avec plusieurs onglets : patients, consultations, médecins. SELECT * FROM patients revient à ouvrir l'onglet patients et afficher toutes ses lignes.

-- Exercice 1 : Sélectionnez le nom, le prenom et le groupe_sanguin de tous les patients.
--   Indice 1 : Utilisez SELECT col1, col2, col3 FROM table;
--   Indice 2 : Colonnes : nom, prenom, groupe_sanguin

-- Exercice 2 : Sélectionnez l'id_patient, le nom et l'age de tous les patients.
--   Indice 1 : SELECT col1, col2, col3 FROM table;
--   Indice 2 : Colonnes : id_patient, nom, age

-- Exercice 3 : Sélectionnez toutes les colonnes de la table medecins.
--   Indice 1 : Utilisez * pour toutes les colonnes.
--   Indice 2 : La table s'appelle medecins (sans accent).


-- ---------------------------------------------------------------
-- LEÇON : 2. WHERE – Filtrer les lignes
-- ---------------------------------------------------------------
-- En termes simples :
-- WHERE filtre les lignes — il ne garde que celles qui correspondent à une condition.
--
-- Les opérateurs : = (égal), != (différent), > < (supérieur/inférieur).
-- Texte entre guillemets simples 'Cardiologie', nombres sans guillemets 60.
--
-- 🔍 Chercher tous les patients de Cardiologie dans une liste de 1 000 fiches, c'est long à la main. WHERE service = 'Cardiologie' fait ce tri instantanément, comme un filtre dans Excel.

-- Exercice 1 : Listez tous les patients du service Cardiologie.
--   Indice 1 : Ajoutez WHERE après FROM.
--   Indice 2 : La valeur est 'Cardiologie' (avec guillemets simples).

-- Exercice 2 : Listez tous les patients de sexe M.
--   Indice 1 : WHERE sexe = 'valeur'
--   Indice 2 : La valeur est la lettre M entre guillemets simples.

-- Exercice 3 : Listez les patients dont l'âge est supérieur à 60 ans.
--   Indice 1 : WHERE age > nombre (sans guillemets pour les nombres)
--   Indice 2 : 60 est un nombre, pas de guillemets simples.


-- ---------------------------------------------------------------
-- LEÇON : 3. AND / OR / BETWEEN / IN
-- ---------------------------------------------------------------
-- En termes simples :
-- AND exige que toutes les conditions soient vraies. OR exige qu'au moins une le soit.
--
-- BETWEEN filtre une plage de valeurs (bornes incluses). IN vérifie si une valeur appartient à une liste de valeurs possibles.
--
-- 🔎 WHERE service IN ('Cardiologie', 'Neurologie') AND age BETWEEN 30 AND 60 : patients des deux services ET dans cette tranche d'âge. Sans AND/IN/BETWEEN, il faudrait écrire plusieurs conditions séparées.

-- Exercice 1 : Trouvez les patients dont le service est Cardiologie ou Neurologie ET dont l'âge est entre 30 et 60 ans.
--   Indice 1 : Utilisez IN ('Cardiologie', 'Neurologie') pour le service.
--   Indice 2 : Utilisez BETWEEN 30 AND 60 pour l'âge.

-- Exercice 2 : Trouvez les patients de sexe F appartenant au service Gériatrie ou Oncologie.
--   Indice 1 : Combinez WHERE sexe = 'F' AND service IN (...)
--   Indice 2 : IN ('Gériatrie', 'Oncologie')

-- Exercice 3 : Listez les médecins dont le salaire est entre 8000 et 9000 (inclus).
--   Indice 1 : La table est medecins, la colonne est salaire.
--   Indice 2 : BETWEEN 8000 AND 9000


-- ---------------------------------------------------------------
-- LEÇON : 4. NULL – IS NULL / IS NOT NULL / COALESCE
-- ---------------------------------------------------------------
-- En termes simples :
-- NULL signifie "valeur absente" — pas zéro, pas vide, mais inconnu. On ne peut pas tester NULL avec = : il faut IS NULL ou IS NOT NULL.
--
-- COALESCE(col, valeur) remplace NULL par une valeur par défaut dans l'affichage.
--
-- 🏥 Un patient encore hospitalisé n'a pas de date de sortie : date_sortie IS NULL le retrouve. COALESCE(date_sortie, 'En cours') affiche "En cours" à la place du NULL.

-- Exercice 1 : Listez les hospitalisations encore en cours (date_sortie est NULL). Affichez id_patient, chambre et date_entree.
--   Indice 1 : La table s'appelle hospitalisations.
--   Indice 2 : WHERE date_sortie IS NULL

-- Exercice 2 : Listez les hospitalisations terminées (date_sortie est renseignée). Affichez id_patient, chambre, date_entree et date_sortie.
--   Indice 1 : IS NOT NULL teste qu'une valeur existe.
--   Indice 2 : WHERE date_sortie IS NOT NULL

-- Exercice 3 : Affichez toutes les hospitalisations avec la date_sortie remplacée par "En cours" si elle est NULL. Colonnes : id_hosp, chambre, date_entree, statut.
--   Indice 1 : COALESCE(date_sortie, 'En cours') AS statut
--   Indice 2 : SELECT id_hosp, chambre, date_entree, COALESCE(date_sortie, 'En cours') AS statut


-- ---------------------------------------------------------------
-- LEÇON : 5. ORDER BY & LIMIT
-- ---------------------------------------------------------------
-- En termes simples :
-- ORDER BY trie les résultats selon une ou plusieurs colonnes.
-- ASC = croissant (A→Z, 1→100) — c'est le défaut. DESC = décroissant (Z→A, 100→1).
--
-- LIMIT restreint le nombre de lignes retournées. Indispensable pour obtenir le "top N" d'un classement.
--
-- 🗂️ ORDER BY salaire DESC LIMIT 3 : classer les médecins du mieux payé au moins bien payé, puis ne garder que les 3 premiers — comme un podium.

-- Exercice 1 : Les 3 patients les plus âgés : nom, prenom, age, service.
--   Indice 1 : ORDER BY age DESC
--   Indice 2 : LIMIT 3 à la fin

-- Exercice 2 : Les 5 consultations les plus longues : diagnostic, duree_min, medecin_id.
--   Indice 1 : ORDER BY duree_min DESC
--   Indice 2 : LIMIT 5

-- Exercice 3 : Les 3 médecins les mieux payés : nom, specialite, salaire.
--   Indice 1 : ORDER BY salaire DESC
--   Indice 2 : LIMIT 3


-- ---------------------------------------------------------------
-- LEÇON : 6. DISTINCT – Dédoublonner
-- ---------------------------------------------------------------
-- En termes simples :
-- SELECT DISTINCT élimine les doublons dans le résultat. Si dix patients sont dans le service Cardiologie, SELECT DISTINCT service retourne "Cardiologie" une seule fois.
--
-- On peut appliquer DISTINCT sur plusieurs colonnes : chaque combinaison unique compte.
--
-- 📋 Comme l'option "Supprimer les doublons" dans Excel — mais appliquée à la volée dans la requête, sans modifier les données originales.

-- Exercice 1 : Listez tous les services distincts présents dans la table patients.
--   Indice 1 : Utilisez SELECT DISTINCT.
--   Indice 2 : Une seule colonne suffit ici.

-- Exercice 2 : Listez toutes les spécialités distinctes des médecins.
--   Indice 1 : SELECT DISTINCT colonne FROM table;
--   Indice 2 : La colonne s'appelle specialite dans la table medecins.

-- Exercice 3 : Listez toutes les combinaisons distinctes de service et statut des patients.
--   Indice 1 : SELECT DISTINCT col1, col2 retourne des paires uniques.
--   Indice 2 : Chaque paire (service, statut) n'apparaît qu'une seule fois.


-- ---------------------------------------------------------------
-- LEÇON : 8. OFFSET – Afficher à partir d'une ligne
-- ---------------------------------------------------------------
-- En termes simples :
-- OFFSET saute les N premières lignes avant d'afficher les résultats. Combiné à LIMIT, il permet de paginer :
-- • LIMIT 3 OFFSET 0 → page 1 (lignes 1–3)
-- • LIMIT 3 OFFSET 3 → page 2 (lignes 4–6)
-- • LIMIT 3 OFFSET 6 → page 3 (lignes 7–9)
--
-- 📖 Comme sauter des pages dans un livre : LIMIT = nombre de pages à lire, OFFSET = nombre de pages à ignorer avant de commencer. Pour aller directement au chapitre 3 (3 pages par chapitre) : LIMIT 3 OFFSET 6.

-- Exercice 1 : Affichez les patients en sautant le plus âgé : 4 patients triés par âge décroissant, en commençant au 2ème. Colonnes : nom, prenom, age.
--   Indice 1 : ORDER BY age DESC pour trier du plus âgé au plus jeune.
--   Indice 2 : LIMIT 4 OFFSET 1 — saute le 1er résultat (le plus âgé).

-- Exercice 2 : Simulez la page 2 des consultations (3 résultats par page). Affichez id_consultation, diagnostic, duree_min, triés par id_consultation croissant.
--   Indice 1 : Page 2 = sauter les 3 premiers → OFFSET 3
--   Indice 2 : LIMIT 3 OFFSET 3

-- Exercice 3 : Affichez le 3ème médicament le moins cher uniquement. Colonnes : nom_medicament, prix_unitaire.
--   Indice 1 : ORDER BY prix_unitaire ASC pour du moins cher au plus cher.
--   Indice 2 : LIMIT 1 OFFSET 2 — saute les 2 premiers, prend le 3ème.


-- ---------------------------------------------------------------
-- LEÇON : 9. Pourcentage – Afficher X% des données
-- ---------------------------------------------------------------
-- En termes simples :
-- Pour afficher X% des données, calculez le nombre de lignes correspondant :
-- • Manuel : total × (X ÷ 100) = N, puis LIMIT N
-- • Dynamique : LIMIT (SELECT CAST(COUNT(*) * 0.30 AS INT) FROM table)
--
-- CAST(… AS INT) convertit le résultat décimal en entier (arrondi inférieur).
--
-- 📊 Vous avez 10 patients et voulez voir 30% des cas → 10 × 0,30 = 3. En SQL : LIMIT 3. La version dynamique calcule ce chiffre automatiquement, même si la table passe à 1 000 patients.

-- Exercice 1 : Affichez les 20% des patients les plus âgés (10 patients × 20% = 2 lignes). Colonnes : nom, prenom, age, triés par âge décroissant.
--   Indice 1 : 10 patients × 0.20 = 2 → LIMIT 2
--   Indice 2 : ORDER BY age DESC

-- Exercice 2 : Affichez les 50% des consultations les plus longues (10 consultations × 50% = 5 lignes). Colonnes : diagnostic, duree_min, triés par durée décroissante.
--   Indice 1 : 10 consultations × 0.50 = 5 → LIMIT 5
--   Indice 2 : ORDER BY duree_min DESC

-- Exercice 3 : Affichez les 30% des patients les plus âgés de façon dynamique — sans écrire 3 en dur. Utilisez une sous-requête dans LIMIT avec CAST et COUNT.
--   Indice 1 : LIMIT (SELECT CAST(COUNT(*) * 0.30 AS INT) FROM patients)
--   Indice 2 : SELECT nom, prenom, age FROM patients ORDER BY age DESC ...


-- ---------------------------------------------------------------
-- LEÇON : 7. Fonctions – UPPER, LOWER, LENGTH, CONCAT, ROUND, YEAR
-- ---------------------------------------------------------------
-- En termes simples :
-- SQL a des fonctions qui transforment les données à la volée, sans modifier la base :
-- • UPPER / LOWER → majuscules / minuscules
-- • LENGTH → nombre de caractères
-- • CONCAT → assembler du texte
-- • ROUND → arrondir un nombre
-- • YEAR / MONTH → extraire une partie d'une date
--
-- 🧮 Comme des formules Excel : UPPER=MAJUSCULE, LENGTH=NBCAR, CONCAT=CONCATENER, ROUND=ARRONDI, YEAR=ANNEE. En SQL, elles s'appliquent sur toutes les lignes d'un coup.

-- Exercice 1 : Affichez le nom en majuscules (colonne nom_maj), le prénom en minuscules (colonne prenom_min) et la longueur du nom (colonne longueur_nom) pour chaque patient.
--   Indice 1 : UPPER(nom) AS nom_maj, LOWER(prenom) AS prenom_min, LENGTH(nom) AS longueur_nom
--   Indice 2 : SELECT ... FROM patients

-- Exercice 2 : Affichez le nom complet (prénom + espace + nom) dans une colonne nom_complet et le mois d'admission dans une colonne mois pour chaque patient.
--   Indice 1 : CONCAT(prenom, ' ', nom) AS nom_complet
--   Indice 2 : MONTH(date_admission) AS mois

-- Exercice 3 : Depuis la table medicaments, affichez le nom du médicament, son prix unitaire original et son prix arrondi à 1 décimale (colonne prix_arrondi).
--   Indice 1 : ROUND(prix_unitaire, 1) AS prix_arrondi
--   Indice 2 : SELECT nom_medicament, prix_unitaire, ROUND(...) AS prix_arrondi FROM medicaments;


-- #####################################################################
-- NIVEAU : INTERMÉDIAIRE
-- #####################################################################

-- ---------------------------------------------------------------
-- LEÇON : 7. INNER JOIN – Joindre deux tables
-- ---------------------------------------------------------------
-- En termes simples :
-- JOIN (ou INNER JOIN) relie deux tables via une colonne commune — la clé étrangère (FK). Le résultat ne contient que les lignes qui ont une correspondance dans les deux tables.
--
-- 🔗 Les patients ont un medecin_id. Les médecins ont un id_medecin. JOIN les relie comme assembler deux pièces de puzzle : on obtient le nom du patient avec le nom de son médecin sur la même ligne.

-- Exercice 1 : Affichez le nom du patient, la date_consultation et le diagnostic pour chaque consultation.
--   Indice 1 : INNER JOIN consultations c
--   Indice 2 : ON p.id_patient = c.id_patient

-- Exercice 2 : Affichez le nom du patient, la chambre et la date_entree pour chaque hospitalisation.
--   Indice 1 : JOIN hospitalisations h ON p.id_patient = h.id_patient
--   Indice 2 : SELECT p.nom, h.chambre, h.date_entree

-- Exercice 3 : Affichez le nom du médecin, le diagnostic et la duree_min pour chaque consultation.
--   Indice 1 : JOIN du côté consultations → medecins
--   Indice 2 : ON c.medecin_id = m.id_medecin


-- ---------------------------------------------------------------
-- LEÇON : 8. LEFT JOIN – Garder tout à gauche
-- ---------------------------------------------------------------
-- En termes simples :
-- LEFT JOIN retourne TOUTES les lignes de la table de gauche, même si elles n'ont pas de correspondance à droite. Les colonnes droites seront NULL pour ces lignes.
--
-- Utile pour trouver des patients sans consultation, des médecins sans prescription, etc.
--
-- 📋 Avec INNER JOIN, un patient sans consultation disparaît du résultat. Avec LEFT JOIN, il reste visible — avec des cases vides pour la consultation. Idéal pour détecter les "oubliés".

-- Exercice 1 : Listez tous les patients avec leur diagnostic (NULL si aucune consultation).
--   Indice 1 : LEFT JOIN au lieu de INNER JOIN.
--   Indice 2 : ON p.id_patient = c.id_patient

-- Exercice 2 : Listez tous les patients avec leur chambre d'hospitalisation (NULL si non hospitalisé).
--   Indice 1 : LEFT JOIN hospitalisations h ON p.id_patient = h.id_patient
--   Indice 2 : SELECT p.nom, p.prenom, h.chambre

-- Exercice 3 : Listez tous les médecins avec le diagnostic de leurs consultations (NULL si aucune consultation).
--   Indice 1 : Partez de medecins et LEFT JOIN consultations
--   Indice 2 : ON m.id_medecin = c.medecin_id


-- ---------------------------------------------------------------
-- LEÇON : 9. COUNT / AVG / SUM / MIN / MAX
-- ---------------------------------------------------------------
-- En termes simples :
-- Les fonctions d'agrégation calculent une valeur à partir de plusieurs lignes :
-- • COUNT(*) : nombre total de lignes — COUNT(col) ignore les NULL
-- • AVG : moyenne
-- • SUM : total
-- • MAX / MIN : valeur la plus haute / la plus basse
--
-- 🧮 Équivalent des formules Excel : COUNT → NB(), AVG → MOYENNE(), SUM → SOMME(), MAX/MIN → MAX()/MIN(). En SQL, elles s'appliquent sur des colonnes entières de la base en une seule instruction.

-- Exercice 1 : Calculez : nombre total de patients, âge moyen, âge maximum et âge minimum.
--   Indice 1 : COUNT(*), AVG(age), MAX(age), MIN(age)
--   Indice 2 : Utilisez AS pour nommer chaque résultat.

-- Exercice 2 : Calculez la durée totale, la durée moyenne et la durée maximale des consultations.
--   Indice 1 : SUM(duree_min), AVG(duree_min), MAX(duree_min)
--   Indice 2 : FROM consultations

-- Exercice 3 : Calculez le coût journalier moyen, minimum et maximum des hospitalisations.
--   Indice 1 : AVG(cout_journalier), MIN(cout_journalier), MAX(cout_journalier)
--   Indice 2 : FROM hospitalisations


-- ---------------------------------------------------------------
-- LEÇON : 10. GROUP BY – Statistiques par groupe
-- ---------------------------------------------------------------
-- En termes simples :
-- GROUP BY regroupe les lignes ayant la même valeur dans une colonne, puis permet d'appliquer des fonctions d'agrégation sur chaque groupe.
--
-- GROUP_CONCAT concatène les textes d'un groupe en une seule chaîne séparée par un délimiteur.
--
-- 📊 Compter combien de patients sont dans chaque service. Sans GROUP BY vous obtenez une liste de 10 patients. Avec GROUP BY service vous obtenez 5 lignes : une par service avec son effectif.

-- Exercice 1 : Nombre de patients et âge moyen par service, du service le plus chargé au moins.
--   Indice 1 : GROUP BY service
--   Indice 2 : COUNT(*) AS nb_patients, AVG(age) AS age_moyen

-- Exercice 2 : Nombre de consultations et durée moyenne par médecin (medecin_id), triés par nombre décroissant.
--   Indice 1 : GROUP BY medecin_id
--   Indice 2 : COUNT(*) AS nb_consultations, AVG(duree_min) AS duree_moy

-- Exercice 3 : Pour chaque service, affichez la liste des noms de patients séparés par une virgule avec GROUP_CONCAT.
--   Indice 1 : GROUP_CONCAT(nom, ', ') AS liste_patients
--   Indice 2 : GROUP_CONCAT concatène toutes les valeurs du groupe en une seule chaîne.


-- ---------------------------------------------------------------
-- LEÇON : 11. HAVING – Filtrer les groupes
-- ---------------------------------------------------------------
-- En termes simples :
-- HAVING filtre les résultats après le regroupement GROUP BY. C'est le WHERE des agrégats.
--
-- Règle : WHERE filtre les lignes AVANT le groupement. HAVING filtre les groupes APRÈS le calcul.
--
-- 🏥 "Je veux les services qui ont plus de 3 patients hospitalisés." On ne peut pas le savoir avant de compter — donc HAVING, pas WHERE.

-- Exercice 1 : Listez les services ayant au moins 2 patients.
--   Indice 1 : GROUP BY service
--   Indice 2 : HAVING COUNT(*) >= 2

-- Exercice 2 : Listez les médecins (medecin_id) ayant fait au moins 2 consultations.
--   Indice 1 : GROUP BY medecin_id FROM consultations
--   Indice 2 : HAVING COUNT(*) >= 2

-- Exercice 3 : Listez les médicaments (id_medicament) prescrits avec une quantité totale supérieure à 30.
--   Indice 1 : GROUP BY id_medicament FROM prescriptions
--   Indice 2 : HAVING SUM(quantite) > 30


-- ---------------------------------------------------------------
-- LEÇON : 12. Jointure multiple – 3 tables
-- ---------------------------------------------------------------
-- En termes simples :
-- On peut enchaîner plusieurs JOIN dans la même requête pour relier 3 tables ou plus. Chaque JOIN ajoute une nouvelle table en indiquant sur quelle colonne la relier à celles déjà présentes.
--
-- 🔗🔗 Patient → Consultation → Prescription → Médicament : 3 JOIN successifs permettent de répondre à "Quel médicament a été prescrit à chaque patient lors de quelle consultation ?"

-- Exercice 1 : Listez le nom du patient, le diagnostic et le nom du médecin pour chaque consultation.
--   Indice 1 : Faites 2 JOIN : patients → consultations → medecins
--   Indice 2 : ON c.medecin_id = m.id_medecin pour le 2e JOIN

-- Exercice 2 : Affichez le nom du patient, la duree_min de consultation, et le nom et la spécialité du médecin.
--   Indice 1 : Même jointure : patients → consultations → medecins
--   Indice 2 : Ajoutez m.specialite dans le SELECT

-- Exercice 3 : Affichez le nom du patient, son service, et le nom et la spécialité de son médecin traitant (via patients.medecin_id).
--   Indice 1 : JOIN medecins m ON p.medecin_id = m.id_medecin (lien direct sans passer par consultations)
--   Indice 2 : SELECT p.nom, p.service, m.nom AS medecin, m.specialite


-- ---------------------------------------------------------------
-- LEÇON : 13. LIKE – Recherche de motifs
-- ---------------------------------------------------------------
-- En termes simples :
-- LIKE filtre du texte selon un motif. Deux wildcards (jokers) :
-- • % : remplace n'importe quelle séquence de caractères (zéro ou plus)
-- • _ : remplace exactement un caractère
--
-- '%cardiaque%' trouve tout texte contenant "cardiaque", où qu'il soit.
--
-- 🔍 Comme la barre de recherche d'un traitement de texte : WHERE diagnostic LIKE '%Cancer%' retrouve tous les diagnostics contenant ce mot, qu'il soit au début, au milieu ou à la fin.

-- Exercice 1 : Trouvez toutes les consultations dont le diagnostic contient le mot cardiaque.
--   Indice 1 : WHERE diagnostic LIKE '%...%'
--   Indice 2 : Le mot à chercher : cardiaque

-- Exercice 2 : Listez les patients dont le nom commence par la lettre M.
--   Indice 1 : WHERE nom LIKE 'M%'
--   Indice 2 : Le % remplace tout ce qui suit le M.

-- Exercice 3 : Listez les médicaments dont la catégorie commence par "Anti".
--   Indice 1 : WHERE categorie LIKE 'Anti%'
--   Indice 2 : La catégorie est la colonne categorie de la table medicaments.


-- #####################################################################
-- NIVEAU : AVANCÉ
-- #####################################################################

-- ---------------------------------------------------------------
-- LEÇON : 14. Sous-requêtes – Subqueries
-- ---------------------------------------------------------------
-- En termes simples :
-- Une sous-requête est un SELECT imbriqué dans un autre. Elle peut apparaître :
-- • dans WHERE : pour filtrer selon un résultat calculé dynamiquement
-- • dans FROM : pour créer une table temporaire
-- • dans SELECT : pour ajouter une colonne calculée
--
-- 🪆 "Listez les patients plus âgés que la moyenne" — il faut d'abord calculer la moyenne, puis comparer. La sous-requête calcule cette valeur à l'intérieur de la requête principale : WHERE age > (SELECT AVG(age) FROM patients)

-- Exercice 1 : Listez les patients dont l'âge est supérieur à la moyenne d'âge.
--   Indice 1 : WHERE age > (sous-requête)
--   Indice 2 : La sous-requête : SELECT AVG(age) FROM patients

-- Exercice 2 : Listez les consultations dont la durée est supérieure à la durée moyenne.
--   Indice 1 : WHERE duree_min > (SELECT AVG(duree_min) FROM consultations)
--   Indice 2 : SELECT diagnostic, duree_min, medecin_id FROM consultations

-- Exercice 3 : Listez les médecins dont le salaire est supérieur au salaire moyen.
--   Indice 1 : WHERE salaire > (SELECT AVG(salaire) FROM medecins)
--   Indice 2 : SELECT nom, specialite, salaire FROM medecins


-- ---------------------------------------------------------------
-- LEÇON : 15. CTE – WITH … AS
-- ---------------------------------------------------------------
-- En termes simples :
-- WITH … AS crée une CTE (Common Table Expression) : une table temporaire nommée, définie en haut de la requête et réutilisée ensuite. Elle rend le code plus lisible qu'une sous-requête imbriquée.
--
-- La CTE n'est pas stockée en base — elle n'existe que pendant l'exécution de la requête.
--
-- 📝 Comme écrire un brouillon nommé en haut de la page ("patients seniors = ceux de 65 ans et plus"), puis s'y référer plus bas. Au lieu d'écrire la définition plusieurs fois, on lui donne un nom.

-- Exercice 1 : Avec un CTE patients_seniors (age >= 65), comptez combien de consultations ont ces patients.
--   Indice 1 : WITH patients_seniors AS (SELECT * FROM patients WHERE age >= 65)
--   Indice 2 : Le CTE filtre, le SELECT principal compte.

-- Exercice 2 : Avec un CTE consult_longues (duree_min > 40), affichez le diagnostic et le nom du médecin.
--   Indice 1 : WITH consult_longues AS (SELECT * FROM consultations WHERE duree_min > 40)
--   Indice 2 : JOIN medecins m ON consult_longues.medecin_id = m.id_medecin

-- Exercice 3 : Avec un CTE medecins_top (salaire > 8500), listez les patients de ces médecins (via patients.medecin_id).
--   Indice 1 : WITH medecins_top AS (SELECT * FROM medecins WHERE salaire > 8500)
--   Indice 2 : JOIN sur p.medecin_id = mt.id_medecin


-- ---------------------------------------------------------------
-- LEÇON : 16. CASE WHEN – Logique conditionnelle
-- ---------------------------------------------------------------
-- En termes simples :
-- CASE WHEN est un "si/alors/sinon" dans SQL. Il crée une nouvelle colonne calculée dont la valeur dépend d'une condition.
--
-- Structure : CASE WHEN condition THEN valeur ELSE autre_valeur END
--
-- 💊 "Si l'âge est supérieur à 65, afficher 'Gériatrie', sinon afficher 'Standard'." C'est exactement la fonction SI() d'Excel, en plus flexible.

-- Exercice 1 : Ajoutez une colonne priorite : "Haute" si Oncologie ou Cardiologie, "Normale" sinon.
--   Indice 1 : CASE WHEN service IN ('Oncologie', 'Cardiologie') THEN 'Haute'
--   Indice 2 : ELSE 'Normale' END AS priorite

-- Exercice 2 : Ajoutez une colonne tranche_age : "Jeune" (< 40), "Adulte" (40 à 65), "Senior" (> 65).
--   Indice 1 : CASE WHEN age < 40 THEN 'Jeune' WHEN age <= 65 THEN 'Adulte' ELSE 'Senior' END
--   Indice 2 : SELECT nom, age, CASE WHEN ... END AS tranche_age

-- Exercice 3 : Sur les consultations, ajoutez une colonne duree_cat : "Courte" (< 30 min), "Normale" (30-50), "Longue" (> 50).
--   Indice 1 : CASE WHEN duree_min < 30 THEN 'Courte' WHEN duree_min <= 50 THEN 'Normale' ELSE 'Longue' END
--   Indice 2 : SELECT diagnostic, duree_min, CASE WHEN ... END AS duree_cat


-- ---------------------------------------------------------------
-- LEÇON : 17. Détecter les doublons
-- ---------------------------------------------------------------
-- En termes simples :
-- Pour trouver les doublons : regroupez avec GROUP BY sur la colonne à tester, puis filtrez avec HAVING COUNT(*) > 1 pour ne garder que les groupes ayant plusieurs lignes.
--
-- C'est la question classique d'entretien : "Comment détecter les doublons ?"
--
-- 🔁 Si un patient apparaît deux fois dans consultations, son id_patient aura COUNT(*) = 2. HAVING COUNT(*) > 1 isole exactement ces cas — comme le filtre "doublons" dans Excel.

-- Exercice 1 : Trouvez les patients ayant eu plusieurs consultations (id_patient apparaissant plus d'une fois dans consultations).
--   Indice 1 : SELECT id_patient, COUNT(*) AS nb_consultations FROM consultations
--   Indice 2 : GROUP BY id_patient

-- Exercice 2 : Trouvez les patients ayant été hospitalisés plusieurs fois (id_patient dans hospitalisations avec COUNT > 1).
--   Indice 1 : SELECT id_patient, COUNT(*) FROM hospitalisations
--   Indice 2 : GROUP BY id_patient

-- Exercice 3 : Trouvez les médicaments (id_medicament) prescrits plus d'une fois dans les prescriptions.
--   Indice 1 : SELECT id_medicament, COUNT(*) FROM prescriptions
--   Indice 2 : GROUP BY id_medicament HAVING COUNT(*) > 1


-- ---------------------------------------------------------------
-- LEÇON : 18. Patients sans consultation – Anti-JOIN
-- ---------------------------------------------------------------
-- En termes simples :
-- Pour trouver les éléments d'une table qui n'ont aucune correspondance dans une autre, deux approches :
-- • LEFT JOIN + IS NULL : jointure gauche, puis filtrer les lignes sans correspondance
-- • NOT IN (sous-requête) : exclure les IDs présents dans l'autre table
--
-- 🔍 "Quels patients n'ont aucune consultation ?" Avec LEFT JOIN, ils apparaissent avec des colonnes NULL côté consultations. WHERE c.id_consultation IS NULL les isole.

-- Exercice 1 : Listez les patients qui n'ont aucune consultation enregistrée.
--   Indice 1 : LEFT JOIN consultations c ON p.id_patient = c.id_patient
--   Indice 2 : WHERE c.id_consultation IS NULL

-- Exercice 2 : Listez les patients qui n'ont aucune hospitalisation enregistrée.
--   Indice 1 : LEFT JOIN hospitalisations h ON p.id_patient = h.id_patient
--   Indice 2 : WHERE h.id_hosp IS NULL

-- Exercice 3 : Listez les médecins qui n'ont aucune consultation (id_medecin absent de consultations).
--   Indice 1 : WHERE id_medecin NOT IN (SELECT medecin_id FROM consultations)
--   Indice 2 : SELECT nom, specialite FROM medecins


-- ---------------------------------------------------------------
-- LEÇON : 19. Fonctions de date
-- ---------------------------------------------------------------
-- En termes simples :
-- SQL propose des fonctions pour manipuler les dates :
-- • YEAR(date) / MONTH(date) : extrait l'année ou le mois
-- • Ces fonctions permettent de grouper des données par mois, année, trimestre…
--
-- Exemple : compter les consultations par mois avec GROUP BY MONTH(date_consultation).
--
-- 📅 Grouper les consultations par mois pour voir les pics d'activité saisonniers, sans trier manuellement chaque date. MONTH(date_admission) retourne un nombre de 1 à 12.

-- Exercice 1 : Comptez le nombre de consultations par mois. Affichez le mois et le nombre.
--   Indice 1 : MONTH(date_consultation) AS mois
--   Indice 2 : GROUP BY mois

-- Exercice 2 : Comptez le nombre d'admissions de patients par mois (date_admission). Affichez le mois et le nombre.
--   Indice 1 : MONTH(date_admission) AS mois FROM patients
--   Indice 2 : GROUP BY mois

-- Exercice 3 : Listez uniquement les consultations du mois 11 (novembre). Affichez date_consultation, diagnostic, duree_min.
--   Indice 1 : WHERE MONTH(date_consultation) = 11
--   Indice 2 : SELECT date_consultation, diagnostic, duree_min FROM consultations


-- ---------------------------------------------------------------
-- LEÇON : 20. COALESCE & NULLIF
-- ---------------------------------------------------------------
-- En termes simples :
-- COALESCE(a, b) retourne la première valeur non-NULL de sa liste. Si a est NULL, retourne b.
--
-- NULLIF(a, b) retourne NULL si a = b, sinon retourne a. Souvent utilisé pour éviter une division par zéro.
--
-- 🏥 COALESCE(date_sortie, 'En cours') : si la date de sortie est NULL (patient encore hospitalisé), affiche "En cours". NULLIF(prix, 0) : retourne NULL si le prix vaut 0, évitant une division par zéro.

-- Exercice 1 : Listez les hospitalisations avec la date_sortie remplacée par "Toujours hospitalisé" si NULL.
--   Indice 1 : COALESCE(date_sortie, 'Toujours hospitalisé') AS date_sortie
--   Indice 2 : SELECT id_patient, chambre, date_entree, COALESCE(...) AS date_sortie FROM hospitalisations

-- Exercice 2 : Affichez id_hosp, chambre, cout_journalier et une colonne statut_sortie = date_sortie ou "En cours" si NULL, ordonné par id_hosp.
--   Indice 1 : COALESCE(date_sortie, 'En cours') AS statut_sortie
--   Indice 2 : SELECT id_hosp, chambre, cout_journalier, COALESCE(date_sortie, 'En cours') AS statut_sortie

-- Exercice 3 : Affichez les médicaments avec une colonne prix_ajuste qui vaut NULL si le prix est 0.15 (Lisinopril), sinon le prix normal.
--   Indice 1 : NULLIF(prix_unitaire, 0.15) AS prix_ajuste
--   Indice 2 : SELECT nom_medicament, prix_unitaire, NULLIF(prix_unitaire, 0.15) AS prix_ajuste


-- #####################################################################
-- NIVEAU : EXPERT
-- #####################################################################

-- ---------------------------------------------------------------
-- LEÇON : 21. RANK() / ROW_NUMBER() OVER
-- ---------------------------------------------------------------
-- En termes simples :
-- Les fonctions de fenêtrage (OVER) calculent des valeurs sur un groupe de lignes sans les regrouper — chaque ligne garde son identité dans le résultat.
--
-- PARTITION BY définit le groupe. ORDER BY dans OVER définit l'ordre dans ce groupe.
--
-- 📊 Calculer le rang de chaque patient dans son service selon son âge, sans fusionner les lignes de patients. Chaque patient reste visible avec son rang calculé à côté.

-- Exercice 1 : Classez les consultations par durée décroissante par médecin (PARTITION BY medecin_id). Affichez medecin_id, diagnostic, duree_min et rang.
--   Indice 1 : RANK() OVER (PARTITION BY medecin_id ORDER BY duree_min DESC) AS rang
--   Indice 2 : SELECT medecin_id, diagnostic, duree_min, RANK()...

-- Exercice 2 : Classez tous les patients par âge décroissant avec ROW_NUMBER() (sans PARTITION). Affichez nom, age et rang.
--   Indice 1 : ROW_NUMBER() OVER (ORDER BY age DESC) AS rang
--   Indice 2 : Pas de PARTITION BY ici — tous les patients ensemble.

-- Exercice 3 : Classez les patients par âge décroissant par service (PARTITION BY service) avec RANK(). Affichez nom, service, age et rang.
--   Indice 1 : RANK() OVER (PARTITION BY service ORDER BY age DESC) AS rang
--   Indice 2 : SELECT nom, service, age, RANK() ...


-- ---------------------------------------------------------------
-- LEÇON : 22. SUM / AVG OVER – Cumul & Moyenne glissante
-- ---------------------------------------------------------------
-- En termes simples :
-- SUM() OVER (ORDER BY …) calcule un total cumulé : chaque ligne affiche la somme de toutes les lignes précédentes plus la sienne.
--
-- AVG() OVER (ORDER BY …) calcule une moyenne glissante : la moyenne de toutes les lignes vues jusqu'à la courante.
--
-- 📈 Sur un relevé bancaire, le "solde courant" est un cumul : chaque ligne ajoute le montant au total précédent. SUM(cout_journalier) OVER (ORDER BY id_hosp) fait exactement ça sur les hospitalisations.

-- Exercice 1 : Total cumulé de minutes de consultation par ordre de date. Affichez date, durée et cumul.
--   Indice 1 : SUM(duree_min) OVER (ORDER BY date_consultation) AS cumul_minutes
--   Indice 2 : SELECT date_consultation, duree_min, SUM(duree_min) OVER (ORDER BY date_consultation) AS cumul_minutes

-- Exercice 2 : Total cumulé du coût journalier des hospitalisations par ordre d'id_hosp. Affichez id_hosp, chambre, cout_journalier et cumul.
--   Indice 1 : SUM(cout_journalier) OVER (ORDER BY id_hosp) AS cumul_cout
--   Indice 2 : SELECT id_hosp, chambre, cout_journalier, SUM(...) OVER (...) AS cumul_cout

-- Exercice 3 : Moyenne glissante de la durée des consultations par ordre de date. Affichez date_consultation, duree_min et la moyenne glissante.
--   Indice 1 : AVG(duree_min) OVER (ORDER BY date_consultation) AS moy_glissante
--   Indice 2 : SELECT date_consultation, duree_min, AVG(...) OVER (...) AS moy_glissante


-- ---------------------------------------------------------------
-- LEÇON : 23. LAG / LEAD – Valeurs décalées
-- ---------------------------------------------------------------
-- En termes simples :
-- LAG(col, n) accède à la valeur de la ligne N rangs avant dans la fenêtre. LEAD(col, n) accède à la ligne N rangs après. Permet des calculs de variation entre lignes consécutives.
--
-- ⏪⏩ Sur une série de consultations triées par date : LAG(date_consultation, 1) donne la date de la consultation précédente. Permet de calculer le délai entre deux visites.

-- Exercice 1 : Pour chaque consultation, affichez la durée de la consultation précédente (LAG) par ordre de date.
--   Indice 1 : LAG(duree_min, 1) OVER (ORDER BY date_consultation) AS duree_precedente
--   Indice 2 : SELECT date_consultation, duree_min, LAG(duree_min, 1) OVER (ORDER BY date_consultation) AS duree_precedente

-- Exercice 2 : Pour chaque consultation, affichez la durée de la consultation suivante (LEAD) par ordre de date.
--   Indice 1 : LEAD(duree_min, 1) OVER (ORDER BY date_consultation) AS duree_suivante
--   Indice 2 : SELECT date_consultation, duree_min, LEAD(duree_min, 1) OVER (ORDER BY date_consultation) AS duree_suivante

-- Exercice 3 : Pour chaque consultation, affichez la durée précédente par médecin (PARTITION BY medecin_id, LAG) par ordre de date.
--   Indice 1 : LAG(duree_min, 1) OVER (PARTITION BY medecin_id ORDER BY date_consultation) AS duree_prec
--   Indice 2 : SELECT medecin_id, date_consultation, duree_min, LAG(...) OVER (...) AS duree_prec


-- ---------------------------------------------------------------
-- LEÇON : 24. Deuxième valeur la plus haute
-- ---------------------------------------------------------------
-- En termes simples :
-- Trouver la 2ème valeur la plus haute : deux approches :
-- • LIMIT + OFFSET : trier en DESC et sauter la 1ère ligne avec OFFSET 1
-- • Sous-requête : SELECT MAX(col) WHERE col < (SELECT MAX(col) …)
--
-- DISTINCT évite que des valeurs égales bloquent le résultat.
--
-- 🥈 "Quel est le 2ème salaire le plus élevé ?" Avec OFFSET : classer, puis sauter la 1ère ligne. Sans OFFSET : prendre le max des salaires inférieurs au max absolu.

-- Exercice 1 : Trouvez le 2ème salaire le plus élevé parmi les médecins (sans utiliser OFFSET).
--   Indice 1 : Approche : SELECT MAX(salaire) WHERE salaire < (SELECT MAX(salaire) ...)
--   Indice 2 : La sous-requête retourne le salaire max, la requête principale prend le max en dessous.

-- Exercice 2 : Trouvez la 2ème durée la plus longue parmi les consultations (utilisez LIMIT + OFFSET).
--   Indice 1 : SELECT DISTINCT duree_min FROM consultations ORDER BY duree_min DESC LIMIT 1 OFFSET 1
--   Indice 2 : OFFSET 1 saute la première ligne (la plus longue).

-- Exercice 3 : Trouvez l'âge du 3ème patient le plus âgé (utilisez LIMIT + OFFSET).
--   Indice 1 : SELECT DISTINCT age FROM patients ORDER BY age DESC
--   Indice 2 : LIMIT 1 OFFSET 2 pour la 3ème valeur


-- ---------------------------------------------------------------
-- LEÇON : 25. INDEX & EXPLAIN – Optimisation
-- ---------------------------------------------------------------
-- En termes simples :
-- Un index est une structure qui accélère les recherches sur une colonne — comme l'index d'un livre qui évite de lire toutes les pages.
--
-- EXPLAIN affiche le plan d'exécution d'une requête : comment SQL va la résoudre, si un index est utilisé, combien de lignes seront parcourues.
--
-- 📚 Sans index, SQL lit chaque ligne de la table (scan complet). Avec CREATE INDEX idx_service ON patients(service), les recherches WHERE service = 'Cardiologie' deviennent quasi-instantanées.

-- Exercice 1 : Créez un index idx_service sur la colonne service de la table patients.
--   Indice 1 : CREATE INDEX nom ON table(colonne);
--   Indice 2 : Le nom de l'index est idx_service.

-- Exercice 2 : Analysez le plan d'exécution d'un SELECT sur consultations filtré par medecin_id = 2.
--   Indice 1 : EXPLAIN SELECT ... FROM consultations WHERE medecin_id = 2
--   Indice 2 : EXPLAIN retourne le plan de la requête sans l'exécuter.

-- Exercice 3 : Créez un index idx_patient_consult sur la colonne id_patient de la table consultations.
--   Indice 1 : CREATE INDEX nom ON table(colonne);
--   Indice 2 : Cet index accélère les JOIN sur patients ↔ consultations.


-- ---------------------------------------------------------------
-- LEÇON : 26. UNION / UNION ALL – Combiner des résultats
-- ---------------------------------------------------------------
-- En termes simples :
-- UNION combine les résultats de deux SELECT en empilant les lignes. Les colonnes doivent correspondre en nombre et en type.
-- UNION ALL garde les doublons. UNION les supprime.
--
-- 📚 Fusionner deux listes de patients (deux hôpitaux différents) en une seule. UNION supprime les doublons si un patient apparaît dans les deux listes. UNION ALL garde tout.

-- Exercice 1 : Combinez avec UNION la liste des noms de patients et la liste des noms de médecins en une seule colonne nom.
--   Indice 1 : UNION dédoublonne automatiquement les noms identiques.
--   Indice 2 : Les deux SELECT doivent retourner le même nombre de colonnes.

-- Exercice 2 : Combinez avec UNION ALL les noms de patients et de médecins (sans dédoublonner). Combien de lignes obtenez-vous ?
--   Indice 1 : SELECT nom FROM patients UNION ALL SELECT nom FROM medecins;
--   Indice 2 : UNION ALL conserve tous les doublons — le résultat a plus de lignes que UNION.

-- Exercice 3 : Créez une liste combinée avec une colonne type : "Patient" pour les patients, "Médecin" pour les médecins.
--   Indice 1 : SELECT nom, 'Patient' AS type FROM patients
--   Indice 2 : UNION SELECT nom, 'Médecin' AS type FROM medecins


-- ---------------------------------------------------------------
-- LEÇON : 27. EXISTS / NOT EXISTS – Sous-requête d'existence
-- ---------------------------------------------------------------
-- En termes simples :
-- EXISTS retourne vrai si la sous-requête retourne au moins une ligne. NOT EXISTS retourne vrai si elle est vide.
--
-- Plus performant que IN sur les grandes tables : SQL s'arrête dès qu'il trouve une première correspondance.
--
-- ✅ "Le patient a-t-il au moins une consultation ?" EXISTS vérifie l'existence sans récupérer toutes les données. Comme demander "y a-t-il un médecin disponible ?" plutôt que "liste tous les médecins disponibles."

-- Exercice 1 : Listez les patients qui ont au moins une consultation (utilisez EXISTS).
--   Indice 1 : WHERE EXISTS (SELECT 1 FROM consultations c WHERE c.id_patient = p.id_patient)
--   Indice 2 : EXISTS est plus performant que IN sur les grandes tables.

-- Exercice 2 : Listez les patients qui n'ont aucune hospitalisation (utilisez NOT EXISTS).
--   Indice 1 : WHERE NOT EXISTS (SELECT 1 FROM hospitalisations h WHERE h.id_patient = p.id_patient)
--   Indice 2 : SELECT p.nom, p.prenom FROM patients p

-- Exercice 3 : Listez les médecins qui ont au moins une consultation enregistrée (utilisez EXISTS).
--   Indice 1 : WHERE EXISTS (SELECT 1 FROM consultations c WHERE c.medecin_id = m.id_medecin)
--   Indice 2 : SELECT m.nom, m.specialite FROM medecins m


-- ---------------------------------------------------------------
-- LEÇON : 28. Fonctions de chaînes – UPPER, LOWER, LENGTH, SUBSTRING
-- ---------------------------------------------------------------
-- En termes simples :
-- Fonctions avancées de chaînes : SUBSTRING/SUBSTR extrait une portion de texte à partir d'une position. INSTR trouve la position d'un caractère. Utiles pour nettoyer ou transformer des données textuelles.
--
-- ✂️ Extraire le code postal des 5 derniers caractères d'une adresse, ou trouver la position du tiret dans un code de chambre "A-101".

-- Exercice 1 : Affichez le nom en majuscules, le prénom en minuscules et la longueur du nom pour chaque patient.
--   Indice 1 : UPPER(nom) AS nom_maj, LOWER(prenom) AS prenom_min, LENGTH(nom) AS longueur_nom
--   Indice 2 : Trois fonctions dans le même SELECT.

-- Exercice 2 : Affichez la spécialité en majuscules et la longueur du nom de chaque médecin.
--   Indice 1 : UPPER(specialite) AS specialite_maj, LENGTH(nom) AS longueur_nom
--   Indice 2 : Deux fonctions appliquées sur la table medecins.

-- Exercice 3 : Affichez les 3 premiers caractères du nom de chaque patient avec SUBSTRING.
--   Indice 1 : SUBSTRING(nom, 1, 3) AS initiales — position 1, longueur 3
--   Indice 2 : SUBSTRING(chaîne, position_départ, longueur)


-- ---------------------------------------------------------------
-- LEÇON : 29. CONCAT & Concaténation
-- ---------------------------------------------------------------
-- En termes simples :
-- CONCAT(a, b, c) assemble plusieurs textes en un seul. On peut aussi utiliser l'opérateur || (standard SQL).
--
-- Utile pour construire des noms complets, des libellés formatés, ou des clés composites directement dans la requête.
--
-- 🔤 CONCAT(prenom, ' ', nom) crée "Sophie Martin" à partir de deux colonnes séparées — comme la formule =A1&" "&B1 dans Excel, mais appliquée à toute la table d'un coup.

-- Exercice 1 : Affichez le nom complet (prenom + espace + nom) de chaque patient dans une colonne appelée nom_complet.
--   Indice 1 : CONCAT(prenom, ' ', nom) AS nom_complet
--   Indice 2 : Vous pouvez aussi écrire : prenom || ' ' || nom AS nom_complet

-- Exercice 2 : Affichez une colonne fiche pour chaque médecin au format : "nom - spécialité".
--   Indice 1 : CONCAT(nom, ' - ', specialite) AS fiche
--   Indice 2 : Exemple attendu : "Dr. Fontaine - Cardiologie"

-- Exercice 3 : Affichez une colonne patient_service au format : "nom (service)" pour chaque patient.
--   Indice 1 : CONCAT(nom, ' (', service, ')') AS patient_service
--   Indice 2 : Exemple attendu : "Martin (Cardiologie)"


-- ---------------------------------------------------------------
-- LEÇON : 30. INSERT INTO – Insérer des données
-- ---------------------------------------------------------------
-- En termes simples :
-- INSERT INTO ajoute une nouvelle ligne dans une table. On précise les colonnes et les valeurs dans le même ordre.
--
-- Les colonnes omises reçoivent NULL ou leur valeur par défaut. Les textes vont entre guillemets simples, les nombres sans.
--
-- 📝 Admettre un nouveau patient en base : on remplit les colonnes (nom, age, service…) avec ses informations. La BD vérifie la cohérence des types avant d'accepter la nouvelle ligne.

-- Exercice 1 : Insérez un nouveau patient : nom Dupont, prenom Alice, age 45, sexe F, service Cardiologie. Puis vérifiez avec un SELECT.
--   Indice 1 : INSERT INTO patients (nom, prenom, age, sexe, service) VALUES ('Dupont', 'Alice', 45, 'F', 'Cardiologie');
--   Indice 2 : Les valeurs texte sont entre guillemets simples, les nombres non.

-- Exercice 2 : Insérez un nouveau médicament : id_medicament 8, nom Paracétamol, catégorie Antalgique, prix 0.05. Vérifiez ensuite.
--   Indice 1 : INSERT INTO medicaments (id_medicament, nom_medicament, categorie, prix_unitaire)
--   Indice 2 : VALUES (8, 'Paracétamol', 'Antalgique', 0.05)

-- Exercice 3 : Insérez une nouvelle prescription : id_prescription 8, id_consultation 1, id_medicament 7, quantite 20, duree_jours 30. Vérifiez.
--   Indice 1 : INSERT INTO prescriptions (id_prescription, id_consultation, id_medicament, quantite, duree_jours)
--   Indice 2 : VALUES (8, 1, 7, 20, 30)


-- ---------------------------------------------------------------
-- LEÇON : 31. UPDATE – Modifier des données
-- ---------------------------------------------------------------
-- En termes simples :
-- UPDATE … SET modifie des lignes existantes. La clause WHERE est indispensable pour cibler les bonnes lignes — sans WHERE, toutes les lignes de la table sont modifiées.
--
-- On peut modifier plusieurs colonnes en même temps en séparant les affectations par des virgules.
--
-- ⚠️ UPDATE sans WHERE = modifier tous les dossiers patients d'un coup. Toujours cibler : UPDATE patients SET statut = 'Hospitalisé' WHERE id_patient = 3.

-- Exercice 1 : Modifiez le statut du patient id_patient = 3 en 'Hospitalisé'. Vérifiez après.
--   Indice 1 : UPDATE patients SET statut = 'Hospitalisé' WHERE id_patient = 3;
--   Indice 2 : Ne pas oublier le WHERE sinon TOUS les patients sont modifiés.

-- Exercice 2 : Augmentez le salaire du médecin id_medecin = 1 de 500 € (SET salaire = salaire + 500). Vérifiez.
--   Indice 1 : UPDATE medecins SET salaire = salaire + 500 WHERE id_medecin = 1;
--   Indice 2 : Vous pouvez utiliser une expression : salaire = salaire + 500

-- Exercice 3 : Mettez à jour la date_sortie de l'hospitalisation id_hosp = 2 à '2024-11-20'. Vérifiez.
--   Indice 1 : UPDATE hospitalisations SET date_sortie = '2024-11-20' WHERE id_hosp = 2;
--   Indice 2 : Vérifiez avec SELECT * FROM hospitalisations WHERE id_hosp = 2;


-- ---------------------------------------------------------------
-- LEÇON : 32. DELETE – Supprimer des données
-- ---------------------------------------------------------------
-- En termes simples :
-- Combinaison de DML (INSERT, UPDATE, DELETE) dans des scénarios réalistes : mettre à jour un salaire puis vérifier le résultat, ajouter une prescription puis la lire, etc.
--
-- 🔄 En pratique, les bases de données sont modifiées en permanence. Maîtriser INSERT + UPDATE + DELETE permet de maintenir les données à jour et cohérentes.

-- Exercice 1 : Supprimez les prescriptions dont la durée est inférieure à 20 jours. Vérifiez après.
--   Indice 1 : DELETE FROM prescriptions WHERE duree_jours < 20;
--   Indice 2 : Le WHERE est essentiel pour ne pas supprimer toutes les lignes.

-- Exercice 2 : Supprimez les hospitalisations dont la date_sortie est antérieure au 2024-11-01. Vérifiez.
--   Indice 1 : DELETE FROM hospitalisations WHERE date_sortie < '2024-11-01'
--   Indice 2 : Les dates sont stockées en texte au format YYYY-MM-DD, la comparaison alphabétique fonctionne.

-- Exercice 3 : Supprimez toutes les consultations du médecin id = 5 (medecin_id = 5). Vérifiez.
--   Indice 1 : DELETE FROM consultations WHERE medecin_id = 5;
--   Indice 2 : Vérifiez avec SELECT * FROM consultations WHERE medecin_id = 5;


-- ---------------------------------------------------------------
-- LEÇON : 33. CREATE VIEW – Créer une vue
-- ---------------------------------------------------------------
-- En termes simples :
-- Une vue est une table virtuelle définie par une requête SELECT. Elle ne stocke pas de données — elle les calcule à la demande.
--
-- CREATE VIEW nom AS SELECT … crée la vue. Elle s'utilise ensuite comme une table ordinaire. DROP VIEW la supprime.
--
-- 🪟 Comme un onglet Excel qui affiche automatiquement les résultats d'une formule. La vue vue_seniors filtre toujours les patients de 65 ans et plus, même si de nouveaux patients sont ajoutés.

-- Exercice 1 : Créez une vue vue_seniors contenant les patients de 65 ans et plus (nom, prenom, age, service), puis faites un SELECT dessus.
--   Indice 1 : CREATE VIEW vue_seniors AS SELECT nom, prenom, age, service FROM patients WHERE age >= 65;
--   Indice 2 : Une vue se comporte comme une table dans les requêtes suivantes.

-- Exercice 2 : Créez une vue vue_consultations_longues (duree_min > 40), puis listez les diagnostics et durées de cette vue.
--   Indice 1 : CREATE VIEW vue_consultations_longues AS SELECT * FROM consultations WHERE duree_min > 40;
--   Indice 2 : Ensuite : SELECT diagnostic, duree_min FROM vue_consultations_longues;

-- Exercice 3 : Créez une vue vue_patients_medecins joignant patients et médecins traitants (nom patient, service, nom médecin), puis sélectionnez-la.
--   Indice 1 : CREATE VIEW vue_patients_medecins AS SELECT p.nom AS patient, p.service, m.nom AS medecin FROM patients p JOIN medecins m ON p.medecin_id = m.id_medecin;
--   Indice 2 : Ensuite : SELECT * FROM vue_patients_medecins;


-- ---------------------------------------------------------------
-- LEÇON : 34. DDL – CREATE TABLE & ALTER TABLE
-- ---------------------------------------------------------------
-- En termes simples :
-- Les types de données définissent ce qu'une colonne peut stocker :
-- • INTEGER : nombre entier
-- • REAL / DECIMAL : nombre décimal
-- • TEXT / VARCHAR : texte
-- • DATE / DATETIME : date et heure
--
-- Choisir le bon type garantit l'intégrité des données.
--
-- 📏 Comme choisir le bon type de case sur un formulaire : case à cocher (booléen), champ numérique (INTEGER), champ texte libre (TEXT), calendrier (DATE).

-- Exercice 1 : Créez une table notes_medicales avec les colonnes : id_note INTEGER, id_patient INTEGER, note TEXT, date_note TEXT. Vérifiez.
--   Indice 1 : CREATE TABLE notes_medicales (id_note INTEGER, id_patient INTEGER, note TEXT, date_note TEXT);
--   Indice 2 : La table sera vide, c'est normal.

-- Exercice 2 : Ajoutez une colonne telephone TEXT à la table patients, puis affichez nom et telephone de 3 patients.
--   Indice 1 : ALTER TABLE patients ADD telephone TEXT;
--   Indice 2 : Ensuite : SELECT nom, telephone FROM patients LIMIT 3;

-- Exercice 3 : Créez une table bilans_sanguins avec : id_bilan INTEGER, id_patient INTEGER, date_bilan TEXT, resultat TEXT. Vérifiez.
--   Indice 1 : CREATE TABLE bilans_sanguins (id_bilan INTEGER, id_patient INTEGER, date_bilan TEXT, resultat TEXT);
--   Indice 2 : SELECT * FROM bilans_sanguins; — la table sera vide.


-- ---------------------------------------------------------------
-- LEÇON : 35. DENSE_RANK() & NTILE()
-- ---------------------------------------------------------------
-- En termes simples :
-- DENSE_RANK() attribue un rang sans saut en cas d'égalité (1,1,2 — pas 1,1,3 comme RANK).
--
-- NTILE(n) divise les lignes en n groupes de taille égale : quartiles avec NTILE(4), déciles avec NTILE(10).
--
-- 📊 DENSE_RANK : deux ex-aequo en 1ère place → le suivant est 2ème, pas 3ème. NTILE(4) : diviser les patients en 4 groupes d'âge égaux pour une analyse épidémiologique par tranche.

-- Exercice 1 : Divisez les médecins en 3 groupes de salaire (NTILE) et affichez aussi leur DENSE_RANK par salaire décroissant.
--   Indice 1 : NTILE(3) OVER (ORDER BY salaire) AS groupe_salaire
--   Indice 2 : DENSE_RANK() OVER (ORDER BY salaire DESC) AS rang_salaire

-- Exercice 2 : Divisez les patients en 4 quartiles par âge croissant (NTILE(4)). Affichez nom, age et quartile.
--   Indice 1 : NTILE(4) OVER (ORDER BY age) AS quartile
--   Indice 2 : NTILE(4) crée 4 groupes de taille égale (ou quasi-égale).

-- Exercice 3 : Classez les patients par âge décroissant avec DENSE_RANK. Affichez nom, age et rang, ordonné par rang.
--   Indice 1 : DENSE_RANK() OVER (ORDER BY age DESC) AS rang
--   Indice 2 : DENSE_RANK ne laisse pas de trous dans la numérotation, contrairement à RANK.


-- ---------------------------------------------------------------
-- LEÇON : 36. FIRST_VALUE() & LAST_VALUE()
-- ---------------------------------------------------------------
-- En termes simples :
-- FIRST_VALUE / LAST_VALUE retournent la première ou dernière valeur dans une fenêtre. SUM() OVER calcule un cumul progressif (running total) ligne par ligne.
--
-- 📈 Calculer un cumul des coûts d'hospitalisation au fil des jours — chaque ligne affiche le total cumulé jusqu'à cette date, comme un relevé de compte.

-- Exercice 1 : Pour chaque patient, affichez le salaire du médecin le moins payé de son service via FIRST_VALUE.
--   Indice 1 : Faites un JOIN patients ↔ medecins sur service
--   Indice 2 : FIRST_VALUE(m.salaire) OVER (PARTITION BY p.service ORDER BY m.salaire) AS salaire_min_service

-- Exercice 2 : Pour chaque consultation, affichez la durée minimale des consultations de ce médecin via FIRST_VALUE.
--   Indice 1 : FIRST_VALUE(duree_min) OVER (PARTITION BY medecin_id ORDER BY duree_min) AS duree_min_medecin
--   Indice 2 : SELECT medecin_id, diagnostic, duree_min, FIRST_VALUE(duree_min) OVER (PARTITION BY medecin_id ORDER BY duree_min) AS duree_min_medecin

-- Exercice 3 : Pour chaque patient, affichez l'âge du plus jeune patient de son service via FIRST_VALUE.
--   Indice 1 : FIRST_VALUE(age) OVER (PARTITION BY service ORDER BY age) AS plus_jeune_service
--   Indice 2 : SELECT nom, service, age, FIRST_VALUE(age) OVER (PARTITION BY service ORDER BY age) AS plus_jeune_service


-- ---------------------------------------------------------------
-- LEÇON : 37. VARIANCE & STDDEV – Statistiques
-- ---------------------------------------------------------------
-- En termes simples :
-- VARIANCE et STDDEV mesurent la dispersion des données autour de la moyenne. Une forte variance = les valeurs sont très étalées. Une faible variance = elles sont regroupées.
--
-- 📉 La durée moyenne des consultations est 45 min. Mais si la variance est élevée, certaines durent 10 min et d'autres 120 min. La moyenne seule peut être trompeuse.

-- Exercice 1 : Calculez la moyenne, la variance et l'écart-type des salaires des médecins.
--   Indice 1 : SELECT AVG(salaire), VARIANCE(salaire), STDDEV(salaire) FROM medecins;
--   Indice 2 : Utilisez des alias pour chaque colonne.

-- Exercice 2 : Calculez la moyenne, la variance et l'écart-type des durées de consultations.
--   Indice 1 : AVG(duree_min), VARIANCE(duree_min), STDDEV(duree_min) FROM consultations
--   Indice 2 : SELECT AVG(duree_min) AS moy, VARIANCE(duree_min) AS variance, STDDEV(duree_min) AS ecart_type

-- Exercice 3 : Calculez la moyenne, la variance et l'écart-type des âges des patients.
--   Indice 1 : AVG(age), VARIANCE(age), STDDEV(age) FROM patients
--   Indice 2 : SELECT AVG(age) AS age_moyen, VARIANCE(age) AS variance, STDDEV(age) AS ecart_type


-- ---------------------------------------------------------------
-- LEÇON : 38. PERCENT_RANK() – Rang en pourcentage
-- ---------------------------------------------------------------
-- En termes simples :
-- PERCENT_RANK() calcule la position relative d'une ligne entre 0 et 1 :
-- • 0 = valeur la plus basse
-- • 1 = valeur la plus haute
-- • 0.5 = médiane
--
-- Formule : (rang - 1) / (nombre total de lignes - 1).
--
-- 📉 Un médecin avec PERCENT_RANK = 0.75 sur le salaire gagne plus que 75% de ses collègues. Utile pour comparer une valeur à sa position dans la distribution sans connaître les valeurs absolues.

-- Exercice 1 : Calculez le PERCENT_RANK de chaque médecin par salaire croissant.
--   Indice 1 : PERCENT_RANK() OVER (ORDER BY salaire) AS percentile
--   Indice 2 : La valeur va de 0 (moins payé) à 1 (plus payé).

-- Exercice 2 : Calculez le PERCENT_RANK de chaque patient par âge croissant.
--   Indice 1 : PERCENT_RANK() OVER (ORDER BY age) AS percentile_age
--   Indice 2 : 0 = le plus jeune, 1 = le plus âgé.

-- Exercice 3 : Calculez le PERCENT_RANK de chaque consultation par durée croissante.
--   Indice 1 : PERCENT_RANK() OVER (ORDER BY duree_min) AS percentile_duree
--   Indice 2 : 0 = consultation la plus courte, 1 = la plus longue.


-- ---------------------------------------------------------------
-- LEÇON : 39. Requête récapitulative complexe
-- ---------------------------------------------------------------
-- En termes simples :
-- Les requêtes complexes combinent plusieurs techniques : JOIN pour relier les tables, GROUP BY pour agréger, HAVING pour filtrer les groupes, ORDER BY pour trier.
--
-- Ordre d'exécution SQL : FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT.
--
-- 🏗️ Comme assembler plusieurs outils en une seule requête : "Pour chaque médecin ayant fait au moins 2 consultations, calculer la durée totale et trier par durée décroissante."

-- Exercice 1 : Pour chaque médecin ayant au moins 2 consultations : nom, nb consultations, durée moyenne et totale. Triez par durée totale décroissante.
--   Indice 1 : JOIN consultations c ON m.id_medecin = c.medecin_id
--   Indice 2 : GROUP BY m.nom HAVING COUNT(*) >= 2

-- Exercice 2 : Par service, affichez le nombre de patients distincts et la durée totale de consultations. Triez par nb_patients décroissant.
--   Indice 1 : JOIN patients p avec consultations c ON p.id_patient = c.id_patient
--   Indice 2 : GROUP BY p.service, COUNT(DISTINCT p.id_patient) AS nb_patients, SUM(c.duree_min) AS total_min

-- Exercice 3 : Pour chaque médecin ayant prescrit au moins 1 médicament : nom, nombre de prescriptions. Triez par nb_prescriptions décroissant.
--   Indice 1 : JOIN medecins → consultations → prescriptions
--   Indice 2 : GROUP BY m.nom HAVING COUNT(pr.id_prescription) >= 1


-- ---------------------------------------------------------------
-- LEÇON : 40. Pivot manuel avec CASE WHEN
-- ---------------------------------------------------------------
-- En termes simples :
-- CASE WHEN avancé : on peut imbriquer des CASE, les utiliser dans GROUP BY, ORDER BY, ou les combiner avec des agrégats. Très puissant pour créer des catégories dynamiques.
--
-- 🏷️ Classer les médecins en "Junior" (< 8000€), "Confirmé" (8000-9000€), "Senior" (> 9000€) directement dans la requête, sans modifier la table.

-- Exercice 1 : Créez un tableau croisé montrant, par service, le nombre d'hommes et de femmes.
--   Indice 1 : SELECT service, COUNT(CASE WHEN sexe='M' THEN 1 END) AS hommes, COUNT(CASE WHEN sexe='F' THEN 1 END) AS femmes
--   Indice 2 : FROM patients GROUP BY service

-- Exercice 2 : Pour chaque médecin (medecin_id), comptez les consultations courtes (< 30 min) et longues (>= 30 min).
--   Indice 1 : COUNT(CASE WHEN duree_min < 30 THEN 1 END) AS courtes
--   Indice 2 : COUNT(CASE WHEN duree_min >= 30 THEN 1 END) AS longues

-- Exercice 3 : Affichez en une seule ligne le nombre total de patients Hospitalisés et le nombre Ambulatoires.
--   Indice 1 : COUNT(CASE WHEN statut='Hospitalisé' THEN 1 END) AS hospitalises
--   Indice 2 : COUNT(CASE WHEN statut='Ambulatoire' THEN 1 END) AS ambulatoires


-- ---------------------------------------------------------------
-- LEÇON : 41. INTERSECT / EXCEPT – Intersection et exclusion
-- ---------------------------------------------------------------
-- En termes simples :
-- INTERSECT retourne les lignes présentes dans LES DEUX requêtes. EXCEPT retourne les lignes du premier SELECT qui ne sont PAS dans le second.
--
-- Contrairement à JOIN, ces opérateurs comparent des lignes complètes.
--
-- 🔵🟡 INTERSECT = l'intersection de deux cercles (ce qui est dans les deux). EXCEPT = ce qui est dans le cercle gauche mais pas dans le droit.

-- Exercice 1 : Trouvez les id_patient qui ont à la fois une consultation ET une hospitalisation (INTERSECT).
--   Indice 1 : SELECT id_patient FROM consultations
--   Indice 2 : INTERSECT

-- Exercice 2 : Trouvez les id_patient présents dans patients mais sans aucune consultation (EXCEPT).
--   Indice 1 : SELECT id_patient FROM patients
--   Indice 2 : EXCEPT SELECT id_patient FROM consultations

-- Exercice 3 : Trouvez les nom présents dans patients mais absents de medecins — noms qui n'appartiennent qu'aux patients (EXCEPT).
--   Indice 1 : SELECT nom FROM patients EXCEPT SELECT nom FROM medecins
--   Indice 2 : EXCEPT soustrait les lignes de la 2ème requête.


-- ---------------------------------------------------------------
-- LEÇON : 42. NOW, DATEDIFF, DATE_FORMAT – Dates avancées
-- ---------------------------------------------------------------
-- En termes simples :
-- NOW() retourne la date et l'heure actuelles. DATEDIFF calcule le nombre de jours entre deux dates. DATE_FORMAT formate une date pour l'affichage.
--
-- 📅 Calculer combien de jours un patient est resté hospitalisé : DATEDIFF(date_sortie, date_entree). Afficher la date en format français : DATE_FORMAT(date, '%d/%m/%Y').

-- Exercice 1 : Affichez la date et heure actuelles avec NOW() dans une colonne maintenant, et la date du jour avec CURDATE() dans aujourd_hui.
--   Indice 1 : SELECT NOW() AS maintenant, CURDATE() AS aujourd_hui;
--   Indice 2 : Pas besoin de FROM — c'est une requête sur des valeurs constantes.

-- Exercice 2 : Pour chaque hospitalisation terminée, calculez la durée du séjour en jours (DATEDIFF entre date_sortie et date_entree).
--   Indice 1 : DATEDIFF(date_sortie, date_entree) AS duree_jours
--   Indice 2 : SELECT id_hosp, chambre, DATEDIFF(date_sortie, date_entree) AS duree_jours FROM hospitalisations

-- Exercice 3 : Formatez la date_consultation de chaque consultation au format '%d/%m/%Y' dans une colonne date_fr.
--   Indice 1 : DATE_FORMAT(date_consultation, '%d/%m/%Y') AS date_fr
--   Indice 2 : %d = jour, %m = mois, %Y = année à 4 chiffres.


-- ---------------------------------------------------------------
-- LEÇON : 43. TRIM, REPLACE, LEFT, RIGHT – Nettoyage de chaînes
-- ---------------------------------------------------------------
-- En termes simples :
-- TRIM supprime les espaces superflus (souvent présents dans les imports). REPLACE remplace un texte par un autre. LEFT/RIGHT extraient N caractères d'un côté.
--
-- 🧹 Les données importées depuis Excel contiennent souvent des espaces cachés ou des abréviations non uniformes. Ces fonctions nettoient et standardisent les données texte.

-- Exercice 1 : Nettoyez les noms de patients : affichez le nom avec TRIM et la première lettre avec LEFT(nom, 1) dans une colonne initiale.
--   Indice 1 : TRIM(nom) AS nom_propre, LEFT(nom, 1) AS initiale
--   Indice 2 : LEFT(col, n) retourne les n premiers caractères de gauche.

-- Exercice 2 : Dans les diagnostics, remplacez le mot "artérielle" par "art." avec REPLACE. Affichez diagnostic et diagnostic_court.
--   Indice 1 : REPLACE(diagnostic, 'artérielle', 'art.') AS diagnostic_court
--   Indice 2 : REPLACE(colonne, ancien, nouveau)

-- Exercice 3 : Affichez les 3 derniers caractères du groupe sanguin avec RIGHT et les 2 premiers avec LEFT pour chaque patient.
--   Indice 1 : LEFT(groupe_sanguin, 2) AS type_sang, RIGHT(groupe_sanguin, 1) AS rhesus
--   Indice 2 : Exemple : LEFT('AB+', 2) = 'AB', RIGHT('AB+', 1) = '+'

