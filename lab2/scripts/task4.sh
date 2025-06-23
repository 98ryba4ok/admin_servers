#!/bin/bash
# ./backup.sh /var/www /backups

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 /source/directory /backup/directory"
  exit 1
fi

SRC_DIR="$1"
BACKUP_DIR="$2"


if [ ! -d "$SRC_DIR" ]; then
  echo "Ошибка: исходная директория '$SRC_DIR' не существует."
  exit 1
fi

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_NAME="$(basename "$SRC_DIR")-$TIMESTAMP.tar.gz"
ARCHIVE_PATH="$BACKUP_DIR/$ARCHIVE_NAME"


tar -czf "$ARCHIVE_PATH" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")"

if [ $? -eq 0 ]; then
  echo "Архив успешно создан: $ARCHIVE_PATH"
else
  echo "Ошибка при создании архива."
  exit 1
fi

find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +7 -exec rm -f {} \;

