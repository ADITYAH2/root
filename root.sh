#!/bin/bash
# Simpel Change Root For Linux ( ALL LINUX OS )
# ================================================

# Clear
clear
rm -f root.sh

# Get Passwd
read -p "Please Input an New Password For Root : " Pass

# Starting Changes To Root
rm -f /etc/ssh/sshd_config
wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/ADITYAH2/tes1/main/sshd
echo -e "$Pass\n$Pass\n"|passwd root &> /dev/null
geo=$(wget -qO- ifconfig.co);

# Successful
clear
echo "Please Save This VPS Account Information" | lolcat
echo "============================================" | lolcat
echo "  IP ADDRESS = $geo" | lolcat
echo "  Username   = root" | lolcat
echo "  Password   = $Pass" | lolcat
echo "============================================" | lolcat
echo ""
echo "VPS Will Rebooting On 5 Second !!!!!"

rm -f root.sh
sleep 5
reboot
 
