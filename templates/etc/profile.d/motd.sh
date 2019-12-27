#!/bin/bash

# Technical contact
CONTACT="{{ MOTD_CONTACT }}"

# Disk percentage warning threshold
DISK_WARN_THRESHOLD=90

# Text color settings
COLOR_WARNING="\e[91m"
COLOR_ACCENT="{{ MOTD_COLOR_ACCENT }}"
COLOR_RESET="\e[0m"

# System date
DATE=`date`

# System uptime
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
upSecs=$((uptime%60))
UPTIME="${upDays}d ${upHours}h ${upMins}m ${upSecs}s"

# Basic info
HOSTNAME_UC=`echo $HOSTNAME | awk '{print toupper($0)}'`
RELEASE=`cat /etc/issue`
KERNEL=`uname -r`

# System info
MEMORY_USED=`free -t -m | grep Total | awk '{print $3" MB";}'`
MEMORY_TOTAL=`free -t -m | grep "Mem" | awk '{print $2" MB";}'`
LOAD_1=`cat /proc/loadavg | awk '{print $1}'`
LOAD_5=`cat /proc/loadavg | awk '{print $2}'`
LOAD_15=`cat /proc/loadavg | awk '{print $3}'`
SWAP_USED=`free -m | tail -n 1 | awk '{print $3" MB"}'`

# Interfaces info

PUBLIC_INTERFACE=x
{% if MOTD_PUBLIC_INTERFACE is defined %}
  PUBLIC_INTERFACE="{{ MOTD_PUBLIC_INTERFACE }}"
{% endif %}

PRIVATE_INTERFACE=x
{% if MOTD_PRIVATE_INTERFACE is defined %}
  PRIVATE_INTERFACE="{{ MOTD_PRIVATE_INTERFACE }}"
{% endif %}

if [ ! "$PUBLIC_INTERFACE" == "x" ]; then
  PUBLIC_IP=`ip addr show dev $PUBLIC_INTERFACE | grep "inet " | awk '{print $2" / "$4}'`
fi

if [ ! "$PRIVATE_INTERFACE" == "x" ]; then
  PRIVATE_IP=`ip addr show dev $PRIVATE_INTERFACE | grep "inet " | awk '{print $2" / "$4}'`
fi

# Internet Infos
INTERNET_IP=$(curl -s https://iplist.cc/api | jq -r '.ip')


# Disk over threshold
DISK_OT=`df -P | awk '0+$5 >= '$DISK_WARN_THRESHOLD' {print}'`

echo
echo -e "Welcome to ${COLOR_ACCENT}${HOSTNAME_UC}${COLOR_RESET} managed by $CONTACT"
echo
echo -e "Running on ${RELEASE} with kernel ${KERNEL}"
echo

echo -e ${COLOR_ACCENT}
figlet -f /opt/"{{ MOTD_WELCOME_FONT }}".flf "{{ MOTD_WELCOME }}"
echo -e ${COLOR_RESET}

echo -e " ${COLOR_ACCENT}█${COLOR_RESET} System date.........: $DATE"
echo -e " ${COLOR_ACCENT}█${COLOR_RESET} Uptime..............: $UPTIME"
echo -e " ${COLOR_ACCENT}█${COLOR_RESET} CPU usage...........: $LOAD_1, $LOAD_5, $LOAD_15"
echo -e " ${COLOR_ACCENT}█${COLOR_RESET} Memory used.........: $MEMORY_USED / $MEMORY_TOTAL"
echo -e " ${COLOR_ACCENT}█${COLOR_RESET} Swap in use.........: $SWAP_USED"

if [ ! "$INTERNET_IP" == "" ]; then
  echo -e " ${COLOR_ACCENT}█${COLOR_RESET} IP on Internet......: $INTERNET_IP"
fi

if [ ! "$PUBLIC_IP" == "" ]; then
  echo -e " ${COLOR_ACCENT}█${COLOR_RESET} Public IP...........: $PUBLIC_IP"
fi

if [ ! "$PRIVATE_IP" == "" ]; then
  echo -e " ${COLOR_ACCENT}█${COLOR_RESET} Private IP..........: $PRIVATE_IP"
fi

echo

if [ ! "x$DISK_OT" == "x" ]; then
    echo
    echo -e "${COLOR_WARNING}* WARNING * One or more disks are over ${DISK_WARN_THRESHOLD}% capacity:${COLOR_RESET}"
    df -Ph
fi

# Fortune word
if [ -f "/usr/games/fortune" ]; then
    /usr/games/fortune -as | cowsay
fi

echo
