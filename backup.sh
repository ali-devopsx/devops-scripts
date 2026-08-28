#!/bin/bash

# ==========================================
# Simple backup script
# Backs up a folder to a backup location
# with a timestamp, and keeps only the last
# 7 backups to save space.
# ==========================================

# --- CONFIGURATION ---
# You can pass a folder as the first argument
SOURCE="${1:-$HOME/Documents}"
BACKUP_DIR="$HOME/backups"
KEEP_LAST=7

# --- CHECK THAT THE SOURCE EXISTS ---
if [ ! -d "$SOURCE" ]; then
    echo "Error: source folder not found: $SOURCE"
    echo "Usage: $0 [folder-to-backup]"
    exit 1
fi

# --- CREATE BACKUP DIR IF NOT EXISTS ---
mkdir -p "$BACKUP_DIR"

# --- CREATE FILENAME WITH DATE ---
DATE=$(date +%Y-%m-%d_%H-%M-%S)
FILENAME="backup_$DATE.tar.gz"

# --- CREATE THE BACKUP ---
echo "Backing up $SOURCE ..."
BASENAME=$(basename "$SOURCE")
tar -czf "$BACKUP_DIR/$FILENAME" -C "$(dirname "$SOURCE")" "$BASENAME" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Backup created: $BACKUP_DIR/$FILENAME"
else
    echo "Error: backup failed!"
    exit 1
fi

# --- REMOVE OLD BACKUPS (keep only the last $KEEP_LAST) ---
cd "$BACKUP_DIR"
ls -t backup_*.tar.gz 2>/dev/null | tail -n +$((KEEP_LAST + 1)) | while read old; do
    echo "Removing old backup: $old"
    rm -f "$old"
done

echo ""
echo "Current backups:"
ls -lh "$BACKUP_DIR" | grep backup
