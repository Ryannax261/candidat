CREATE DATABASE forage;

\c forage;

CREATE TABLE t_client(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    contact VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE t_demande(
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    description TEXT NOT NULL,
    date_demande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    district VARCHAR(255) NOT NULL,
    FOREIGN KEY (client_id) REFERENCES t_client(id)
);

CREATE TABLE t_type_devis(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE t_devis(
    id SERIAL PRIMARY KEY,
    demande_id INT NOT NULL,
    type_devis_id INT NOT NULL,
    date_devis TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (demande_id) REFERENCES t_demande(id),
    FOREIGN KEY (type_devis_id) REFERENCES t_type_devis(id)
);

CREATE TABLE t_detail_devis(
    id SERIAL PRIMARY KEY,
    devis_id INT NOT NULL,
    libelle TEXT NOT NULL,
    prix DECIMAL(15, 2) NOT NULL,
    pu DECIMAL(15, 2) NOT NULL DEFAULT 0,
    quantite INT NOT NULL DEFAULT 1,
    FOREIGN KEY (devis_id) REFERENCES t_devis(id)
);

CREATE TABLE t_statut(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE t_demande_statut(
    id SERIAL PRIMARY KEY,
    demande_id INT NOT NULL,
    statut_id INT NOT NULL,
    date_statut TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observation TEXT,
    ecart_total VARCHAR(50),
    ecart_ouvre VARCHAR(50),
    FOREIGN KEY (demande_id) REFERENCES t_demande(id),
    FOREIGN KEY (statut_id) REFERENCES t_statut(id)
);

CREATE VIEW client_demande AS
SELECT 
    d.id AS id_demande,
    c.nom AS nom_client,
    d.date_demande,
    d.district
FROM t_client c
JOIN t_demande d ON d.client_id = c.id;

-- Statuts possibles pour un devis
CREATE TABLE t_statut_devis (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL UNIQUE,
    type_devis_id INT,
    FOREIGN KEY (type_devis_id) REFERENCES t_type_devis(id)
);

-- Historique des statuts d'un devis
CREATE TABLE t_devis_statut (
    id SERIAL PRIMARY KEY,
    devis_id INT NOT NULL,
    statut_devis_id INT NOT NULL,
    date_statut TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ecart_total VARCHAR(50),
    ecart_ouvre VARCHAR(50),
    FOREIGN KEY (devis_id) REFERENCES t_devis(id) ON DELETE CASCADE,
    FOREIGN KEY (statut_devis_id) REFERENCES t_statut_devis(id)
);

CREATE VIEW v_chiffre_affaire AS
SELECT COALESCE(SUM(prix), 0) as total_ca FROM t_detail_devis;


ALTER TABLE t_demande_statut ADD COLUMN ecart_total VARCHAR(50);
ALTER TABLE t_demande_statut ADD COLUMN ecart_ouvre VARCHAR(50);

ALTER TABLE t_devis_statut ADD COLUMN ecart_total VARCHAR(50);
ALTER TABLE t_devis_statut ADD COLUMN ecart_ouvre VARCHAR(50);
