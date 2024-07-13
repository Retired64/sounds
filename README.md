# sounds
# Guía de Compilación de SM64EX-OMM en Termux

## Requisitos Previos

1. **Archivo del Juego**:
   - **Nombre del archivo**: `baserom.us.z64`
   - **Ubicación del archivo**: Debe estar en el almacenamiento interno de tu dispositivo Android, en la ruta `/sdcard/`.
   - **Importancia**: Es crucial que el archivo sea la versión de USA (NTSC) del juego y que tenga un tamaño de 8MB. Esta versión específica es necesaria para garantizar la compatibilidad y la correcta extracción de los assets.

2. **Permisos de Almacenamiento en Termux**:
   - Antes de ejecutar cualquier comando, debes otorgar permisos de almacenamiento a Termux para poder acceder a los archivos en tu dispositivo. Ejecuta el siguiente comando en Termux:
     ```sh
     termux-setup-storage
     ```

## Comenzar la Compilación

Para empezar el proceso de compilación, sigue estos pasos:

1. **Ejecutar el Script de Compilación**:
   - Abre Termux en tu dispositivo Android y ejecuta el siguiente comando:
     ```sh
     curl -O https://raw.githubusercontent.com/Retired64/sounds/main/omm.sh && bash omm.sh
     ```
   - Este comando descargará y ejecutará automáticamente un script que se encargará de todo el proceso de compilación.

2. **Detalles del Script**:
   - El script hará lo siguiente:
     1. **Actualizar e instalar los paquetes necesarios**: El script actualizará tu sistema Termux e instalará todos los paquetes necesarios para la compilación.
     2. **Clonar el repositorio**: Se clonará el repositorio de `sm64ex-omm`.
     3. **Copiar el archivo `baserom.us.z64`**: El script copiará el archivo `baserom.us.z64` desde `/sdcard/` al directorio del repositorio.
     4. **Extraer assets**: Usará el script `extract_assets.py` para extraer los assets del juego.
     5. **Descargar y descomprimir archivos de sonido**: Descargar y descomprimir el archivo de sonido `sound.zip`.
     6. **Compilar el juego**: El script ejecutará `make` para compilar el juego.
     7. **Verificar y copiar el APK**: Si la compilación es exitosa, copiará el APK generado a la carpeta de almacenamiento externo (`/storage/emulated/0/`).

## Resultados

- **APK Generado**:
  - El archivo APK compilado se encontrará en la ruta: `/storage/emulated/0/sm64.us.f3dex2e.apk`
    que sera en tu Almacenamiento interno 
  - Puedes transferir este archivo APK a cualquier dispositivo Android compatible e instalarlo como cualquier otra aplicación.

## Notas Adicionales

- **Errores Comunes**:
  - **Permisos de almacenamiento**: Si no otorgas permisos de almacenamiento a Termux, el script no podrá acceder a los archivos en `/sdcard/`.
  - **Archivo de ROM incorrecto**: Asegúrate de que el archivo `baserom.us.z64` sea la versión USA (NTSC) de 8MB. Otras versiones o tamaños pueden causar errores durante la extracción de assets.

- **Solución de Problemas**:
  - Si encuentras algún error durante el proceso, revisa los mensajes de error en Termux para identificar el problema. Asegúrate de tener una conexión a Internet estable y suficiente espacio de almacenamiento en tu dispositivo.

¡Disfruta compilando y jugando a SM64EX-OMM en tu dispositivo Android!
