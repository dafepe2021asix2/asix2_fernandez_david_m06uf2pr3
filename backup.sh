#!/bin/bash

echo "Nombre de archivo con ruta: "
read ruta
if [[ ! -d "/home/${SUDO_USER:-$USER}/FitxConfBackup" ]]
then
    mkdir "/home/${SUDO_USER:-$USER}/FitxConfBackup"
fi

fitchero=$(basename $ruta)
grep '^[^#]' $ruta  >> "/home/${SUDO_USER:-$USER}/FitxConfBackup/${fitchero}"
