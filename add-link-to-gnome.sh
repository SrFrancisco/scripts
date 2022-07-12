#!/bin/bash
DEBUG=0

Color_Off='\033[0m'
BGreen='\033[1;32m'
BCyan='\033[1;36m'

read -p 'Name of the program: ' program_name
read -p 'Icon: ' program_icon
read -p 'Command: ' program_exec_comand

var="[Desktop Entry]\nEncoding=UTF-8\nVersion=1.0\nType=Application\nTerminal=false\nExec=${program_exec_comand}\nName=${program_name}\nIcon=${program_icon}"

program_name_underscore="${program_name// /_}"

echo -e "content that will be saved in $BCyan${program_name_underscore}.desktop$Color_Off:"
echo -e ${BCyan}${var}${Color_Off}


path="${HOME}/.local/share/applications/${program_name_underscore}.desktop"

if test -f "$path"; then
    echo "$FILE exists."
    exit 1
else
    echo -e ${var} > ${path}
    echo "Done"
fi

read -p 'Would you like to append this file to the favourite apps? [Y/n] ' favourite_decision
if [[ ${favourite_decision} == 'Y' ]]; then

    favourite_apps_string=$(dconf read /org/gnome/shell/favorite-apps)

    # cut -c 2- --> remove o primeiro caracter da string
    # dessa forma usamos o comando rev para reverter a string, removemos
    # o primeiro elemento e depois voltamos a por tudo como estava
    return_str=$(echo $favourite_apps_string | rev | cut -c 2- | rev)

    return_str+=", '${program_name_underscore}.desktop']"
    
    if [[ $DEBUG == 1 ]]; then
        echo $return_str
    fi

    $(dconf write /org/gnome/shell/favorite-apps "$return_str")
else
    exit 0
fi