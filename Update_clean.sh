#!/bin/bash
# update_clean.sh - System update and cleanup
set -e  # Exit script if any command fails 

log_error() {
    echo "Error: $1"
    exit 1
}

echo "Updating system..."
sudo apt update -y || log_error "Failed to update package lists. Check network connection."
sudo apt upgrade -y || log_error "Failed to upgrade packages. Resolve package conflicts or broken dependencies."

# Prompt the user for permission to remove unnecessary packages
while true; do
    echo "Do you want to remove deprecated packages that were installed as dependencies but are no longer needed? (y/n)"
    read -r response 
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        sudo apt autoremove -y || log_error "Failed to remove deprecated packages."
        sudo apt autoclean -y || log_error "Failed to clean package cache."
        break
    elif [[ "$response" =~ ^([nN][oO]|[nN])$ ]]; then
        echo "Skipping package removal and cleanup."
        break
    else
        echo "Invalid input. Please enter 'y' or 'n'."
    fi
done

echo "System updated and cleaned successfully."
