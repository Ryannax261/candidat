-- ============================================================
-- Données initiales insérées automatiquement au démarrage
-- ON CONFLICT DO NOTHING = pas d'erreur si déjà existant
-- ============================================================

-- Statuts pour les DEMANDES
INSERT INTO t_statut (nom) VALUES ('Creer'), ('En attente'), ('En cours'), ('Suspendu'), ('Termine') ON CONFLICT (nom) DO NOTHING;

-- Types de devis
INSERT INTO t_type_devis (nom) VALUES ('Etude')  ON CONFLICT (nom) DO NOTHING;
INSERT INTO t_type_devis (nom) VALUES ('Forage') ON CONFLICT (nom) DO NOTHING;

-- Statuts pour les DEVIS liés au type "Etude"
INSERT INTO t_statut_devis (nom, type_devis_id)
    SELECT 'Etude_creee', id FROM t_type_devis WHERE nom = 'Etude'
    ON CONFLICT (nom) DO NOTHING;

INSERT INTO t_statut_devis (nom, type_devis_id)
    SELECT 'Etude_en_cours', id FROM t_type_devis WHERE nom = 'Etude'
    ON CONFLICT (nom) DO NOTHING;

INSERT INTO t_statut_devis (nom, type_devis_id)
    SELECT 'Etude_terminee', id FROM t_type_devis WHERE nom = 'Etude'
    ON CONFLICT (nom) DO NOTHING;

-- Statuts pour les DEVIS liés au type "Forage"
INSERT INTO t_statut_devis (nom, type_devis_id)
    SELECT 'Forage_cree', id FROM t_type_devis WHERE nom = 'Forage'
    ON CONFLICT (nom) DO NOTHING;

INSERT INTO t_statut_devis (nom, type_devis_id)
    SELECT 'Forage_en_cours', id FROM t_type_devis WHERE nom = 'Forage'
    ON CONFLICT (nom) DO NOTHING;

INSERT INTO t_statut_devis (nom, type_devis_id)
    SELECT 'Forage_termine', id FROM t_type_devis WHERE nom = 'Forage'
    ON CONFLICT (nom) DO NOTHING;
