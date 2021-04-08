#!/bin/bash
cd $(dirname $0)
set -e

# Date: 08/04/2021
# Author: Òscar Pérez
# install airpods utility:
# - $HOME/bin/main.py: print airpods battery level
# - $HOME/bin/polybar.sh: print last battery level reported
# - airpods.service: daemon service
# the polybar configuration should be updated manually


if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

echo "[*] Installing scripts"
mkdir ~/bin
cp ./polybar/polybar.sh ~/bin/
cp ./systemd/main.py ~/bin/
echo "[*] Installing scripts: ok!"

echo "[*] Installing python requirements"
pip install -r requirements.txt
echo "[*] Installing python requirements: ok!"

echo "[*] Setting up systemd service"
cat > /etc/systemd/system/airpods.service << EOF
[Unit]
Description=AirPods Battery Monitor

[Service]
ExecStart=/home/$(whoami)/bin/apodsmon /tmp/apodsmon.out

[Install]
WantedBy=default.target
EOF
systemctl start airpods.service
systemctl status airpods.service
echo "[*] Setting up systemd service: ok!"

echo "[*] Success!!"
