
//Fonction click des touches

function clickit(touche)
{
    ajouter_elem_liste_melodie(melodie_joue, touche);
}


//Fonction pour envoyer le form

function form_send(liste_form)
{
	touches_func();
	var liste_str = liste_form.toString();
    document.getElementById('coup').value = "[" + liste_str + "]";
	document.getElementById('liste_coup').submit();
}

//Pour construire le coup joué

function ajouter_elem_liste_melodie(liste, elem)
{

    if (liste.length < indice_int)
    {
        liste.push(elem);
        
        if (melodie_int[it] == elem)
        {
            it++;
        }
        else
        {	
            let t_form = 2000;
		    const func_form = setTimeout(form_send, t_form, liste);
        }
    }
    if (liste.length == indice_int)
    {
        let t_form = 2000;
	    const func_form = setTimeout(form_send, t_form, liste);
    }
}


//Son au click

function JouerSon(touche_son) {
    var sound = document.getElementById(touche_son);
    sound.play();
}



//Pour desactiver les touches cliquables du piano


function touches_func()
{
    for(let i = 1; i <= 7; i++)
    {
        var num = i;
        var cle_string = num.toString();
        document.getElementById(cle_string).disabled = true;
    }
}




//Pour Cacher des images

function chgimage_action(id, i, taille)
{
    i++;
    var id_string = id;
    var id_int = parseInt(id_string);
    id_int = id_int - 7;
    var id_string7 = id_int.toString();
    document.getElementById(id).style.visibility = "hidden";
    document.getElementById(id_string7).style.visibility = "visible";
    if (i < taille)
    {
        let t = 0;
        const func_image = setTimeout(touches_partie, t, i);
    }
}


//Pour afficher les cases qui doivent être joués

function touches_partie(i)
{
    //boucle recursive pour afficher les images
    var num = melodie_int[i] + 7;  //+7 pour prendre le images des cases qui vont au dessus, qui doivent être joués
    var cle_string = num.toString();
    var num_i = melodie_int[i];
    var cle_string_i = num_i.toString();
    document.getElementById(cle_string).style.visibility = "visible";
    document.getElementById(cle_string_i).style.visibility = "hidden";
    var taille = melodie_int.length;
    let temps_chg = 1000;
    const compteur_fonct = setTimeout(chgimage_action, temps_chg, cle_string, i, taille);

    //boucle standard pour pouvoir cliquer
    for(let i = 1; i <= 7; i++)
    {
        var num = i;
        var cle_string = num.toString();
        document.getElementById(cle_string).disabled = false;
    }
}

