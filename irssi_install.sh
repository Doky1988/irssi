#!/usr/bin/env bash
set -euo pipefail

echo "=== iRSSi telepítő és konfiguráló script (Debian 13, több csatorna támogatással, javított channels blokk) ==="

# --- Csomagok telepítése ---
sudo apt update -y
sudo apt install -y irssi curl

# --- Felhasználói adatok bekérése ---
read -rp "Add meg a nick neved: " IRC_NICK
read -rp "Add meg a felhasználóneved (ident): " IRC_USER
read -rp "Add meg a valódi neved: " IRC_REAL
read -rp "Add meg a hálózat nevét (pl. ATW): " IRC_NETNAME
read -rp "Add meg a szerver címét (pl. irc.atw-inter.net): " IRC_SERVER
read -rp "Add meg a portot (pl. 6667): " IRC_PORT
read -rp "Add meg a csatornákat szóközzel elválasztva (pl. #doky #linux #magyar): " IRC_CHANNELS

# --- Könyvtárak létrehozása ---
IRSSI_DIR="$HOME/.irssi"
SCRIPTS_DIR="$IRSSI_DIR/scripts"
AUTORUN_DIR="$IRSSI_DIR/scripts/autorun"
THEMES_DIR="$IRSSI_DIR/themes"
mkdir -p "$IRSSI_DIR" "$SCRIPTS_DIR" "$AUTORUN_DIR" "$THEMES_DIR"

# --- Konfig fájl létrehozása ---
CONFIG_FILE="$IRSSI_DIR/config"

# Csatornák feldolgozása (helyes formátum)
CHANNEL_BLOCK=""
for ch in $IRC_CHANNELS; do
  CHANNEL_BLOCK="${CHANNEL_BLOCK}  { name = \"$ch\"; chatnet = \"$IRC_NETNAME\"; autojoin = \"yes\"; }\n"
done

cat > "$CONFIG_FILE" <<EOF
settings = {
  core = {
    real_name = "$IRC_REAL";
    user_name = "$IRC_USER";
    nick = "$IRC_NICK";
  };
};

servers = (
  { address = "$IRC_SERVER"; port = "$IRC_PORT"; chatnet = "$IRC_NETNAME"; use_ssl = "no"; }
);

chatnets = {
  $IRC_NETNAME = {
    type = "IRC";
    nick = "$IRC_NICK";
    real_name = "$IRC_REAL";
    username = "$IRC_USER";
  };
};

channels = (
$(echo -e "$CHANNEL_BLOCK")
);
EOF

# --- Startup fájl: automatikus connect és join ---
cat > "$IRSSI_DIR/startup" <<EOF
# Automatikus csatlakozás a megadott hálózatra és belépés a csatornákba
/connect $IRC_NETNAME
EOF

for ch in $IRC_CHANNELS; do
  echo "/join $ch" >> "$IRSSI_DIR/startup"
done

# --- Hasznos scriptek letöltése ---
declare -A SCRIPT_URLS=(
  ["nickcolor.pl"]="https://scripts.irssi.org/scripts/nickcolor.pl"
  ["hilightwin.pl"]="https://scripts.irssi.org/scripts/hilightwin.pl"
  ["adv_windowlist.pl"]="https://scripts.irssi.org/scripts/adv_windowlist.pl"
)

for name in "${!SCRIPT_URLS[@]}"; do
  url="${SCRIPT_URLS[$name]}"
  dest="$SCRIPTS_DIR/$name"
  curl -fsSL "$url" -o "$dest" || echo "Nem sikerült letölteni: $name"
  ln -sf "../$name" "$AUTORUN_DIR/$name"
done

# --- Téma létrehozása ---
cat > "$THEMES_DIR/simple.theme" <<'EOF'
default_color = "%n";
format = {
  timestamp = "%K[%W$0%K]%n";
};
EOF

echo "=== Kész! Indítsd az irssi-t, és automatikusan csatlakozni fog a megadott hálózatra és csatornákra. ==="
