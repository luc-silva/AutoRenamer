#!/bin/bash 

# global
## misc
root_folder="$1"
session_date=$(date +"%d-%m-%Y_%H.%M.%S")
source ../utils/tools.sh

## flags
remove_space=true
create_backup=false

# lógica principal
read -p "Deseja criar um backup [Yy/n] ? (aconselhavel, mas requer espaço. lembre-se de excluir caso tudo tenha dado certo)" option
if [[ "${option:0:1}" =~ [yY] ]]; then
    cp -r "${root_folder}" "../backup/${session_date}"
fi

prepare
renameItems "${root_folder}" 
renameDirectories "${root_folder}"