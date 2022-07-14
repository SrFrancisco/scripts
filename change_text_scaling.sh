#!/bin/bash

# Script que altera o scaling do texto
# Util quando se esta sempre a alternar entre monitores de res. diferentes
    
# Scalling do texto (gnome) ----------------------------------------------------
desktopScalling=1.2
laptopScalling=1.74
value=$(dconf read /org/gnome/desktop/interface/text-scaling-factor)

# Esconde a dock (dash_to_dock_cosmic extension) -------------------------------
schemaDirBase=$HOME/.local/share/gnome-shell/extensions
# para esconder o email do autor da extensao
schemaDir=$schemaDirBase/$(ls $schemaDirBase | grep dash-to-dock-cosmic)/schemas/
schema=org.gnome.shell.extensions.dash-to-dock
key=dock-fixed

if [[ $value == $desktopScalling ]]
then
    echo "DESKTOP -> LAPTOP"
    dconf write /org/gnome/desktop/interface/text-scaling-factor $laptopScalling
    $(gsettings --schemadir ${schemaDir} set ${schema} ${key} "true")
else
    echo "LAPTOP -> DESKTOP"
    dconf write /org/gnome/desktop/interface/text-scaling-factor $desktopScalling
    $(gsettings --schemadir ${schemaDir} set ${schema} ${key} "false")
fi
