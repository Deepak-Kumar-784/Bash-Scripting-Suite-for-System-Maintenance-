# Bash Scripting Suite for System Maintenance

## Overview

The **Bash System Maintenance Suite** is a menu-driven automation project for Linux system maintenance. It simplifies routine tasks like automated backups, system updates, cleanup, and log monitoring, providing a user-friendly interface for administrators.

---

## Features

1. **System Backup**

   - Prompts user for file/folder path to back up
   - Confirms before creating backup
   - Saves compressed `.tar.gz` files in `backups/`
   - Logs actions in `logs/backup.log`

2. **System Update & Cleanup**

   - Updates package lists and upgrades installed packages
   - Optionally removes deprecated packages and cleans cache
   - Handles errors gracefully

3. **Log Monitoring**

   - Scans `/var/log/syslog` for errors, warnings, critical messages, or failures
   - Saves alerts in `logs/alerts.txt`
   - Logs activities in `logs/monitor.log`

4. **Menu-Based Automation**

   - Interactive menu to run all scripts
   - Validates input and provides feedback

---

## Project Structure

```
bash_maintenance_suite/
 ├─ scripts/
 │   ├─ backup_Script.sh      # Automated backup
 │   ├─ update_Clean.sh       # System update and cleanup
 │   ├─ log_monitor.sh        # Log monitoring
 │   └─ menu.sh               # Main menu interface
 ├─ backups/                  # Stores compressed backup files
 └─ logs/                     # Stores log files and alerts
```

---

## Installation & Setup

1. Clone the repository:

```bash
git clone <repository-url>
cd bash_maintenance_suite
```

2. Open in VS Code:

```bash
code .
```

3. Create or edit the scripts in the `scripts/` folder and paste the respective code.
4. Make scripts executable:

```bash
chmod +x scripts/*.sh
```

---

## Usage

Run the main menu:

```bash
./scripts/menu.sh
```

Menu options:

- `1` → Run Backup
- `2` → System Update & Cleanup
- `3` → Monitor System Logs
- `4` → Exit

Follow on-screen prompts for each task.

---

## Logging

- `logs/backup.log` → Backup activities
- `logs/monitor.log` → Log monitoring activities
- `logs/alerts.txt` → Alerts detected in system logs

---

## Requirements

- Linux OS (Ubuntu recommended)
- Bash shell
- Utilities: `tar`, `grep`, `apt`
- `sudo` privileges for system updates and cleanup

---

## Notes

- Keep `backups/` and `logs/` directories intact
- Confirm prompts before backup or cleanup actions
- Designed for safe and repeatable system maintenance
