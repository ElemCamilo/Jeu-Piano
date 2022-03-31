
//Fonction click des touches

function clickit(touche)
{
    ajouter_elem_liste_melodie(melodie_joue, touche);
}


//Fonction pour envoyer le form

function form_send(liste_form)
{
	touches_func();
    document.getElementById('score').value = score_int;
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
            score_int++;
        }
        else
        {
            touches_func();
            let t_form = 2000;
		    const func_form = setTimeout(form_send, t_form, liste);
        }
    }
    if (liste.length == indice_int)
    {
        touches_func();
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

//Partie newgame fonctions changement d'image


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
    else
    {
        for(let i = 1; i <= 7; i++)  //boucle standard pour pouvoir cliquer
        {
            var num = i;
            var cle_string = num.toString();
            document.getElementById(cle_string).disabled = false;
        }
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

}





//Partie revoir_partie fonctions changement d'image

function revoir_coup_voir(iV)
{
    //boucle recursive pour afficher les images
    var numV = liste_coup[iV] + 7;  //+7 pour prendre les images des cases qui vont au dessus, qui doivent être joués
    var cle_stringV = numV.toString();
    var num_iV = liste_coup[iV];
    var cle_string_iV = num_iV.toString();
    document.getElementById(cle_stringV).style.visibility = "visible";
    JouerSon(dict[num_iV]);
    document.getElementById(cle_string_iV).style.visibility = "hidden";
    let temps_chgV = 1000;
    const compteur_fonctV = setTimeout(revoir_coup_cacher, temps_chgV, cle_stringV, iV);
}

function revoir_coup_cacher(idV, iV)
{
    iV++;
    var id_stringV = idV;
    var id_intV = parseInt(id_stringV);
    id_intV = id_intV - 7;
    var id_string7V = id_intV.toString();
    document.getElementById(idV).style.visibility = "hidden";
    document.getElementById(id_string7V).style.visibility = "visible";
    if (iV < max)
    {
        let t = 0;
        const func_imageV = setTimeout(revoir_coup_voir, t, iV);
    }
    if (max < liste_coup.length)
    {   
        var thing_somme = max + cpt;
        if (thing_somme > liste_coup.length)
        {
            max = liste_coup.length;
            let t = 0;
            const func_imageV = setTimeout(revoir_coup_voir, t, iV);
        }
        else
        {
            max += cpt;
            cpt += 1;
            let t = 0;
            const func_imageV = setTimeout(revoir_coup_voir, t, iV);
        }
    }
}



//Ici les fonctions pour faire AJAX avec Javascript
function loadDoc(url, cFunction) {
  //la variable ur contient l'id qui est une variable obtenue depuis la BD par Python
  var xhttp;
  xhttp=new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      cFunction(this);
    }
  };
  xhttp.open("GET", url, true);
  xhttp.send();
}
function myFunction(xhttp) {
  document.getElementById("detail").innerHTML =
  xhttp.responseText;
}


function change_yes(chiffre)
{
    document.getElementById('b1').setAttribute('onclick',"loadDoc('/topdj?jours="+chiffre+"', myFunction)");
}