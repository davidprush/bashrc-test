#!/usr/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Check for neofetch installation
check_neofetch() {
    local neofetch_path="/usr/bin/neofetch"
    if [ -x "$neofetch_path" ]; then
        "$neofetch_path"
    fi
}

# Check for fish shell and offer to switch
check_fish_shell() {
    local default_shell=${SHELL:-/bin/bash}
    local fish_path="/usr/bin/fish"
    local timeout=30
    local increments=300  # 30 seconds * 10 updates per second
    local bar_width=30
    local storage_bar_width=50  # Width for storage usage bar
    local choice=""
    local i

    # ANSI color codes
    local GREEN='\033[0;32m'
    local BLUE='\033[0;34m'
    local YELLOW='\033[1;33m'
    local CYAN='\033[0;36m'
    local RED='\033[0;31m'
    local MAGENTA='\033[0;35m'
    local RESET='\033[0m'

    # Skip if fish isn't installed or executable
    if [ ! -x "$fish_path" ]; then
        return
#!/bin/bash
    fi

    # Clear screen and hide cursor
    tput clear
    tput civis

    # Get storage info for root directory
    local root_dev=$(df -h / | tail -1 | awk '{print $1}')
    local root_used=$(df -h / | tail -1 | awk '{print $3}')
    local root_avail=$(df -h / | tail -1 | awk '{print $4}')
    local root_total=$(df -h / | tail -1 | awk '{print $2}')
    local root_percent=$(df -h / | tail -1 | awk '{print $5}' | tr -d '%')
    
    # Calculate storage bar
    local filled=$((root_percent * storage_bar_width / 100))
    local empty=$((storage_bar_width - filled))

    # Display storage info with colors and usage bar
    echo -e "${BLUE}Root Storage Device:${RESET} $root_dev"
    echo -e "${YELLOW}Usage:${RESET} ${root_used} used of ${root_total}"
    printf "${CYAN}[${MAGENTA}"
    printf "%${filled}s" "" | tr ' ' '█'
    printf "${RESET}${CYAN}"
    printf "%${empty}s" "" | tr ' ' ' '
    printf "${CYAN}]${RESET}${YELLOW}${root_percent}%%${RESET}\n"  # Escaped parentheses and added % symbol
    echo -e "${GREEN}Available:${RESET} ${root_avail}"
    echo

    # Function to draw progress bar with color
    draw_bar() {
        local progress=$1
        local total=$2
        local width=$3
        local filled=$((progress * width / total))
        local empty=$((width - filled))
        printf "\r${CYAN}[${GREEN}"
        printf "%${filled}s" "" | tr ' ' '█'
        printf "${RESET}${CYAN}"
        printf "%${empty}s" "" | tr ' ' ' '
        printf "]${RESET} ${YELLOW}%d%%${RESET} (${RED}%0.1fs${RESET})" $((progress * 100 / total)) $(printf "%.1f" "$(echo "$timeout - ($progress / 10)" | bc)")
    }

    # Display colored prompt
    echo -e "${GREEN}Fish shell is available!${RESET}"
    echo -e "${BLUE}Current shell:${RESET} $default_shell"
    echo
    echo -e "Press '${YELLOW}f${RESET}' to switch to fish shell, or wait ${RED}30 seconds${RESET} to continue with current shell:"

    # Countdown loop with colored progress bar
    for ((i=0; i<=increments; i++)); do
        draw_bar $i $increments $bar_width
        
        # Check for user input every 0.1 seconds
        if read -t 0.1 -n 1 input; then
            choice="$input"
            echo
            break
        fi
    done

    # Restore cursor
    tput cnorm

    # Process choice with colored output
    if [ "$choice" = "f" ] || [ "$choice" = "F" ]; then
        echo -e "${GREEN}Switching to fish shell...${RESET}"
        # Run neofetch before switching if installed
        check_neofetch
        exec "$fish_path"
    else
        echo -e "\n${BLUE}Continuing with current shell:${RESET} $default_shell"
    fi
}

# Run the fish shell checker
check_fish_shell⏎ 
