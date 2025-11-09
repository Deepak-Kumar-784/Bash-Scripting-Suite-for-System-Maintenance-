#!/bin/bash
# log_monitor.sh - Monitor a log file and alert on specific patterns

set -e  # Exit if any command fails

log_error() {
    echo "Error: $1"
    exit 1
}

# Ask user for log file
echo "Enter the absolute path of the log file to monitor (leave empty for default):"
read -r LOG_FILE

# Handle default log file selection if none provided
if [ -z "$LOG_FILE" ]; then
    if [[ -f "/var/log/syslog" ]]; then
        LOG_FILE="/var/log/syslog"
    elif [[ -f "/var/log/messages" ]]; then
        LOG_FILE="/var/log/messages"
    elif [[ -f "/var/log/auth.log" ]]; then
        LOG_FILE="/var/log/auth.log"
    else
        log_error "No default log file found. Please specify a valid log file path."
        exit 1
    fi
    echo "No path entered. Using default log file: $LOG_FILE"
fi


# Validate log file existence and readability
# Checks if file exists or not 
if [ ! -f "$LOG_FILE" ]; then
    log_error "Log file '$LOG_FILE' not found."
fi

# checks if file is readable 
if [ ! -r "$LOG_FILE" ]; then
    log_error "You don't have permission to read '$LOG_FILE'. Try running with sudo."
fi

# Ask where to save alerts
echo "Enter an absolute path to save alert results (leave empty for default 'log' folder):"
read -r SAVE_PATH

# Handle save directory logic
if [ -z "$SAVE_PATH" ]; then
    SAVE_PATH="./logs"
fi

# Verify whether the specified directory exists.
# If it does not, create the directory before saving the results inside it.
if [ ! -d "$SAVE_PATH" ]; then
    echo "Folder '$SAVE_PATH' not found. Creating it now..."
    mkdir -p "$SAVE_PATH" || log_error "Failed to create directory '$SAVE_PATH'."
fi

# Create timestamped log file
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
OUTPUT_FILE="$SAVE_PATH/log_monitor_${TIMESTAMP}.log"

echo "-------------------------------------------"
echo "Monitoring log file: $LOG_FILE"
echo "Alerts will be saved to: $OUTPUT_FILE"
echo "-------------------------------------------"


# Start monitoring
PATTERN_REGEX="error|failed|critical|unauthorized"
# tail -F "$LOG_FILE" | grep --line-buffered -Ei "$PATTERN_REGEX" | while read -r line; do
#     TIME=$(date '+%Y-%m-%d %H:%M:%S')
#     ALERT="[$TIME] ALERT: pattern found: $line"
#     echo "$ALERT"
#     echo "$ALERT" >> "$OUTPUT_FILE"
# done

stdbuf -oL -eL tail -n +1 -f "$LOG_FILE" | \
stdbuf -oL -eL awk -v regex="$PATTERN_REGEX" -v outfile="$OUTPUT_FILE" '
    BEGIN { IGNORECASE=1 }
    $0 ~ regex {
        cmd="date +\"%Y-%m-%d %H:%M:%S\""
        cmd | getline time
        close(cmd)
        alert="[" time "] ALERT: pattern found: " $0
        print alert
        print alert >> outfile
        fflush(stdout)
        fflush(outfile)
    }
'