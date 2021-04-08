#!/bin/bash
cd $(dirname $0)/..
set -e

# Date: 08/04/2021
# Author: Òscar Pérez
# install airpods utility:
# - $HOME/bin/main.py: print airpods battery level
# - $HOME/bin/polybar.sh: print last battery level reported
# - airpods.service: daemon service
# the polybar configuration should be updated manually


echo "[*] Installing scripts"
cp polybar/polybar.sh ~/bin/
cp systemd/main.py ~/bin/
echo "[*] Installing scripts: ok!"

echo "[*] Installing python requirements"
pip install -r requirements.txt
echo "[*] Installing python requirements: ok!"

echo "[*] Setting up systemd service"
cp systemd/airpods.service /etc/systemd/system/
systemctl daemon-reload
sytemctl start airpods.service
sytemctl status airpods.service
echo "[*] Setting up systemd service: ok!"

echo "[*] Success!!"
