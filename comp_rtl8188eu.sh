git clone https://github.com/liwei/rpi-rtl8188eu.git
read -p "press any key"
git clone --depth 1 git://github.com/raspberrypi/linux.git rpi-linux
read -p "press any key"
git clone --depth 1 git://github.com/raspberrypi/firmware.git rpi-firmware
read -p "press any key"
cd rpi-linux
read -p "press any key"
make mrproper
read -p "press any key"
zcat /proc/config.gz > .config
read -p "press any key"
make modules_prepare
read -p "press any key"
cp ../rpi-firmware/extra/Module.symvers .
read -p "press any key"
cd ../rpi-rtl8188eu
read -p "press any key"
CONFIG_RTL8188EU=m make -C ../rpi-linux M=`pwd`
read -p "press any key"
sudo rmmod 8188eu
read -p "press any key"
sudo install -p -m 644 8188eu.ko /lib/modules/`uname -r`/kernel/drivers/net/wireless
read -p "press any key"
sudo depmod -a
read -p "press any key"
sudo modprobe 8188eu
read -p "press any key"

