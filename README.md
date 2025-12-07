# iRSSi Telepítő és Uninstall Script (Debian 13)

![Debian](https://img.shields.io/badge/Debian-13-red?logo=debian&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Bash-blue?logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Stable-success)
![Maintained](https://img.shields.io/badge/Maintained-yes-brightgreen)

Ez a repository tartalmazza az interaktív telepítő scriptet és a hozzá tartozó uninstall scriptet az irssi IRC klienshez Debian 13 alatt.  
A telepítő automatikusan konfigurálja a hálózatot, több csatornát, valamint hasznos scripteket és témát ad hozzá.

## 📦 Telepítő script

### Funkciók
- Telepíti az irssi és curl csomagokat.
- Interaktívan bekéri:
  - Nicknév
  - Felhasználónév (ident)
  - Valódi név
  - Hálózat neve
  - Szerver címe
  - Port
  - Több csatorna szóközzel elválasztva
- Létrehozza a ~/.irssi/config fájlt helyes channels blokkal.
- Automatikusan csatlakozik a hálózatra és belép a megadott csatornákra.
- Letölti és autorun-ba teszi a hasznos scripteket:
  - nickcolor.pl
  - hilightwin.pl
  - adv_windowlist.pl
- Létrehoz egy egyszerű témát (simple.theme).

### Használat

1. Hozd létre az **irssi_install.sh** fájlt terminálon:
   ```bash
   nano irssi_install.sh
2. Másold bele az itt található **irssi_install.sh** script tartalmát, majd mentsd el.
3. Adj neki futási jogot:
   ```bash
   chmod +x irssi_install.sh
4. Futtasd a scriptet:
   ```bash
   ./irssi_install.sh

## 🗑️ Uninstall script

### Funkciók
- Eltávolítja az irssi és curl csomagokat.
- Törli a teljes ~/.irssi könyvtárat (config, startup, scripts, autorun, themes).
- Eltávolítja az irssi-tmux segédscriptet, ha létezett.
- Kitakarítja a PATH bejegyzést a .bashrc vagy .zshrc fájlból.

### Használat
1. Hozd létre az **irssi_uninstall.sh** fájlt terminálon:
   ```bash
   nano irssi_uninstall.sh
2. Másold bele az itt található **irssi_uninstall.sh** script tartalmát, majd mentsd el.
3. Adj neki futási jogot:
   ```bash
   chmod +x irssi_uninstall.sh
4. Futtasd a scriptet:
   ```bash
   ./irssi_uninstall.sh

## ⚙️ Követelmények
- Debian 13
- bash
- sudo jogosultság

## 📂 Struktúra

├── install_irssi.sh  
├── uninstall_irssi.sh  
└── README.md

## ✨ Megjegyzések
- A telepítő script több csatornát is kezel, szóközzel elválasztva kell megadni őket.
- Az uninstall script teljesen eltávolítja az irssi környezetet, így tiszta állapotból újra telepíthető.
- A logolás opcionálisan hozzáadható a telepítőhöz, ha minden csatorna beszélgetését külön fájlba szeretnéd menteni.

## 📜 Licenc
Ez a projekt szabadon használható és módosítható.
