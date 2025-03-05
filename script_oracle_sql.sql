-- VERSION AVEC DATE POUR ORACLE --



-- Commandes de création de table 

CREATE TABLE AD_STUDENT 
(
    STUDENT_ID NUMBER,
    EMAIL VARCHAR2(50) NOT NULL,
    SFIRST_NAME VARCHAR2(50) NOT NULL,
    SLAST_NAME VARCHAR2(50) NOT NULL,
    PROMO VARCHAR2(50) NOT NULL,
    CONSTRAINT student_pk PRIMARY KEY (STUDENT_ID), /*Première manière de faire une contrainte*/
    CONSTRAINT studentmail_uk UNIQUE (EMAIL)
);

CREATE TABLE AD_TEACHER
(
    TEACHER_ID NUMBER PRIMARY KEY, /* 2ème manière de faire une contrainte */
    EMAIL VARCHAR2(50) UNIQUE NOT NULL,
    TFIRST_NAME VARCHAR2(50) NOT NULL,
    TLAST_NAME VARCHAR2(50) NOT NULL,
    ENTER_DATE DATE NOT NULL,
    MATIERE VARCHAR2(50) NOT NULL
);

CREATE TABLE AD_MATIERE
(
    MATIERE_ID NUMBER PRIMARY KEY,
    MATIERE_NAME VARCHAR2(50) NOT NULL,
    TEACHER_ID NUMBER NOT NULL,
    CONSTRAINT teacher_fk FOREIGN KEY (TEACHER_ID) REFERENCES AD_TEACHER(TEACHER_ID)
);

CREATE TABLE AD_NOTES
(
    NOTE_ID NUMBER PRIMARY KEY, 
    STUDENT_ID NUMBER NOT NULL, 
    MATIERE_ID NUMBER NOT NULL,
    PUBLISH_DATE DATE NOT NULL,
    NOTE NUMBER,
    CONSTRAINT student_matiere_unique UNIQUE (STUDENT_ID, MATIERE_ID),
    CONSTRAINT note_fk FOREIGN KEY (STUDENT_ID) REFERENCES AD_STUDENT(STUDENT_ID),
    CONSTRAINT matiere_fk FOREIGN KEY (MATIERE_ID) REFERENCES AD_MATIERE(MATIERE_ID)
);

CREATE TABLE PROMO
(
    PROMO NUMBER PRIMARY KEY,
    NOTE_ID NUMBER NOT NULL,
    STUDENT_ID NUMBER NOT NULL,
    CONSTRAINT student_fk FOREIGN KEY (STUDENT_ID) REFERENCES AD_STUDENT(STUDENT_ID),
    CONSTRAINT note_fk FOREIGN KEY (NOTE_ID) REFERENCES AD_NOTES(NOTE_ID)
);

CREATE TABLE AD_ABSENCES 
(
    ABSENCE_ID NUMBER PRIMARY KEY,
    STUDENT_ID NUMBER NOT NULL,
    DUREE NUMBER NOT NULL,
    ABS_DATE DATE NOT NULL, 
     JUSTIFICATION NUMBER NOT NULL, -- 0 : oui  ; 1 : non
    CONSTRAINT student_fk FOREIGN KEY (STUDENT_ID) REFERENCES AD_STUDENT(STUDENT_ID)
);

-- Commandes d'ajout dans les tables

-- Pour de meilleurs résultats : génération de 15 étudiants
---- Eleves | Cette méthode d'insertion a été privilégiée pour éviter d'avoir 15 "insert Into [...] Values [...]"
INSERT INTO AD_STUDENT(STUDENT_ID, EMAIL, SFIRST_NAME, SLAST_NAME, PROMO) VALUES 
(1, 'mariedubois@ecole.com', 'Marie', 'Dubois', 'Promo2022'),
(2, 'pierremartin@ecole.com', 'Pierre', 'Martin', 'Promo2023'),
(3, 'camilleleroy@ecole.com', 'Camille', 'Leroy', 'Promo2023'),
(4, 'thomaslambert@ecole.com', 'Thomas', 'Lambert', 'Promo2024'),
(5, 'emiliedupont@ecole.com', 'Émilie', 'Dupont', 'Promo2025'),
(6, 'paulgirard@ecole.com', 'Paul', 'Girard', 'Promo2025'),
(7, 'sophiemorel@ecole.com', 'Sophie', 'Morel', 'Promo2025'),
(8, 'lucbesson@ecole.com', 'Luc', 'Besson', 'Promo2026'),
(9, 'alexandrafournier@ecole.com', 'Alexandra', 'Fournier', 'Promo2026'),
(10, 'thibautmartin@ecole.com', 'Thibaut', 'Martin', 'Promo2026'),
(11, 'emmanuelledupuis@ecole.com', 'Emmanuelle', 'Dupuis', 'Promo2027'),
(12, 'pierregarcia@ecole.com', 'Pierre', 'Garcia', 'Promo2028'),
(13, 'amelielaroche@ecole.com', 'Amélie', 'Laroche', 'Promo2028'),
(14, 'maximebertrand@ecole.com', 'Maxime', 'Bertrand', 'Promo2029'),
(15, 'laurapetit@ecole.com', 'Laura', 'Petit', 'Promo2029');

-- Professeurs 
INSERT INTO AD_TEACHER(TEACHER_ID, EMAIL, TFIRST_NAME, TLAST_NAME, ENTER_DATE, MATIERE) VALUES
(1, 'marc.math_prof@ecole.com', 'Luis', 'Marc', TO_DATE('2016-12-01', 'YYYY-MM-DD'), 'Mathématiques'),
(2, 'martin.prof_francais@ecole.com', 'Sophie', 'Martin', TO_DATE('2017-09-15', 'YYYY-MM-DD'), 'Français'),
(3, 'leroy.prof_physique@ecole.com', 'Thomas', 'Leroy', TO_DATE('2018-04-10', 'YYYY-MM-DD'), 'Physique'), 
(4, 'dupont.prof_histoire@ecole.com', 'Laura', 'Dupont', TO_DATE('2019-11-22', 'YYYY-MM-DD'), 'Histoire'), 
(5, 'garcia.prof_chimie@ecole.com', 'Antoine', 'Garcia', TO_DATE('2020-06-05', 'YYYY-MM-DD'), 'Chimie'), 
(6, 'bertrand.prof_anglais@ecole.com', 'Amélie', 'Bertrand', TO_DATE('2021-01-30', 'YYYY-MM-DD'), 'Anglais'), 
(7, 'petit.prof_informatique@ecole.com', 'Pierre', 'Petit', TO_DATE('2022-08-18', 'YYYY-MM-DD'), 'Informatique'); 

---- Matières
INSERT INTO AD_MATIERE(MATIERE_ID, MATIERE_NAME, TEACHER_ID) VALUES
(1, 'Mathematiques', 1),
(2, 'Français', 2),
(3, 'Physique', 3),
(4, 'Histoire', 4),
(5, 'Chimie', 5),
(6, 'Anglais', 6),
(7, 'Informatique', 7);

---- Notes 
INSERT INTO AD_NOTES(NOTE_ID, STUDENT_ID, MATIERE_ID, PUBLISH_DATE, NOTE) VALUES
(1, 1, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 5),
(2, 2, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 10),
(3, 3, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 7),
(4, 4, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 15),
(5, 5, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 6),
(6, 6, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 18),
(7, 7, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 8),
(8, 8, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 4),
(9, 9, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 12),
(10, 10, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 9),
(11, 11, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 3),
(12, 12, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 16),
(13, 13, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 7),
(14, 14, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 14),
(15, 15, 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 20);

INSERT INTO AD_ABSENCES(ABSENCE_ID, STUDENT_ID, DUREE, ABS_DATE,
JUSTIFICATION) VALUES
(2, 5, 90, TO_DATE('2023-01-16', 'YYYY-MM-DD'), 0),
(3, 6, 60, TO_DATE('2023-01-17', 'YYYY-MM-DD'), 0),
(4, 7, 150, TO_DATE('2023-01-18', 'YYYY-MM-DD'), 1),
(5, 8, 120, TO_DATE('2023-01-19', 'YYYY-MM-DD'), 1);
-- Commandes d'affichage 

/*SELECT * FROM AD_STUDENT;
SELECT * FROM AD_TEACHER;
SELECT * FROM AD_MATIERE;
SELECT * FROM AD_NOTES;
SELECT * FROM AD_NOTES;
SELECT * FROM AD_ABSENCES;*/