#!/usr/bin/env bash
set -euo pipefail

echo "=== iRSSi uninstall script (Debian 13, javított telepítőhöz) ==="

# --- Csomagok eltávolítása ---
echo "[INFO] irssi és curl eltávolítása..."
sudo apt remove --purge -y irssi curl
sudo apt autoremove -y
sudo apt clean

# --- Konfigurációs könyvtár törlése ---
IRSSI_DIR="$HOME/.irssi"
if [ -d "$IRSSI_DIR" ]; then
  echo "[INFO] Törlöm a $IRSSI_DIR könyvtárat..."
  rm -rf "$IRSSI_DIR"
else
  echo "[WARN] Nem található $IRSSI_DIR könyvtár."
fi

# --- Bináris segédscript törlése (ha volt) ---
if [ -f "$HOME/.local/bin/irssi-tmux" ]; then
  echo "[INFO] Törlöm az irssi-tmux scriptet..."
  rm -f "$HOME/.local/bin/irssi-tmux"
fi

# --- PATH bejegyzés tisztítása ---
SHELL_RC="$HOME/.bashrc"
[ -n "${ZSH_VERSION:-}" ] && SHELL_RC="$HOME/.zshrc"
if grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_RC"; then
  echo "[INFO] PATH bejegyzés eltávolítása a $SHELL_RC fájlból..."
  sed -i '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' "$SHELL_RC"
fi

echo "=== Uninstall kész! Az irssi és a hozzáadott konfigurációk eltávolítva. ==="
