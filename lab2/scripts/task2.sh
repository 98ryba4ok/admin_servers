#!/bin/bash


if [ -z "$1" ]; then  echo "Usage: $0 /path/to/directory"
  exit 1
fi

TARGET_DIR="$1"


if [ ! -d "$TARGET_DIR" ]; then
  echo "Ошибка: '$TARGET_DIR' не является директорией."
  exit 1
fi

function human_readable() {
  local size=$1
  if [ "$size" -lt 1024 ]; then
    echo "${size}B"
  elif [ "$size" -lt 1048576 ]; then
    echo "$(gawk "BEGIN { printf \"%.1fK\", $size/1024 }")"
  elif [ "$size" -lt 1073741824 ]; then
    echo "$(gawk "BEGIN { printf \"%.1fM\", $size/1048576 }")"
  else
    echo "$(gawk "BEGIN { printf \"%.1fG\", $size/1073741824 }")"
  fi
}



total_size=0
while IFS= read -r size; do
  total_size=$((total_size + size))
  echo "$size"
done < <(find "$TARGET_DIR" -type f -printf "%s\n")


readable_size=$(human_readable "$total_size")
echo "$TARGET_DIR: $readable_size"

