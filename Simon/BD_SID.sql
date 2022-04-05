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
MotDePasse VARCHAR(50),
IdNiveau Number,
CONSTRAINT pk_pseudo PRIMARY KEY (Pseudo),
CONSTRAINT fk_idniveauj foreign key (IdNiveau) REFERENCES Niveau(IdNiveau)
);

CREATE TABLE Partie(
IdPartie Number,
Pseudo Varchar2(50),
IdNiveau Number,
Jour TIMESTAMP(0),
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
insert into Niveau values(2,5,1);
insert into Niveau values(3,6,2);
insert into Niveau values(4,5,2);

insert into collection values(1,1,6); 
insert into collection values(2,2,8);
insert into collection values(3,3,8);
insert into collection values(4,4,10);

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

insert into melodie values(22,2,1,1);
insert into melodie values(23,2,1,2);
insert into melodie values(24,2,6,2);
insert into melodie values(25,2,1,3);
insert into melodie values(26,2,6,3);
insert into melodie values(27,2,5,3);
insert into melodie values(28,2,1,4);
insert into melodie values(29,2,6,4);
insert into melodie values(30,2,5,4);
insert into melodie values(31,2,4,4);
insert into melodie values(32,2,1,5);
insert into melodie values(33,2,6,5);
insert into melodie values(34,2,5,5);
insert into melodie values(35,2,4,5);
insert into melodie values(36,2,3,5);
insert into melodie values(37,2,1,6);
insert into melodie values(38,2,6,6);
insert into melodie values(39,2,5,6);
insert into melodie values(40,2,4,6);
insert into melodie values(41,2,3,6);
insert into melodie values(42,2,3,6);
insert into melodie values(43,2,1,7);
insert into melodie values(44,2,6,7);
insert into melodie values(45,2,5,7);
insert into melodie values(46,2,4,7);
insert into melodie values(47,2,3,7);
insert into melodie values(48,2,3,7);
insert into melodie values(49,2,4,7);
insert into melodie values(50,2,1,8);
insert into melodie values(51,2,6,8);
insert into melodie values(52,2,5,8);
insert into melodie values(53,2,4,8);
insert into melodie values(54,2,3,8);
insert into melodie values(55,2,3,8);
insert into melodie values(56,2,4,8);
insert into melodie values(57,2,3,8);


insert into melodie values(58,3,1,1);
insert into melodie values(59,3,1,2);
insert into melodie values(60,3,2,2);
insert into melodie values(61,3,1,3);
insert into melodie values(62,3,2,3);
insert into melodie values(63,3,6,3);
insert into melodie values(64,3,1,4);
insert into melodie values(65,3,2,4);
insert into melodie values(66,3,6,4);
insert into melodie values(67,3,2,4);
insert into melodie values(68,3,1,5);
insert into melodie values(69,3,2,5);
insert into melodie values(70,3,6,5);
insert into melodie values(71,3,2,5);
insert into melodie values(72,3,4,5);
insert into melodie values(73,3,1,6);
insert into melodie values(74,3,2,6);
insert into melodie values(75,3,6,6);
insert into melodie values(76,3,2,6);
insert into melodie values(77,3,4,6);
insert into melodie values(78,3,5,6);
insert into melodie values(79,3,1,7);
insert into melodie values(80,3,2,7);
insert into melodie values(81,3,6,7);
insert into melodie values(82,3,2,7);
insert into melodie values(83,3,4,7);
insert into melodie values(84,3,5,7);
insert into melodie values(85,3,3,7);
insert into melodie values(86,3,1,8);
insert into melodie values(87,3,2,8);
insert into melodie values(88,3,6,8);
insert into melodie values(89,3,2,8);
insert into melodie values(90,3,4,8);
insert into melodie values(91,3,5,8);
insert into melodie values(92,3,3,8);
insert into melodie values(93,3,1,8);

insert into melodie values(94,4,4,1);
insert into melodie values(95,4,4,2);
insert into melodie values(96,4,3,2);
insert into melodie values(97,4,4,3);
insert into melodie values(98,4,3,3);
insert into melodie values(99,4,6,3);
insert into melodie values(100,4,4,4);
insert into melodie values(101,4,3,4);
insert into melodie values(102,4,6,4);
insert into melodie values(103,4,6,4);
insert into melodie values(104,4,4,5);
insert into melodie values(105,4,3,5);
insert into melodie values(106,4,6,5);
insert into melodie values(107,4,6,5);
insert into melodie values(108,4,2,5);
insert into melodie values(109,4,4,6);
insert into melodie values(110,4,3,6);
insert into melodie values(111,4,6,6);
insert into melodie values(112,4,6,6);
insert into melodie values(113,4,2,6);
insert into melodie values(114,4,5,6);
insert into melodie values(115,4,4,7);
insert into melodie values(116,4,3,7);
insert into melodie values(117,4,6,7);
insert into melodie values(118,4,6,7);
insert into melodie values(119,4,2,7);
insert into melodie values(120,4,5,7);
insert into melodie values(121,4,4,7);
insert into melodie values(122,4,4,8);
insert into melodie values(123,4,3,8);
insert into melodie values(124,4,6,8);
insert into melodie values(125,4,6,8);
insert into melodie values(126,4,2,8);
insert into melodie values(127,4,5,8);
insert into melodie values(128,4,4,8);
insert into melodie values(129,4,5,8);
insert into melodie values(130,4,4,9);
insert into melodie values(131,4,3,9);
insert into melodie values(132,4,6,9);
insert into melodie values(133,4,6,9);
insert into melodie values(134,4,2,9);
insert into melodie values(135,4,5,9);
insert into melodie values(136,4,4,9);
insert into melodie values(137,4,5,9);
insert into melodie values(138,4,2,9);
insert into melodie values(139,4,4,10);
insert into melodie values(140,4,3,10);
insert into melodie values(141,4,6,10);
insert into melodie values(142,4,6,10);
insert into melodie values(143,4,2,10);
insert into melodie values(144,4,5,10);
insert into melodie values(145,4,4,10);
insert into melodie values(146,4,5,10);
insert into melodie values(147,4,2,10);
insert into melodie values(148,4,4,10);


commit;