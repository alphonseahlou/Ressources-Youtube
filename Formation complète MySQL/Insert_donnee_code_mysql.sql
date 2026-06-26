-- ═══════════════════════════════════════════════════════════════
-- Base "Gestion Hospitalière" — Insertion des données (MySQL)
-- ───────────────────────────────────────────────────────────────
-- À exécuter APRÈS la création des tables (schéma).
-- Ordre des INSERT = ordre des dépendances (clés étrangères).
-- ═══════════════════════════════════════════════════════════════

SET NAMES utf8mb4;
START TRANSACTION;

-- medecins (5 lignes)
INSERT INTO medecins (id_medecin, nom, specialite, service, salaire) VALUES
  (1, 'Dr. Mercier', 'Oncologie', 'Oncologie', 9500),
  (2, 'Dr. Fontaine', 'Cardiologie', 'Cardiologie', 8800),
  (3, 'Dr. Garnier', 'Neurologie', 'Neurologie', 8200),
  (4, 'Dr. Rousseau', 'Gériatrie', 'Gériatrie', 7600),
  (5, 'Dr. Blanc', 'Urgences', 'Urgences', 8500);

-- medicaments (7 lignes)
INSERT INTO medicaments (id_medicament, nom_medicament, categorie, prix_unitaire) VALUES
  (1, 'Lisinopril', 'Antihypertenseur', 0.15),
  (2, 'Sumatriptan', 'Antimigraineux', 2.4),
  (3, 'Amiodarone', 'Antiarythmique', 0.85),
  (4, 'Furosémide', 'Diurétique', 0.1),
  (5, 'Lévétiracétam', 'Antiépileptique', 1.2),
  (6, 'Metformine', 'Antidiabétique', 0.08),
  (7, 'Atorvastatine', 'Hypolipémiant', 0.3);

-- patients (10 lignes)
INSERT INTO patients (id_patient, nom, prenom, age, sexe, groupe_sanguin, service, date_admission, medecin_id, statut) VALUES
  (1, 'Martin', 'Sophie', 59, 'F', 'A+', 'Cardiologie', '2024-11-03', 2, 'Hospitalisé'),
  (2, 'Dubois', 'Marc', 46, 'M', 'O+', 'Neurologie', '2024-11-07', 3, 'Hospitalisé'),
  (3, 'Leroy', 'Claire', 33, 'F', 'B-', 'Cardiologie', '2024-11-10', 2, 'Ambulatoire'),
  (4, 'Bernard', 'Jean', 72, 'M', 'AB+', 'Oncologie', '2024-11-01', 1, 'Hospitalisé'),
  (5, 'Petit', 'Isabelle', 40, 'F', 'A-', 'Cardiologie', '2024-11-12', 2, 'Hospitalisé'),
  (6, 'Richard', 'Paul', 79, 'M', 'O-', 'Gériatrie', '2024-10-28', 4, 'Hospitalisé'),
  (7, 'Thomas', 'Anne', 23, 'F', 'B+', 'Urgences', '2024-11-14', 5, 'Ambulatoire'),
  (8, 'Moreau', 'Luc', 55, 'M', 'A+', 'Neurologie', '2024-10-15', 3, 'Hospitalisé'),
  (9, 'Simon', 'Marie', 68, 'F', 'O+', 'Gériatrie', '2024-10-20', 4, 'Ambulatoire'),
  (10, 'Laurent', 'Pierre', 31, 'M', 'AB-', 'Oncologie', '2024-11-05', 1, 'Hospitalisé');

-- consultations (10 lignes)
INSERT INTO consultations (id_consultation, id_patient, date_consultation, diagnostic, traitement, medecin_id, duree_min) VALUES
  (1, 1, '2024-11-03', 'Hypertension artérielle', 'Lisinopril 10mg', 2, 25),
  (2, 2, '2024-11-07', 'Migraine chronique', 'Sumatriptan 50mg', 3, 40),
  (3, 3, '2024-11-10', 'Arythmie cardiaque', 'Amiodarone 200mg', 2, 30),
  (4, 4, '2024-11-01', 'Cancer colorectal stade II', 'Chimiothérapie FOLFOX', 1, 60),
  (5, 1, '2024-01-15', 'Contrôle tensionnel', 'Ajustement posologie', 2, 20),
  (6, 5, '2024-11-12', 'Insuffisance cardiaque', 'Furosémide 40mg', 2, 35),
  (7, 7, '2024-11-14', 'Fracture cheville', 'Plâtre + antidouleurs', 5, 45),
  (8, 8, '2024-10-15', 'Épilepsie focale', 'Lévétiracétam 500mg', 3, 50),
  (9, 9, '2024-10-20', 'Démence sénile', 'Donépézil 10mg', 4, 55),
  (10, 10, '2024-11-05', 'Lymphome non hodgkinien', 'Rituximab + CHOP', 1, 65);

-- prescriptions (7 lignes)
INSERT INTO prescriptions (id_prescription, id_consultation, id_medicament, quantite, duree_jours) VALUES
  (1, 1, 1, 30, 90),
  (2, 2, 2, 10, 14),
  (3, 3, 3, 30, 180),
  (4, 6, 4, 30, 60),
  (5, 8, 5, 60, 365),
  (6, 1, 7, 30, 90),
  (7, 4, 6, 60, 180);

-- hospitalisations (7 lignes)
INSERT INTO hospitalisations (id_hosp, id_patient, date_entree, date_sortie, chambre, cout_journalier) VALUES
  (1, 1, '2024-11-03', '2024-11-10', 'A101', 450),
  (2, 2, '2024-11-07', NULL, 'B205', 520),
  (3, 4, '2024-11-01', '2024-11-15', 'C302', 680),
  (4, 5, '2024-11-12', NULL, 'A103', 450),
  (5, 6, '2024-10-28', '2024-11-08', 'D401', 390),
  (6, 8, '2024-10-15', '2024-10-25', 'B210', 520),
  (7, 10, '2024-11-05', NULL, 'C305', 680);

COMMIT;
