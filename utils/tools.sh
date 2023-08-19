prepare(){
    mkdir "./backup" "./logs"
}

createBackup() {
    mv "$1" "./backup/$1"
}

renameDirectories(){
    #directories=$(find "$1" -type d )
    readarray -d '' directories < <(find "$1" -type d -print0)
    
    for item in "${directories[@]}"; do
            if [[ "${item}" != "${root_folder}" ]]; then 

            renamed_directory=$(echo "${item}" | iconv -t ASCII//TRANSLIT | sed 's/[~'\''`]//g' )

            if [[ $remove_space == true ]]; then
                renamed_directory=$(echo ${renamed_directory} | sed 's/ /_/g' )
                mv "${item}" "${renamed_directory}" 
            fi
        fi
    done
}

renameItems() {
    for file in "$1"/* ; do 
        folder_path=$(dirname "${file}")

        if [[ -d "${file}" ]]; then
            renameItems "${file}"
        else
            if [[ remove_space == false ]]; then
                file_without_space=$(basename "${file}" | iconv -t ASCII//TRANSLIT | sed 's/~//g' )
                mv "${file}" "${folder_path}/${file_without_space}"
            else
                file_without_space=$(basename "${file}" | iconv -t ASCII//TRANSLIT | sed 's/[~'\''`]//g' | sed 's/ /_/g' )
                mv "${file}" "${folder_path}/${file_without_space}"
            fi
        fi
    done
}
