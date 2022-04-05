create or replace PACKAGE Coup AS

TYPE tcoup IS TABLE OF NUMBER index by binary_integer;

PROCEDURE Inserer_Coup(vPartie IN Coups.Idpartie%TYPE, Coup_I IN tcoup, vEtat IN Coups.Etat%TYPE);

END Coup;
/
create or replace PACKAGE body Coup AS

PROCEDURE Inserer_Coup(vPartie IN Coups.Idpartie%TYPE, Coup_I IN tcoup, vEtat IN Coups.Etat%TYPE) IS

index_coup NUMBER;

BEGIN


select max(idcoup)
into index_coup
from coups;


if index_coup is null then
    index_coup := 1;
else
    index_coup := index_coup + 1;
end if;

FOR i IN 1 .. Coup_I.COUNT LOOP

    if i = Coup_I.COUNT and vEtat = 0 THEN
        INSERT INTO Coups 
        Values (index_coup, vPartie, Coup_I(i), 0);
    else
        INSERT INTO Coups 
        Values (index_coup, vPartie, Coup_I(i), 1);
    end if;

    index_coup := index_coup + 1;

END LOOP;

END Inserer_Coup;

END Coup;
/











create or replace PACKAGE melodieP AS

TYPE tmel IS TABLE OF NUMBER index by binary_integer;

PROCEDURE Recup_melodie(vNiveau IN Niveau.Idniveau%TYPE, MelodieF IN OUT tmel);

END melodieP;
/

create or replace PACKAGE body melodieP AS


PROCEDURE Recup_melodie(vNiveau IN Niveau.Idniveau%TYPE, MelodieF IN OUT tmel) IS

i NUMBER := 1;

BEGIN

FOR cmel IN (SELECT NUMNOTE as num
             FROM MELODIE
             WHERE MANCHE = (SELECT MAX(Manche) 
                            FROM melodie
                            WHERE idniveau = vNiveau)
             AND idniveau = vNiveau)
LOOP

MelodieF(i) := cmel.num;
i := i + 1; 

END LOOP;

END recup_melodie;

END melodieP;
/









create or replace PROCEDURE Aug_Niveau(vJoueur IN Joueur.Pseudo%TYPE) IS

BEGIN

UPDATE JOUEUR
set idniveau = idniveau + 1
where pseudo = vJoueur;

END;
/






create or replace PROCEDURE Inserer_Partie(vPseudo IN Joueur.Pseudo%TYPE, vNiveau IN joueur.idniveau%TYPE, vNumpartie OUT Partie.Idpartie%TYPE) AS


BEGIN

select max(IdPartie) 
into vNumpartie 
from Partie; 

if vNumpartie is null then
    vNumpartie := 1;
else
    vNumpartie := vNumpartie + 1;
end if;

INSERT INTO Partie 
Values (vNumpartie, vPseudo, vNiveau, TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS'), 0);

COMMIT;

END;
/




create or replace PROCEDURE Inserer_Pseudo(vPseudo IN Joueur.Pseudo%TYPE, 
                                           pmotdepasse IN joueur.motdepasse%type) AS


BEGIN

INSERT INTO JOUEUR
Values (vPseudo, pmotdepasse, 1);
COMMIT;

END;
/





create or replace PROCEDURE Recup_Nb_Niveaux(vNombreN IN OUT Niveau.Idniveau%TYPE) AS


BEGIN

Select Max(idniveau) 
INTO vnombren
from niveau;

END;
/



create or replace PROCEDURE Recup_Niveau(vPseudo IN Joueur.Pseudo%TYPE, vNiveau OUT Niveau.Idniveau%TYPE) AS


BEGIN

Select J.Idniveau 
INTO vNiveau
from JOUEUR J
WHERE J.pseudo = vPseudo;

COMMIT;

END;
/





create or replace PROCEDURE Recup_Niveau_NbNotes(vPseudo IN Joueur.Pseudo%TYPE, vNiveau OUT Niveau.Idniveau%TYPE) AS


BEGIN

Select J.Idniveau 
INTO vNiveau
from JOUEUR J
WHERE J.pseudo = vPseudo;

COMMIT;

END;
/




create or replace PROCEDURE Recup_taille_collection(vNiveau IN Niveau.Idniveau%TYPE, vtaille OUT collection.taille%TYPE) AS


BEGIN

Select taille 
INTO vtaille
from Collection
WHERE idniveau = vNiveau;

END;
/



create or replace PROCEDURE Score(vPartie IN Partie.Idpartie%TYPE, vScore IN partie.score%TYPE) AS


BEGIN

UPDATE PARTIE
SET SCORE = vScore
WHERE idpartie = vpartie; 

END;
/





create or replace PROCEDURE VERIF_CONNEXION
                    (ppseudo IN joueur.pseudo%TYPE, 
                    pmotdepasse IN joueur.motdepasse%type,
                    pretour OUT number) AS
                    

vmotdepasse joueur.motdepasse%type;


--Selection du mdp en fonction du pseudo renseigné--
BEGIN
pretour := 0;
select motdepasse into vmotdepasse from joueur
where joueur.pseudo = ppseudo;

--Vérification du mdp renseigné et du mdp enregistré dans la base de donnée--
if pmotdepasse is null or vmotdepasse != pmotdepasse THEN
    pretour := 2;
end if;

EXCEPTION
--Nom d'utilisateur invalide--
when no_data_found then
    pretour := 1;

--Erreur inconnu--
when others then
    pretour := SQLCODE;

END VERIF_CONNEXION;
/





create or replace PROCEDURE VERIF_PSEUDO
                        (ppseudo IN joueur.pseudo%type,
                         pmotdepasse IN joueur.motdepasse%type,
                         pretour OUT number) AS

vpseudo joueur.pseudo%type := null;

BEGIN
pretour := 0;
select pseudo into vpseudo from joueur
where pseudo = ppseudo;

if vpseudo is not null then
    pretour := 2;
end if;

EXCEPTION
when no_data_found then
    DBMS_OUTPUT.PUT_LINE('Il n''y a pas de joeur appelé comme ça.');
    if pmotdepasse is not null then
        inserer_pseudo(ppseudo, pmotdepasse);
    else
        pretour := 1;
    end if;
when others then
    pretour := SQLCODE;

END VERIF_PSEUDO;
/



