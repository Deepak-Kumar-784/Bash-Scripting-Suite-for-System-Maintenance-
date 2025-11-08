#!/bin/bash
# update_clean.sh - System update and cleanup

echo "Updating system..."
sudo apt update -y && sudo apt upgrade -y
sudo apt autoremove -y && sudo apt autoclean -y

if [ $? -eq 0 ]; then
    echo "System updated and cleaned successfully."
else
    echo "Update/Cleanup failed. Check logs."
fi
