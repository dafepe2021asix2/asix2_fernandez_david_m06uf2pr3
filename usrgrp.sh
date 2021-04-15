#!/bin/bash

crusr(){
	echo "Nom d'usuari"
	read nomUsuari
	
	echo "UID:"
	read uidUsuari
	
	echo "Grup(deixa en blanc per 'users'):"
	read grupUsuari
	if [ -z "$grupUsuari" ]
	then
		grupUsuari="users"
	fi
	
	home="/home/"$nomUsuari
	
	cont="0"
	while [ ${#cont} -lt 6 ]
	do
		echo "Contrasenya(no es permet en blanc o menor a 6 caracters: "
		read cont
	done 
	echo "$cont"
	
	useradd  $nomUsuari  -u  $uidUsuari  -g  $grupUsuari  -d  $home  -m  -s  /bin/bash  -p  $(mkpasswd  $cont)
	
}
cgrp(){
	echo "Nom del grup"
	read nomGrup
	
	echo "GID:"
	read gidGrupo
	
	if sudo groupadd -g "$gidGrupo" "$nomGrup" ;then
		echo "Grup creat correctament"
	else
		echo "Grup no creat correctament"
	fi
	
}

afegr(){
	until id "$usuario" > /dev/null 2>&1
	do
		echo "Usuario(asegurat que existeix): "
		read usuario
	done
	echo "$usuario"
	grupo="no"
	until  grep -w -q "$grupo" /etc/group
	do
		echo "Grupo(asegurat que existeix): "
		read grupo
	done 
	echo "$grupo"
	
	if sudo usermod -a -G "$grupo" "$usuario" ;then
		echo "Usuari afegit a grup creat correctament"
	else
		echo "Usuari no afegit a grup correctament"
	fi
}
esbgr(){
	until id "$usuario" > /dev/null 2>&1
	do
		echo "Usuario(asegurat que existeix): "
		read usuario
	done
	echo "$usuario"
	grupo="no"
	until  grep -w -q "$grupo" /etc/group
	do
		echo "Grupo(asegurat que existeix): "
		read grupo
	done 
	echo "$grupo"
	
	if sudo gpasswd -d "$usuario" "$grupo"   ;then
		echo "Usuari eliminat correctament"
	else
		echo "Usuari eliminat correctament"
	fi

}
function menu {
	echo "a) Crea usuari"
	echo "b) Crea grup"
	echo "c) Agegeix un usuari a un grup"
	echo "d) Treu un usuari d'un grup"
}

if [[ "$(id -u)" != "0" ]]
then
	echo "Executa aquet script como root"
	exit 1
fi
bucle="s"
while [ $bucle = "s" ]
do
	menu
	read selc

	case $selc in

	  a)
		clear
		crusr
		clear
		echo "vols torna a executar alguna funcio?"
		read bucle
		;;

	  b)
		clear
		cgrp
		echo "vols torna a executar alguna funcio?"
		read bucle
		;;

	  c)
		clear
		afegr
		echo "vols torna a executar alguna funcio?"
		read bucle
		;;
	  d)
		clear
		esbgr
		echo "vols torna a executar alguna funcio?"
		read bucle
		;;

	  *)
		echo "Opcion no registrada"
		echo "vols torna a executar alguna funcio?"
		read bucle
		;;
	esac
done
