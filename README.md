# 🧠 NEON ROOT – Cyberpunk Linux Escape Room

**NEON ROOT** ist ein cyberpunk-thematischer Linux Escape Room auf Basis von Debian.
Spieler lernen Linux-Grundlagen nicht über Theorie, sondern durch **aktives Problemlösen im Terminal**.

Der Escape Room ist **linear**, story-getrieben und für **Linux-Einsteiger & Azubis** konzipiert.

---

## 🎮 Spielidee

Du übernimmst die Rolle von **V**, einem Runner in einer kompromittierten Konzern-VM.
Dein Ziel:

1. Versteckte Daten finden
2. Einen neuen Benutzer übernehmen
3. Eine verschlüsselte Transmission entschlüsseln
4. Eine Firewall deaktivieren und entkommen

Alles passiert **ausschließlich im Terminal**.

---

## 🧩 Level-Übersicht

| Level   | Beschreibung                                         |
| ------- | ---------------------------------------------------- |
| Level 1 | Versteckte Datei finden → Zugangsdaten für `analyst` |
| Level 2 | AES-256-CBC verschlüsselte Datei entschlüsseln       |
| Level 3 | BLACKFIRE Firewall Override (Finale)                 |

---

## 🖥️ Voraussetzungen

* **Debian 13 (amd64)** – empfohlen: netinst / minimal
* Kein Desktop erforderlich
* Root-Zugriff während der Einrichtung
* Internetzugang (nur für Setup)

---

## ⚙️ Installation & Setup

### 1️⃣ System vorbereiten

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y sudo zsh openssl tree git
```

---

### 2️⃣ Benutzer anlegen

#### Spieler (V)

```bash
sudo adduser V
```

#### Analyst (Level 2)

```bash
sudo adduser analyst
echo "analyst:S3cr3t_Sh4dow!" | sudo chpasswd
```

---

### 3️⃣ Shell vereinheitlichen (wichtig!)

Das Projekt nutzt **zsh** für Login-Hooks und Story-Trigger.

```bash
sudo chsh -s /bin/zsh V
sudo chsh -s /bin/zsh analyst
```

---

### 4️⃣ Projektdateien platzieren

```bash
sudo mkdir -p /opt/cyberbreach/{level1,level2,final}
sudo chown -R V:V /opt/cyberbreach
```

Kopiere anschließend die Dateien aus diesem Repository an die vorgesehenen Orte:

| Repo-Pfad                       | Zielpfad                                       |
| ------------------------------- | ---------------------------------------------- |
| `scripts/arasaka_intro.sh`      | `/usr/local/bin/arasaka_intro.sh`              |
| `scripts/blackfire_override.sh` | `/opt/cyberbreach/final/blackfire_override.sh` |

```bash
sudo chmod +x /usr/local/bin/arasaka_intro.sh
sudo chmod +x /opt/cyberbreach/final/blackfire_override.sh
```

---

### 5️⃣ Intro beim Login aktivieren

```bash
sudo tee /etc/profile.d/arasaka_intro.sh > /dev/null << 'EOF'
[ "$USER" = "V" ] || return
[ -x /usr/local/bin/arasaka_intro.sh ] || return
case "$-" in *i*) ;; *) return ;; esac
/usr/local/bin/arasaka_intro.sh
EOF
```

---

## 🧪 Level-Setup

### Level 1 – Ghost Data

```bash
sudo tee /opt/cyberbreach/level1/.ghost_data > /dev/null << 'EOF'
Credentials:
user: analyst
pass: S3cr3t_Sh4dow!
EOF

sudo chown -R V:V /opt/cyberbreach
```

---

### Level 2 – Encrypted Transmission

```bash
echo "OVERRIDE-NEON-47" | sudo tee /tmp/key.txt
sudo openssl aes-256-cbc -salt \
  -in /tmp/key.txt \
  -out /home/analyst/transmission.enc \
  -k "$(hostname)"
sudo rm /tmp/key.txt
sudo chown analyst:analyst /home/analyst/transmission.enc
```

Hints liegen in:

* `~/hint.txt`
* `~/.cache/.emergency_hint`

---

### Level 3 – BLACKFIRE Firewall

```bash
echo "analyst ALL=(ALL) NOPASSWD: /opt/cyberbreach/final/blackfire_override.sh" \
 | sudo tee /etc/sudoers.d/cyberbreach
```

---

## ▶️ Spiel starten

```bash
su - V
```

Folge den Hinweisen im Terminal.

---

## 🧹 Finale & Cleanup

Nach erfolgreichem Escape:

* Override-Key wird gelöscht
* Command-History von `V` & `analyst` wird entfernt
* Spuren gelten als bereinigt

---

## 📚 Lernziele

* Navigation im Dateisystem
* Benutzerwechsel (`su`)
* Versteckte Dateien & Berechtigungen
* Grundlagen von Verschlüsselung (OpenSSL)
* Systeminformationen nutzen (`hostname`)
* gezielter Einsatz von `sudo`

---

## 🛠️ Erweiterungen (Ideen)

* Netzwerk-Rätsel
* Fake-Logfiles
* Zeitbasierte Challenges
* Punkte / Score-System
* Reset-Skript für Lehrkräfte

---

## ⚠️ Hinweis

Dieses Projekt ist **kein echtes Hacking**.
Alle Aktionen finden in einer **kontrollierten Lernumgebung** statt.

---

## 👾 Autor

Linux Escape Room – *NEON ROOT*
by **Lowtrixx**
