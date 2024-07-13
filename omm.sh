#!/bin/bash

echo -e "\e[32mIniciando COMPILACIÓN....\e[0m"
sleep 3

# Actualizar e instalar paquetes necesarios
yes | pkg update && yes | pkg upgrade -y
pkg remove libglvnd
pkg install git wget make python getconf zip apksigner clang binutils libglvnd-dev aapt which -y
rm -rf $HOME/sm64ex-omm
# Clonar el repositorio
REPO_URL="https://github.com/robertkirkman/sm64ex-omm.git"
REPO_DIR="$HOME/sm64ex-omm"
git clone --recursive $REPO_URL

# Verificar si el repositorio se clonó correctamente
if [ $? -ne 0 ]; then
    echo -e "\e[31mError al clonar el repositorio. Por favor, verifica tu conexión a Internet y vuelve a intentarlo.\e[0m"
    exit 1
fi

# Asumir que el archivo baserom.us.z64 ya está en el almacenamiento interno
BASEROM_PATH="/sdcard/baserom.us.z64"

# Verificar si el archivo baserom.us.z64 existe
if [ ! -f "$BASEROM_PATH" ]; then
    echo -e "\e[31mNo se ha encontrado el archivo baserom.us.z64 en /sdcard/. Por favor, asegúrate de que está en la ubicación correcta.\e[0m"
    exit 1
fi

# Copiar el archivo baserom.us.z64 al directorio del repositorio
cp "$BASEROM_PATH" "$REPO_DIR/baserom.us.z64"
if [ $? -ne 0 ]; then
    echo -e "\e[31mError al copiar el archivo baserom.us.z64.\e[0m"
    exit 1
fi
echo -e "\e[32mArchivo baserom.us.z64 encontrado y copiado exitosamente.\e[0m"

# Cambiar al directorio del repositorio
cd $REPO_DIR

# Verificar si el archivo baserom.us.z64 está en el directorio del repositorio
if [ -f "baserom.us.z64" ]; then
    # Ejecutar el script de extracción de assets
    python extract_assets.py us
    if [ $? -ne 0 ]; then
        echo -e "\e[31mError al extraer los assets.\e[0m"
        exit 1
    fi
else
    echo -e "\e[31mEl archivo baserom.us.z64 no está en el directorio del repositorio.\e[0m"
    exit 1
fi

# Descargar y descomprimir el archivo de sonido
SOUND_URL="https://github.com/Retired64/sounds/raw/main/sound.zip"
SOUND_DIR="$REPO_DIR/sound/samples"
wget $SOUND_URL
if [ $? -ne 0 ]; then
    echo -e "\e[31mError al descargar el archivo de sonido.\e[0m"
    exit 1
fi
mkdir -p $SOUND_DIR
unzip -o sound.zip -d $SOUND_DIR
if [ $? -ne 0 ]; then
    echo -e "\e[31mError al descomprimir el archivo de sonido.\e[0m"
    exit 1
fi

# Compilar el juego
make
if [ $? -ne 0 ]; then
    echo -e "\e[31mError al compilar el juego.\e[0m"
    exit 1
fi

# Verificar si se compiló exitosamente el APK
APK_PATH="$REPO_DIR/build/us_pc/sm64.us.f3dex2e.apk"
if [ -f "$APK_PATH" ]; then
    # Copiar el APK compilado a la carpeta de almacenamiento externo
    cp "$APK_PATH" /storage/emulated/0/
    if [ $? -ne 0 ]; then
        echo -e "\e[31mError al copiar el APK compilado.\e[0m"
        exit 1
    fi
    echo -e "\e[32mAPK compilado copiado a /storage/emulated/0/ exitosamente.\e[0m"
else
    echo -e "\e[31mError: No se pudo compilar el APK correctamente.\e[0m"
fi

# Salir del script
exit 0
