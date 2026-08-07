#!/usr/bin/env bash

# Video Converter Wrapper Script
# Place this in your PATH for easy access

# Configuration
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
LUA_SCRIPT="${SCRIPT_DIR}/convert-video.lua"

# Check if lua script exists in same directory, otherwise check common locations
if [ ! -f "$LUA_SCRIPT" ]; then
    for dir in "$HOME/.local/bin" "$HOME/bin" "/usr/local/bin" "$HOME/.config/video-converter"; do
        if [ -f "$dir/convert-video.lua" ]; then
            LUA_SCRIPT="$dir/convert-video.lua"
            break
        fi
    done
fi

# Check if lua is installed
if ! command -v lua &> /dev/null; then
    echo "Error: Lua is not installed. Please install Lua first."
    echo "  Ubuntu/Debian: sudo apt install lua5.4"
    echo "  macOS: brew install lua"
    echo "  Arch: sudo pacman -S lua"
    exit 1
fi

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install ffmpeg first."
    echo "  Ubuntu/Debian: sudo apt install ffmpeg"
    echo "  macOS: brew install ffmpeg"
    echo "  Arch: sudo pacman -S ffmpeg"
    exit 1
fi

# Check if lua script exists
if [ ! -f "$LUA_SCRIPT" ]; then
    echo "Error: convert-video.lua not found!"
    echo "Please ensure convert-video.lua is in the same directory as this script"
    echo "or in one of these locations:"
    echo "  ~/.local/bin/convert-video.lua"
    echo "  ~/bin/convert-video.lua"
    echo "  ~/.config/video-converter/convert-video.lua"
    exit 1
fi

# Function to show interactive menu
show_menu() {
    local input_file="$1"
    
    echo "Video Converter - Select format for: $(basename "$input_file")"
    echo
    echo "1) Twitter/X       - 720p, optimized for 512MB limit"
    echo "2) Instagram Feed  - 1:1 square, 60s max"
    echo "3) Instagram Reel  - 9:16 vertical, 90s max"
    echo "4) YouTube         - 1080p high quality"
    echo "5) Discord         - Compressed for 8MB limit"
    echo "6) Discord Nitro   - Up to 50MB"
    echo "7) WhatsApp        - Optimized for 16MB limit"
    echo "8) Web Standard    - 720p balanced quality"
    echo "9) Compress        - Smaller file with H.265"
    echo "0) Cancel"
    echo
    read -p "Select option (0-9): " choice
    
    case $choice in
        1) preset="twitter" ;;
        2) preset="instagram" ;;
        3) preset="reel" ;;
        4) preset="youtube" ;;
        5) preset="discord" ;;
        6) preset="discord_nitro" ;;
        7) preset="whatsapp" ;;
        8) preset="web" ;;
        9) preset="compress" ;;
        0) echo "Cancelled"; exit 0 ;;
        *) echo "Invalid option"; exit 1 ;;
    esac
    
    lua "$LUA_SCRIPT" "$input_file" "$preset" "${@:2}"
}

# Main logic
if [ $# -eq 0 ]; then
    echo "Video Converter - Convert videos for social media and web"
    echo
    echo "Usage:"
    echo "  $(basename "$0") <video_file> [preset] [options]"
    echo "  $(basename "$0") <video_file>              # Interactive mode"
    echo "  $(basename "$0") --help                    # Show detailed help"
    echo
    echo "Examples:"
    echo "  $(basename "$0") video.mp4 twitter"
    echo "  $(basename "$0") video.mp4 discord --no-hwaccel"
    echo "  $(basename "$0") video.mp4                 # Shows menu"
    echo
    echo "Run '$(basename "$0") --help' for full documentation"
    exit 0
fi

# Pass through help and list commands
if [ "$1" = "--help" ] || [ "$1" = "-h" ] || [ "$1" = "--list" ]; then
    lua "$LUA_SCRIPT" "$@"
    exit $?
fi

# Check if input file exists
if [ ! -f "$1" ]; then
    echo "Error: File not found: $1"
    exit 1
fi

# If only input file is provided, show interactive menu
if [ $# -eq 1 ]; then
    show_menu "$1"
else
    # Pass all arguments to lua script
    lua "$LUA_SCRIPT" "$@"
fi
