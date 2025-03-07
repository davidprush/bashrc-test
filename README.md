# Custom Bash Configuration Script

This script enhances the Bash shell startup process with additional features like environment setup, a Fish shell switcher, and storage information display.

## Features

1. **Environment Setup**
   - Sources global definitions from `/etc/bashrc`
   - Adds user-specific bin directories to PATH
   - Loads user-defined aliases and functions from `~/.bashrc.d/`

2. **Fish Shell Integration**
   - Checks for Fish shell availability
   - Offers to switch to Fish shell with a 30-second timeout
   - Displays a colored progress bar during countdown
   - Runs `neofetch` (if installed) before switching to Fish

3. **Storage Information**
   - Shows root filesystem usage with:
     - Device name
     - Used/total space
     - Visual usage bar
     - Available space
   - Uses ANSI colors for better readability

## Requirements

- Bash shell
- Optional: Fish shell (`/usr/bin/fish`)
- Optional: Neofetch (`/usr/bin/neofetch`)
- Standard Unix utilities: `df`, `awk`, `tput`

## Installation

1. Save the script as `.bashrc` in your home directory:
```bash
cp script.sh ~/.bashrc
```

## Make it executable:
```bash
chmod +x ~/.bashrc
```

## (Optional) Create a .bashrc.d directory for additional scripts:
```bash
mkdir ~/.bashrc.d
```

## Usage
The script runs automatically when starting a new Bash session. It will:

1. Configure your environment
3. Display storage information
5. Prompt to switch to Fish shell (if installed)
7. Press 'f' to switch within 30 seconds
9. Wait or press any other key to continue with Bash

## Customization

- Modify the timeout variable to change the countdown duration
- Adjust bar_width and storage_bar_width for progress bar lengths
- Change ANSI color codes (GREEN, BLUE, etc.) for different colors
- Add custom scripts to ~/.bashrc.d/ for additional functionality

## Color Scheme

- Green: Positive messages, available space
- Blue: Storage device info, current shell
- Yellow: Usage stats, percentages
- Cyan: Progress bar brackets
- Magenta: Filled progress bar
- Red: Timeout warnings
