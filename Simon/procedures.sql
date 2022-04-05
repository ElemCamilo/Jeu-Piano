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



create or replace PACKAGE PartieR AS

TYPE tpartie IS TABLE OF NUMBER index by binary_integer;

PROCEDURE Recup_partie(vPartie IN Partie.IdPartie%TYPE, Partie_elem IN OUT tpartie);

END PartieR;
/

create or replace PACKAGE body PartieR AS


PROCEDURE Recup_partie(vPartie IN Partie.IdPartie%TYPE, Partie_elem IN OUT tpartie) IS

i NUMBER := 1;
BEGIN

FOR cpart IN (Select numnote as note
              FROM coups
              where idpartie = vPartie
              order by idcoup)

LOOP

Partie_elem(i) := cpart.note;
i := i + 1; 

END LOOP;

END Recup_partie;

END PartieR;
/


create or replace PROCEDURE Aug_Niveau(vJoueur IN Joueur.Pseudo%TYPE, pretour OUT Joueur.idniveau%TYPE) IS

BEGIN

pretour := 0;

UPDATE JOUEUR
set idniveau = idniveau + 1
where pseudo = vJoueur;


EXCEPTION

WHEN OTHERS THEN
    pretour := 10;
    DBMS_OUTPUT.PUT_LINE('Niveau maximal');

END;
/


create or replace PROCEDURE creer_Compte(nouveauPseudo Joueur_lolo.pseudo%TYPE, nouveauMdp Joueur_lolo.mdp%TYPE, pretour OUT NUMBER)AS

BEGIN

INSERT INTO Joueur_lolo
VALUES (nouveauPseudo, nouveauMdp,0);
COMMIT;
pretour := 0;

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Le joueur existe déjà');
    pretour := 1;
WHEN others THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE(SQLERRM || ' - ' ||SQLCODE);
    pretour := 10;
END;
/


create or replace PROCEDURE Inserer_Partie(vPseudo IN Joueur.Pseudo%TYPE, vNiveau IN joueur.idniveau%TYPE, vNumpartie OUT Partie.Idpartie%TYPE, pretour OUT Partie.Idpartie%TYPE) AS

BEGIN

pretour := 0;

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

EXCEPTION

WHEN OTHERS THEN  -- exception others
    IF (SQLERRM like '%le niveau n''est pas débloqué%') THEN
        ROLLBACK;
        pretour := 9;
        DBMS_OUTPUT.PUT_LINE(SQLERRM ||' - '||SQLCODE);
    ELSIF (SQLERRM like '%Vous ne pouvez plus jouer, trop de parties perdues%') THEN
        ROLLBACK;
        pretour := 8;
        DBMS_OUTPUT.PUT_LINE(SQLERRM ||' - '||SQLCODE);
    ELSE
        ROLLBACK;
        pretour := 7;
        DBMS_OUTPUT.PUT_LINE(SQLERRM ||' - '||SQLCODE);
    END IF;

COMMIT;

END;
/

create or replace PROCEDURE Inserer_Pseudo(vPseudo IN Joueur.Pseudo%TYPE, 
                                           pmotdepasse IN joueur.motdepasse%type,
                                           pretour OUT number) AS


BEGIN

pretour := 0;

INSERT INTO JOUEUR
Values (vPseudo, pmotdepasse, 1);
COMMIT;

EXCEPTION

WHEN OTHERS THEN
    IF (SQLERRM like '%Nom d''utilisateur non valide%') THEN
        ROLLBACK;
        pretour := 2;
        DBMS_OUTPUT.PUT_LINE(SQLERRM ||' - '||SQLCODE);
    elsif (SQLERRM like '%Mot de passe invalide%') THEN
        ROLLBACK;
        pretour := 1;
        DBMS_OUTPUT.PUT_LINE(SQLERRM ||' - '||SQLCODE);
    END IF; 
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

END;
/

create or replace PROCEDURE Recup_Niveau_NbNotes(vPseudo IN Joueur.Pseudo%TYPE, vNiveau OUT Niveau.Idniveau%TYPE) AS


BEGIN

Select J.Idniveau 
INTO vNiveau
from JOUEUR J
WHERE J.pseudo = vPseudo;

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

create or replace PROCEDURE Recup_taille_coup(vPartie IN Partie.IdPartie%TYPE, vtaille OUT collection.taille%TYPE) AS


BEGIN

Select COUNT(idcoup) 
INTO vtaille
from Coups
WHERE idpartie = vPartie;

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


create or replace trigger t_b_i_Niveau
before insert on PARTIE
for each row

declare
vniv joueur.idniveau%TYPE;

begin
select Idniveau into vniv from Joueur
where pseudo = :new.pseudo;

if (:new.Idniveau > vniv) then
    raise_application_error(-20100, 'le niveau n''est pas débloqué');
end if;
end;
/



create or replace trigger t_b_i_NiveauBloque
before insert on PARTIE
for each row

declare
score_attendu joueur.idniveau%TYPE;
parties_perdues_1h joueur.idniveau%TYPE;
parties_perdues_4h joueur.idniveau%TYPE;

begin

SELECT SUM(DISTINCT(MANCHE))
INTO score_attendu
FROM MELODIE
WHERE idniveau = :new.idniveau;

SELECT COUNT(IDPARTIE)
INTO parties_perdues_1h
FROM PARTIE
WHERE jour > TO_CHAR(SYSDATE - 1/24, 'DD/MM/YYYY HH24:MI:SS') and pseudo = :new.pseudo and score != score_attendu;

SELECT COUNT(IDPARTIE)
INTO parties_perdues_4h
FROM PARTIE
WHERE jour > TO_CHAR(SYSDATE - 4/24, 'DD/MM/YYYY HH24:MI:SS') and pseudo = :new.pseudo and score != score_attendu;

if parties_perdues_1h = 5 then
    raise_application_error(-20102, 'Vous ne pouvez plus jouer, trop de parties perdues');
elsif parties_perdues_4h = 5 then
    raise_application_error(-20103, 'Vous êtes toujours dans l''incapacité de jouer, vous avez perdu trop de parties');
end if;

end;
/



create or replace trigger t_b_u_NiveauMax
before update on joueur
for each row

declare
vidniv joueur.idniveau%type;

begin

if :old.idniveau = 4 then
    raise_application_error(-20101, 'Niveau_Maximal');
end if;

end;
/




create or replace trigger t_b_i_inscrip
before insert on JOUEUR
for each row

DECLARE 

count_vpseudo joueur.idniveau%type := 0;

BEGIN

if :new.pseudo is null then
    raise_application_error(-20104, 'Nom d''utilisateur non valide');
end if;


select count(pseudo) into count_vpseudo from joueur
where pseudo = :new.pseudo;

if count_vpseudo != 0 then
    raise_application_error(-20104, 'Nom d''utilisateur non valide');
end if;

if :new.motdepasse is null then
    raise_application_error(-20105, 'Mot de passe invalide');
end if;


END;
/