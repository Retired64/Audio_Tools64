#!/bin/bash
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"
RESET="\e[0m" 

convert_mp3_to_aiff() {
    echo -e "${MAGENTA}Convirtiendo archivos MP3 a AIFF...${RESET}"
if ! command -v ffmpeg &> /dev/null; then
    echo -e "${RED}ffmpeg no está instalado. Por favor, INSTALALO Con La opcion 4.{RESET}"
    exit 1
fi

for mp3_file in *.mp3; do
    if [ -f "$mp3_file" ]; then
        output_file="${mp3_file%.*}.aiff"
        ffmpeg -i "$mp3_file" -vn "$output_file"
        if [ $? -eq 0 ]; then
            echo "La conversión de '$mp3_file' a '$output_file' se completó con éxito."
        else
            echo "Se produjo un error durante la conversión de '$mp3_file' a '$output_file'."
        fi
    fi
done
rm -f *.mp3

echo -e "${YELLOW}Proceso de conversión a AIFF completado.${RESET}"

}

convert_audio_to_mp3_mono() {
    echo -e "${YELLOW}Convirtiendo archivos de audio a MP3 mono...${RESET}"
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg no está instalado. Por favor, instálalo con 'pkg install ffmpeg'."
    exit 1
fi

convert_to_mp3_mono() {
    input_file="$1"
    output_file="${input_file%.*}_mono.mp3"

    ffmpeg -i "$input_file" -ac 1 -codec:a libmp3lame -q:a 2 "$output_file"

    if [ $? -eq 0 ]; then
        echo "La conversión de '$input_file' a MP3 mono se completó con éxito."
    else
        echo "Se produjo un error durante la conversión de '$input_file'."
    fi
}

for audio_file in *.mp3 *.wav *.flac *.ogg; do
    if [ -f "$audio_file" ]; then
        convert_to_mp3_mono "$audio_file"
    fi
done

echo -e "${YELLOW}Proceso de conversión a MP3 mono completado.${RESET}"

}

remove_spaces_in_filenames() {
    echo -e "${YELLOW}Eliminando espacios en nombres de archivos...${RESET}"
for file in *; do
    if [[ "$file" == *" "* ]]; then
        new_name="${file// /_}"
        
        mv "$file" "$new_name"
        
        if [ $? -eq 0 ]; then
            echo "Se ha renombrado '$file' a '$new_name'."
        else
            echo -e "${RED}Error al renombrar '$file' a '$new_name'.${RESET}"
        fi
    fi
done

echo -e "${YELLOW}Proceso de eliminación de espacios en nombres de archivos completado.${RESET}"

}
instalar_ffmpeg() {
echo "Instalando ffmpeg..."
    pkg install ffmpeg -y
    if [ $? -eq 0 ]; then
        echo -e "${YELLOW}ffmpeg se ha instalado correctamente.${RESET}"
    else
        echo -e "${RED}Error al instalar ffmpeg.${RESET}"
    fi
}
show_banner() {
    clear
    echo -e "\e[33m
   __  __ ____  _   _ ____  _ 
  |  \/  |  _ \| | | |  _ \/ |
  | |\/| | | | | | | | | | | |
  | |  | | |_| | |_| | |_| | |
  |_|  |_|____/ \___/|____/|_|
  \e[0m
MadeBy: XxCmbRxX==> ${CYAN}[[[${RESET}${MAGENTA}PRIMERO${RESET}${CYAN}]]]${RESET} LA OPCION ${RED}[${RESET}${GREEN}√${RESET}${RED}]${RESET} ${CYAN}4${RESET}"
}
while true; do
    show_banner
    echo -e "\n${RED}[${RESET}√${RED}]${RESET}1. ${BLUE}Convertir${RESET} ${YELLOW}archivos MP3 a AIFF${RESET}"
    echo -e "\n${RED}[${RESET}√${RED}]${RESET}2. ${BLUE}Convertir${RESET} ${YELLOW}archivos ${YELLOW}(audio a MP3 mono)${RESET}"
    echo -e "\n${RED}[${RESET}√${RED}]${RESET}3. ${BLUE}Eliminar${RESET}  ${GREEN}espacios en nombres de archivos${RESET}"
    echo -e "\n${RED}[${RESET}√${RED}]${RESET}4. ${YELLOW}Instalar${RESET}  ${GREEN}ffmpeg (si no está instalado)${RESET}"
    echo -e "\n${RED}[${RESET}√${RED}]${RESET}5. ${RED}Salir${RESET}"

    read -p $'\n\e[36mSeleccione una opción\e[0m [\e[31m1\e[0m] [\e[32m2\e[0m] [\e[33m3\e[0m] [\e[34m4\e[0m] [\e[35m5\e[0m]: ' choice
    case $choice in
        1)
            convert_mp3_to_aiff
            ;;
        2)
            convert_audio_to_mp3_mono
            ;;
        3)
            remove_spaces_in_filenames
            ;;
        4)
           instalar_ffmpeg
           ;;
        5)
            echo -e "\n         ¡¡¡ Hasta Luego, Excelente Dia !!!"
            exit 0
            ;;
        *)
            echo "Opción no válida. Por favor, seleccione una opción válida."
            ;;
    esac
done
#read -p $'\n\e[36mSeleccione una opción [\e[31m1\e[0m] [\e[32m2\e[0m] [\e[33m3\e[0m] [\e[34m4\e[0m] [\e[35m5\e[0m]: ' choice

#read -p $'\n\e[36mSeleccione una opción [1] [2] [3] [4] [5]:\e[0m ' choice
