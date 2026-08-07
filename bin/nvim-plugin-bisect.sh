#!/usr/bin/env bash
# Bisect nvim plugins to find which one is causing an error: moves plugins
# to a temp backup dir, then re-adds them one at a time until you spot the culprit.

PLUGINS_DIR="${1:-$HOME/.config/nvim/lua/plugins}"
BACKUP_DIR="$(mktemp -d)/plugins_backup"

mv "$PLUGINS_DIR" "$BACKUP_DIR"
mkdir -p "$PLUGINS_DIR"

# Copy config.lua first since it's likely required
cp "$BACKUP_DIR/config.lua" "$PLUGINS_DIR/" 2>/dev/null

for file in "$BACKUP_DIR"/*.lua; do
  name=$(basename "$file")

  # Skip config.lua since we already added it
  [[ "$name" == "config.lua" ]] && continue

  cp "$file" "$PLUGINS_DIR/$name"
  echo "Added: $name"
  echo "Current plugins: $(ls "$PLUGINS_DIR" | tr '\n' ' ')"
  echo ""
  read -p "Does the error occur? (y=yes/found it, n=no/continue, q=quit) " answer

  case $answer in
    y) echo "Culprit is likely: $name"; break ;;
    q) echo "Quitting. Plugins dir left as-is. Backup at $BACKUP_DIR"; exit 0 ;;
    *) ;;  # continue
  esac
done

echo ""
read -p "Restore all plugins? (y/n) " restore
if [[ "$restore" == "y" ]]; then
  cp "$BACKUP_DIR"/*.lua "$PLUGINS_DIR/"
  echo "All plugins restored."
fi

echo "Backup left at: $BACKUP_DIR"
