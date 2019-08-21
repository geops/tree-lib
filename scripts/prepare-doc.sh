#!/bin/bash

###
# This script build creates the documentation page, made with documentation.js.
###

Remove the old files from doc folder.
if rm -rf doc/build; then
  echo "Documentation folder emptied."
else
  echo "Empty doc folder failed."
  exit 1
fi

# Build a build folder inside doc directory
if [[ ! -d "./doc/build" ]]
then
    if [[ ! -L $dirname ]]
        then
            echo "Build Directory doesn't exist. Creating now"
                mkdir "./doc/build"
            echo "Directory created"
        else
            echo "Directory exists"
    fi
fi

# Build jsdoc documentation for src, in jsdoc folder (based on jsdoc_conf.json).
if node ./scripts/doc.js; then 
  echo "jsdoc build suceeds."
else
  echo "Building jsdoc failed."
  exit 1
fi


# Rename jsdoc index.html and move in documentation folder.
if mv docjs/index.html doc/build/docjs.html; then
  echo "Move and rename docjs index suceeds."
else
  echo "Move and rename docjs index failed."
  exit 1
fi

# Move all jsdoc build in documentation folder.
if mv docjs/* doc/build; then
  echo "Move docjs build suceeds."
else
  echo "Move docjs build failed."
  exit 1
fi

# Remove emtpy folder.
if rm -r docjs; then
  echo "Remove emtpy folder suceeds."
else
  echo "Remove emtpy folder failed."
  exit 1
fi