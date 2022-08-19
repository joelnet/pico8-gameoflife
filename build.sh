#!/bin/sh

DIR=$(pwd)
FILE_HTML=$DIR/life.html
FILE_JS=$DIR/life.js
FILE_PART=./html/_part.html
FILE=`cat $FILE_PART`
BUILD_HTML=./docs/life.html
DELIM='<!-- Add content below the cart here -->'

if [ ! -f "$FILE_HTML" ]; then
  echo "File $FILE_HTML expected to exist."
  exit 1
fi

mkdir -p docs/
mv "$FILE_HTML" docs/
mv "$FILE_JS" docs/

# STRING=`cat docs/life.html`

# node -p "fs=require('fs');fs.readFileSync('$BUILD_HTML', 'utf8').replace('$DELIM',fs.readFileSync('$FILE_PART', 'utf8'))" > build/life2.html
# rm build/life.html
# mv build/life2.html build/life.html
