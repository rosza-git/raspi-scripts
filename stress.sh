#!/bin/bash
#Simple stress stest for system. If it survives this, it's probably stable.
#Free software, GPL2+

rm -f stress.log
touch stress.log

echo -e "Testing overlock stability...\n" | tee -a stress.log

echo -n "CPU freq: " | tee -a stress.log ; cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq | tee -a stress.log
echo -n "CPU temp: " | tee -a stress.log ; cat /sys/class/thermal/thermal_zone0/temp | tee -a stress.log

#Max out the CPU in the background (one core). Heats it up, loads th power-suply.
nice yes >/dev/null &

#Read the entire SD card 10x. Tests RAM and I/O
echo -e "\nReading SD card 10x ..." | tee -a stress.log
for i in `seq 1 10`
  do
    echo reading $i | tee -a stress.log
    T="$(date +%s)"
    sudo dd if=/dev/mmcblk0 of=/dev/null bs=4M | tee -a stress.log
    T="$(($(date +%s)-T))"
    echo "$i. elapsed time: ${T}" | tee -a stress.log
    echo -n "CPU temp: " | tee -a stress.log ; cat /sys/class/thermal/thermal_zone0/temp | tee -a stress.log
  done

#Wirtes 512MB test file, 10x.
echo -e "\nWriting 512MB test file, 10x ..." | tee -a stress.log
for i in `seq 1 10`
  do
    echo writing: $i
    T="$(date +%s)"
    sudo dd if=/dev/zero of=deleteme.dat bs=1M count=512
    sudo sync
    T="$(($(date +%s)-T))"
    echo "$i. elapsed time: ${T}" | tee -a stress.log
    echo -n "CPU temp: " | tee -a stress.log ; cat /sys/class/thermal/thermal_zone0/temp | tee -a stress.log
   done

#Clean up
sudo killall yes
sudo rm deleteme.dat

#Print summary. Anything nasty will appear in dmesg.
dmesg | tail

echo -e "\nNot crashed yet, probably stable!" | tee -a stress.log
