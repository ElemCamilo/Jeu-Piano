--BD Simon


DROP TABLE MELODIE;
DROP TABLE COUPS;
DROP TABLE PARTIE;
DROP TABLE JOUEUR;
DROP TABLE COLLECTION;
DROP TABLE NIVEAU;
DROP TABLE NOTES;



CREATE TABLE Notes(
NumNote Number,
Son Varchar2(10),
CONSTRAINT pk_numnote PRIMARY KEY (NumNote)
);

CREATE TABLE Niveau(
IdNiveau Number,
NbNotes Number,
Vitesse Number,
CONSTRAINT pk_idniveau PRIMARY KEY (IdNiveau)
);

CREATE TABLE Collection(
IdCollection Number,
IdNiveau Number,
Taille Number,
CONSTRAINT pk_collection PRIMARY KEY (IdCollection),
CONSTRAINT fk_idniveauc foreign key (IdNiveau) REFERENCES Niveau(IdNiveau)
);

CREATE TABLE Joueur(
Pseudo Varchar2(50),
IdNiveau Number,
Mail VARCHAR(100),
MotDePasse VARCHAR(50),
CONSTRAINT pk_pseudo PRIMARY KEY (Pseudo),
CONSTRAINT fk_idniveauj foreign key (IdNiveau) REFERENCES Niveau(IdNiveau)
);

CREATE TABLE Partie(
IdPartie Number,
Pseudo Varchar2(50),
IdNiveau Number,
Jour DATE,
Score Number,
CONSTRAINT pk_partie PRIMARY KEY (IdPartie),
CONSTRAINT fk_pseudo foreign key (Pseudo) REFERENCES Joueur(Pseudo),
CONSTRAINT fk_idniveaup foreign key (IdNiveau) REFERENCES Niveau(IdNiveau)
);

CREATE TABLE Coups(
IdCoup Number,
IdPartie Number,
NumNote Number,
Etat Number,
CONSTRAINT pk_coups PRIMARY KEY (IdCoup),
CONSTRAINT fk_idpartiec foreign key (IdPartie) REFERENCES Partie(IdPartie),
CONSTRAINT fk_numnotec foreign key (NumNote) REFERENCES Notes(NumNote)
);

CREATE TABLE Melodie(
IdMelodie Number,
IdNiveau Number,
NumNote Number,
Manche Number,
CONSTRAINT pk_melodie PRIMARY KEY (IdMelodie),
CONSTRAINT fk_idniveaum foreign key (IdNiveau) REFERENCES Niveau(IdNiveau),
CONSTRAINT fk_numnotem foreign key (NumNote) REFERENCES Notes(NumNote)
);

insert into notes values(1, 'Do');
insert into notes values(2, 'Re');
insert into notes values(3, 'Mi');
insert into notes values(4, 'Fa');
insert into notes values(5, 'Sol');
insert into notes values(6, 'La');
insert into notes values(7, 'Si');

insert into Niveau values(1,3,1);

insert into Collection values(1,1,6);

insert into melodie values(1,1,2,1);
insert into melodie values(2,1,2,2);
insert into melodie values(3,1,3,2);
insert into melodie values(4,1,2,3);
insert into melodie values(5,1,3,3);
insert into melodie values(6,1,4,3);
insert into melodie values(7,1,2,4);
insert into melodie values(8,1,3,4);
insert into melodie values(9,1,4,4);
insert into melodie values(10,1,2,4);
insert into melodie values(11,1,2,5);
insert into melodie values(12,1,3,5);
insert into melodie values(13,1,4,5);
insert into melodie values(14,1,2,5);
insert into melodie values(15,1,4,5);
insert into melodie values(16,1,2,6);
insert into melodie values(17,1,3,6);
insert into melodie values(18,1,4,6);
insert into melodie values(19,1,2,6);
insert into melodie values(20,1,4,6);
insert into melodie values(21,1,3,6);

commit;
