#!/bin/bash

#Welcome to Fuse4Me, a 73xt0n's tool.

#Esta herramienta la he creado para uso personal, con el objetivo de fusionar wordlists durante las pruebas de penetracion de forma rapida y evitando duplicados.

#Espero que pueda resultarte util, hazte un cafe y comprueba lo que f4m puede hacer por ti =)

########################BANNER
   
echo -e "\e[1;32m @@@@@@@@  @@@  @@@   @@@@@@   @@@@@@@@       @@@   @@@@@@@@@@   \e[0m"
echo -e "\e[1;32m @@@@@@@@  @@@  @@@  @@@@@@@   @@@@@@@@      @@@@   @@@@@@@@@@@  \e[0m"
echo -e "\e[1;32m @@!       @@!  @@@  !@@       @@!          @@!@!   @@! @@! @@!  \e[0m"
echo -e "\e[1;32m !@!       !@!  @!@  !@!       !@!         !@!!@!   !@! !@! !@!  \e[0m"
echo -e "\e[1;32m @!!!:!    @!@  !@!  !!@@!!    @!!!:!     @!! @!!   @!! !!@ @!@  \e[0m"
echo -e "\e[1;32m !!!!!:    !@!  !!!   !!@!!!   !!!!!:    !!!  !@!   !@!   ! !@!  \e[0m"
echo -e "\e[1;32m !!:       !!:  !!!       !:!  !!:       :!!:!:!!:  !!:     !!:  \e[0m"
echo -e "\e[1;32m :!:       :!:  !:!      !:!   :!:       !:::!!:::  :!:     :!:  \e[0m"
echo -e "\e[1;32m  ::       ::::: ::  :::: ::    :: ::::       :::   :::     ::   \e[0m"
echo -e "\e[1;32m  :         :::  :    : :  :    :   ::         ::    :       :   \e[0m"
echo -e "\e[1;32m             :             :         :         :             :   \e[0m"
echo -e "\e[1;32m by 73xt0n \e[0m"

########################VARIABLES

minfiles=2
wlnameset=false
wlname=
pathfileset=false
newwlcreated=false

########################FUNCIONES
#Solicita el nombre del nuevo diccionario
function wlnaming() {
    echo -e "\e[1;32m > > > > > > > > What's the new wordlist name? Without extension, please: \e[0m $wlname"
    read wlname
    echo -e "\e[1;32m > > > > > > > > Right, your new wordlist will be named $wlname.txt and be placed in the actual directory: \e[0m"
    pwd
    wlnameset=true
}

#Solicita los nombres o rutas de los diccionarios a fusionar
function pathfiles() {
    echo -e "\e[1;32m > > > > > > > > Please enter the names (or paths) of the wordlists separated by spaces: \e[0m $paths"
    read paths
    paths_array=(${paths// / }) #Crea una array y separamos los valores de la string paths por los espacios con regex
    files=${#paths_array[@]} #Comprueba que haya al menos dos achivos (minfiles)
    echo -e "\e[1;32m > > > > > > > > $files files detected. \e[0m"
    if [ $files -lt $minfiles ]; then #Si hay menos que minfiles...
        echo -e "\e[1;32m > > > > > > > > Please, enter at least two files separated by spaces. \e[0m"
        exit
    fi
    pathfileset=true
    touch f4mtemp.txt
    echo -e "\e[1;32m > > > > > > > > Temporary file created. \e[0m"
    echo -e "\e[1;32m > > > > > > > > Adding content... \e[0m"
    for path in "${paths_array[@]}"
        do
            cat $path >> f4mtemp.txt #Introduce el contenido al archivo temporal
        done
    echo -e "\e[1;32m > > > > > > > > Content added, let me fuse it for you! \e[0m"
}

#Crea el nuevo diccionario
function newwl() {
    cat f4mtemp.txt | sort | uniq > $wlname.txt #Crea output ordenado, elimina duplicados y lo inserta todo en el nuevo diccionario
    rm f4mtemp.txt
    echo -e "\e[1;32m > > > > > > > > New dictionary $wlname.txt created! Do you want to see it now? \e[0m $catq"
    read catq
    if [[ $catq =~ ([yY][eEaAhHsS]*) ]]; then #Pregunta si queremos ver el diccionario en este momento
        cat $wlname.txt
    fi
    newwlcreated=true
    echo -e "\e[1;32m ******** FUSE COMPLETED SUCCESSFULLY ******** \e[0m"
    exit
}

########################LLAMADAS

if [[ $wlnameset == false ]]; then
   wlnaming
fi

if [[ $pathfileset == false ]]; then
   pathfiles
fi

if [[ $newwlcreated == false ]]; then
    newwl
fi

#####################by 73xt0n
