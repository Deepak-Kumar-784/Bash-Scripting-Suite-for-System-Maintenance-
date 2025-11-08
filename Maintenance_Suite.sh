#!/bin/bash
# Maintenance_Suite.sh - System Maintenance Menu

while true; do
    clear
    echo "===== System Maintenance Suite ====="
    echo "1. Backup Data"
    echo "2. System Update & Cleanup"
    echo "3. Check System Logs"
    echo "4. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) sudo ./Scripts/backup.sh ;;
        2) sudo ./Scripts/Update_Clean.sh ;;
        3) sudo ./Scrippts/Log_Monitoring.sh ;;
        4) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice!";;
    esac

    read -p "Press Enter to continue..."
done
