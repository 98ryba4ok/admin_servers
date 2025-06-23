#!/bin/bash


if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/directory"
  exit 1
fi

TARGET_DIR="$1"


if [ ! -d "$TARGET_DIR" ]; then
  echo "Ошибка: '$TARGET_DIR' не является директорией."
  exit 1
fi


cd "$TARGET_DIR" || exit 1


find . -maxdepth 1 -type f | while read -r file; do
  
  base_file="${file#./}"

  
  ext="${base_file##*.}"

  if [[ "$base_file" == "$ext" ]]; then
    
    ext="no_extension"
  fi

  
  mkdir -p "$ext"

 
  mv "$base_file" "$ext/"
done
