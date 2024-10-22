#!/bin/bash
# Programa para ofuscar y minificar ficheros a partir de un directorio
#Autor:ALex:D - @soygeekgirl

#  chmod +x ofuscales.sh
#  ./ofuscales.sh DdirectorioAEjecutar

## Previamente debes tener instalado de forma global los paquetes de
## npm javascript-obfuscator y uglifyjs

# Para ofuscar
function ofuscar_js() {
    javascript-obfuscator "$1" -o "${1%.js}.obf.js"
}

# Para minificar
function minify_js() {
    uglifyjs "${1%.js}.obf.js" -o "${1%.js}.min.js" --mangle --compress
}
#Elimina el fichero ofuscado previamente
function clear_obf() {
    rm "${1%.js}.obf.js"
}

# # Verificar si se proporcionó un directorio como argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <folder>"
    exit 1
fi

# # Obtener el directorio especificado
folder="$1"

# # Recorrer todos los ficheros .js en el directorio y sus subdirectorios
find "$folder" -name "*.js" -print0 | while IFS= read -r -d '' file; do
    echo " Ofuscando y minificando: $file"
    ofuscar_js "$file"
    obf_file="${file%.js}.js"
    minify_js "$obf_file"
    clear_obf "$obf_file"
done