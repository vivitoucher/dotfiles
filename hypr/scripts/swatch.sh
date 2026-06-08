#!/bin/bash
# 🌸 PROJECT "HER" - DYNAMIC THEME ENGINE (swatch.sh)

# Paths to our ecosystem
WALLPAPER_DIR="$HOME/.config/hypr/assets/wallpapers"
CACHE_DIR="$HOME/.cache/hypr"

# Ensure cache directory exists
mkdir -p "$CACHE_DIR"

# Step 1: Initialize swww if it isn't running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi

# Step 2: Pick a wallpaper (For now, we grab the first one found)
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | head -n 1)

if [ -z "$WALLPAPER" ]; then
    echo "🌸 System Note: No wallpapers found in $WALLPAPER_DIR yet! Add some gorgeous neon images later."
    exit 1
fi

# Step 3: Run the smooth animated transition
# --transition-type: can be wipe, wave, grow, center, etc.
swww img "$WALLPAPER" \
    --transition-type grow \
    --transition-pos "0.5,0.5" \
    --transition-step 90 \
    --transition-fps 144

echo "🚀 System: Wallpapers cycled and aesthetics refreshed smoothly!"
