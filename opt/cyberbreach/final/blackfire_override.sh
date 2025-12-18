#!/bin/bash
SECRET="OVERRIDE-NEON-47"
KEYFILE="/home/analyst/override_key.txt"

echo "[BLACKFIRE] Verifying override key..."
sleep 1

if [ "$1" = "$SECRET" ]; then
    echo "[ACCESS] Override key accepted."
    sleep 1
    echo ">> ARASAKA BLACKFIRE FIREWALL: OFFLINE"
    echo ">> NEONROOT CORE BREACHED"
    echo ""

    cat << "ART"
  ██████╗ ███████╗ █████╗  ██████╗██╗  ██╗
  ██╔══██╗██╔════╝██╔══██╗██╔════╝██║ ██╔╝
  ██████╔╝█████╗  ███████║██║     █████╔╝
  ██╔══██╗██╔══╝  ██╔══██║██║     ██╔═██╗
  ██║  ██║███████╗██║  ██║╚██████╗██║  ██╗
  ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
ART

    echo ""
    echo "[SYSTEM] Cleaning sensitive traces..."
    sleep 1

    if [ -f "$KEYFILE" ]; then
        rm -f "$KEYFILE"
        echo "[OK] override_key.txt removed."
    else
        echo "[INFO] override_key.txt not found."
    fi

    echo ""
    echo "[MISSION COMPLETE] You escaped the sandbox."
# ---- wipe history files for BOTH users (V + analyst) ----
wipe_user_history() {
  local U="$1"
  local H
  H="$(getent passwd "$U" | cut -d: -f6)"
  [ -n "$H" ] || return 0

  # zsh history + lock/old
  rm -f "$H/.zsh_history" "$H/.zsh_history.lock" "$H/.zsh_history.old" 2>/dev/null
  : > "$H/.zsh_history" 2>/dev/null
  chown "$U:$U" "$H/.zsh_history" 2>/dev/null
  chmod 600 "$H/.zsh_history" 2>/dev/null

  # bash history
  rm -f "$H/.bash_history" 2>/dev/null
  : > "$H/.bash_history" 2>/dev/null
  chown "$U:$U" "$H/.bash_history" 2>/dev/null
  chmod 600 "$H/.bash_history" 2>/dev/null
}

wipe_user_history "V"
wipe_user_history "analyst"

    exit 0
else
    echo "[DENIED] Invalid key. BLACKFIRE remains online."
    exit 1
fi
