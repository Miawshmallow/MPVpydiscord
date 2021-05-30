#!/bin/bash
function instalar(){
mkdir -p ~/.config/mpv/scripts/
sudo apt-get install python3-pip 
sudo pip3 install pypresence
cp -rf scripts/*  ~/.config/mpv/scripts/
}
function remover(){
rm ~/.config/mpv/scripts/main.lua
rm ~/.config/mpv/scripts/py/presence.py
}

case $1 in
  instalar)
   instalar
   exit 0
  ;;
  remover)
   remover
  ;;

  
 
  *)
   echo "Escolha uma opção válida { instalar | remover }"
   echo
esac
