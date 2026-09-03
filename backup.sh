#!/bin/bash

# backup script - backs up a folder to ~/backups
# keeps only the latest ones so disk doesn't fill up

SRC_DIR="$1"
BACKUP_DIR="$HOME/backups"
MAX_BACKUPS=7

# check if user passed a folder
if [ -z "$SRC_DIR" ]; then
    echo "Usage: $0 <folder-path>"
    echo "Example: $0 /home/ali/projects"
    exit 1
fi

# check if the folder actually exists
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: folder not found - $SRC_DIR"
    exit 1
fi

# create backup folder if it doesn't exist
mkdir -p "$BACKUP_DIR"

# build the filename with date and time
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
# extract the folder name from the path
DIR_NAME=$(basename "$SRC_DIR")
BACKUP_FILE="$BACKUP_DIR/${DIR_NAME}_backup_${TIMESTAMP}.tar.gz"

echo "Starting backup of: $SRC_DIR"
echo "Saving to: $BACKUP_FILE"
echo ""

# create the compressed backup
tar -czf "$BACKUP_FILE" -C "$(dirname "$SRC_DIR")" "$DIR_NAME"

if [ $? -eq 0 ]; then
    echo "Backup completed successfully"
    echo "File size: $(du -h "$BACKUP_FILE" | cut -f1)"
else
    echo "Error: something went wrong during backup"
    exit 1
fi

echo ""
echo "Removing old backups (keeping last $MAX_BACKUPS)..."

# delete old backups
cd "$BACKUP_DIR" || exit
BACKUP_COUNT=$(ls -1 *backup*.tar.gz 2>/dev/null | wc -l)

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
    # ls -t sorts by time, tail skips the first N (newest) and shows the rest
    ls -t *backup*.tar.gz 2>/dev/null | tail -n +$((MAX_BACKUPS + 1)) | while read -r old_backup; do
        echo "  deleting: $old_backup"
        rm -f "$old_backup"
    done
else
    echo "  No old backups to remove (have $BACKUP_COUNT, max is $MAX_BACKUPS)"
fi

echo ""
echo "Current backups in $BACKUP_DIR:"
ls -lh "$BACKUP_DIR" | grep backup
