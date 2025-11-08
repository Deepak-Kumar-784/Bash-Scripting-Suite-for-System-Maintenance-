#!/bin/bash
# backup.sh - Automated backup script with error handling and flexible backup destination

# Exit script on error, unset variables, or pipe failure
set -euo pipefail

log_error() {
    echo "Error: $1"
    exit 1
}

# Prompt user for folder to back up; default to $HOME if empty
read -p "Enter folder path to back up (default: $HOME): " SOURCE
SOURCE=${SOURCE:-$HOME}

# Validate source directory exists and is a directory
if [ ! -d "$SOURCE" ]; then
    log_error "Source directory does not exist or is not a directory: $SOURCE"
fi

# Prompt user for directory to save backups; handle default and create if needed
read -p "Enter directory path to save backups (default: 'Backup_Data' folder in current directory): " DEST
if [ -z "$DEST" ]; then
    BACKUP_DATA_DIR="./Backup_Data"
    if [ ! -d "$BACKUP_DATA_DIR" ]; then
        echo "'Backup_Data' folder not found in current directory. Creating it now..."
        mkdir -p "$BACKUP_DATA_DIR" || log_error "Failed to create directory: $BACKUP_DATA_DIR"
    fi
    DEST="$BACKUP_DATA_DIR"
fi

# Check and create destination directory if it does not exist
if [ ! -d "$DEST" ]; then
    echo "Backup directory '$DEST' not found. Creating it now..."
    mkdir -p "$DEST" || log_error "Failed to create backup directory: $DEST"
fi

# Prepare timestamped backup file name
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$DEST/backup_$DATE.tar.gz"

# Create logs directory for error logs inside current directory system_maintenance_suite/logs
LOG_DIR="./system_maintenance_suite/logs"
mkdir -p "$LOG_DIR" || log_error "Failed to create log directory: $LOG_DIR"
ERROR_LOG="$LOG_DIR/backup_error_$DATE.log"

echo "Backing up contents of $SOURCE ..."
if tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")" 2>> "$ERROR_LOG"; then
    echo "Backup completed successfully: $BACKUP_FILE"
else
    echo "Backup failed. Check error log: $ERROR_LOG"
fi
