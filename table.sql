CREATE DATABASE note_candidat;

\c note_candidat;

CREATE TABLE t_candidat (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    matricule VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE t_correcteur(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    numtel VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE t_matiere(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL UNIQUE,
    coefficient INTEGER NOT NULL
);

CREATE TABLE t_resolution(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
);

CREATE TABLE t_operateur(
    id SERIAL PRIMARY KEY,
    operateur VARCHAR(255) NOT NULL
);

CREATE TABLE t_parametre(
    id SERIAL PRIMARY KEY,
    id_matiere INTEGER NOT NULL,
    id_resolution INTEGER NOT NULL,
    id_operateur INTEGER NOT NULL,
    seuil FLOAT NOT NULL,
    FOREIGN KEY (id_resolution) REFERENCES t_resolution(id),
    FOREIGN KEY (id_operateur) REFERENCES t_operateur(id),
    FOREIGN KEY (id_matiere) REFERENCES t_matiere(id)
);

CREATE TABLE t_note(
    id SERIAL PRIMARY KEY,
    id_candidat INTEGER NOT NULL,
    id_matiere INTEGER NOT NULL,
    id_correcteur INTEGER NOT NULL,
    note DECIMAL(10,3) NOT NULL,
    FOREIGN KEY (id_candidat) REFERENCES t_candidat(id),
    FOREIGN KEY (id_matiere) REFERENCES t_matiere(id),
    FOREIGN KEY (id_correcteur) REFERENCES t_correcteur(id)
);

