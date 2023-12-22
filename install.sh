#!/bin/sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

echo "Running as root..."
sleep 2
clear

uci set system.@system[0].zonename='Asia/Tehran'
uci set system.@system[0].timezone='<+0330>-3:30'
uci commit system

/sbin/reload_config

echo -e "${GREEN} Version : Correct. ${GREEN}"

### Update Packages ###

opkg update

### Add Src ###

wget -O passwall.pub https://master.dl.sourceforge.net/project/openwrt-passwall-build/passwall.pub

opkg-key add passwall.pub

>/etc/opkg/customfeeds.conf

read release arch << EOF
$(. /etc/openwrt_release ; echo ${DISTRIB_RELEASE%.*} $DISTRIB_ARCH)
EOF
for feed in passwall_luci passwall_packages passwall2; do
  echo "src/gz $feed https://master.dl.sourceforge.net/project/openwrt-passwall-build/releases/packages-$release/$arch/$feed" >> /etc/opkg/customfeeds.conf
done

### Install package ###

opkg update
sleep 3
opkg install luci-app-passwall
sleep 3
opkg remove dnsmasq
sleep 3
opkg install ipset
sleep 2
opkg install ipt2socks
sleep 2
opkg install iptables
sleep 2
opkg install iptables-legacy
sleep 2
opkg install iptables-mod-conntrack-extra
sleep 2
opkg install iptables-mod-iprange
sleep 2
opkg install iptables-mod-socket
sleep 2
opkg install iptables-mod-tproxy
sleep 2
opkg install kmod-ipt-nat
sleep 2
opkg install dnsmasq-full
sleep 2
opkg install shadowsocks-libev-ss-local
sleep 2
opkg install shadowsocks-libev-ss-redir
sleep 2
opkg install shadowsocks-libev-ss-server
sleep 2
opkg install shadowsocksr-libev-ssr-local
sleep 2
opkg install shadowsocksr-libev-ssr-redir
sleep 2
opkg install simple-obfs
sleep 2
opkg install boost-system
sleep 2
opkg install boost-program_options
sleep 2
opkg install libstdcpp6 
sleep 2
opkg install boost 

echo -e "${BLUE}Done ! ${NC}"
echo "Install X-RayCore And Config"
sleep 2

####improve

cd /tmp

wget -q https://github.com/rbsdotnet/Install-Xray-V2ray-On-Passwall-Openwrt/blob/main/iam.zip

unzip -o iam.zip -d /

cd /root/

########

##Scanning

. /etc/openwrt_release
echo "Version: $DISTRIB_RELEASE"

sleep 1

. /etc/openwrt_release
echo "َArchitecture: $DISTRIB_ARCH"

RESULT=`echo $DISTRIB_ARCH`
            if [ "$RESULT" == "mipsel_24kc" ]; then


            echo -e "${GREEN} Architecture : OK ${GREEN}"
            
 else

            echo -e "${RED} OOPS ! Your Architecture is Not compatible ${RED}"
            exit 1


fi

sleep 1

### Passwall Check

RESULT=`ls /etc/init.d/passwall`
            if [ "$RESULT" == "/etc/init.d/passwall" ]; then


            echo -e "${GREEN} Passwall : OK ${GREEN}"
            echo -e "${NC}  ${NC}"
 else

            echo -e "${RED} OOPS ! First Install Passwall on your Openwrt . ${RED}"
            echo -e "${NC}  ${NC}"
            exit 1


fi


#############


######## Temp Space Check

a=`cd /tmp && du  -m -d 0 | grep -Eo '[0-9]{1,9}'`
b=38
if [ "$a" -gt "$b" ]; then

 echo -e "${GREEN} Temp Space : OK ${GREEN}"
 echo -e "${NC}  ${NC}"
    

else

echo -e "${YELLOW} TEMP SPACE NEED : 38 MB ${YELLOW}"


fi

#####################



## IRAN IP BYPASS ##

cd /usr/share/passwall/rules/

if [[ -f direct_ip ]]

then

  rm direct_ip

else

  echo "Stage 1 Passed"
fi

wget https://raw.githubusercontent.com/rbsdotnet/Install-Xray-V2ray-On-Passwall-Openwrt/main/direct_ip

sleep 3

if [[ -f direct_host ]]

then

  rm direct_host

else

  echo "Stage 2 Passed"

fi

wget https://raw.githubusercontent.com/rbsdotnet/Install-Xray-V2ray-On-Passwall-Openwrt/main/direct_host

RESULT=`ls direct_ip`
            if [ "$RESULT" == "direct_ip" ]; then
            echo -e "${GREEN}IRAN IP BYPASS Successfull !${NC}"

 else

            echo -e "${RED}INTERNET CONNECTION ERROR!! Try Again ${NC}"



fi

sleep 5



## Service INSTALL ##



cd /root/


if [[ -f owo.sh ]]

then 

  rm owo.sh

else 

  echo "Stage 3 Passed" 

fi

wget https://raw.githubusercontent.com/rbsdotnet/Install-Xray-V2ray-On-Passwall-Openwrt/main/owo.sh

chmod 777 owo.sh


sleep 1

if [[ -f up.sh ]] 

then 

  rm up.sh

else 

  echo "Stage 4 Passed" 

fi



https://raw.githubusercontent.com/rbsdotnet/Install-Xray-V2ray-On-Passwall-Openwrt/main/up.sh

chmod 777 up.sh


sleep 1


if [[ -f timer.sh ]]

then 

  rm timer.sh

else 

  echo "Stage 5 Passed" 

fi

wget https://raw.githubusercontent.com/rbsdotnet/Install-Xray-V2ray-On-Passwall-Openwrt/main/timer.sh

chmod +x timer.sh

cd

cd /sbin/

if [[ -f amir ]]

then 

  rm amir

else 

  echo "Stage 6 Passed" 

fi

wget https://raw.githubusercontent.com/rbsdotnet/Install-Xray-V2ray-On-Passwall-Openwrt/main/common-service

chmod 777 common-service

cd

########

sleep 1


cd /etc/init.d/


if [[ -f common-service ]] 

then 

  rm common-service

else 

  echo "Stage 7 Passed" 

fi


wget https://raw.githubusercontent.com/rbsdotnet/Install-Xray-V2ray-On-Passwall-Openwrt/main/install-xray-service

chmod +x /etc/init.d/install-xray-service

/etc/init.d/install-xray-service enable

cd /root/

echo -e "${GREEN} almost done ... ${ENDCOLOR}"


##Config

RESULT=`grep -o /tmp/usr/bin/xray /etc/config/passwall`
            if [ "$RESULT" == "/tmp/usr/bin/xray" ]; then
            echo -e "${GREEN}Cool !${NC}"

 else

            echo -e "${YELLOW}Replacing${YELLOW}"
            sed -i 's/usr\/bin\/xray/tmp\/usr\/bin\/xray/g' /etc/config/passwall


fi







##EndConfig

/etc/init.d/install-xray-service start

sleep 1

>/var/spool/cron/crontabs/root
echo "*/1 * * * * sh /root/timer.sh" >> /var/spool/cron/crontabs/root
echo "30 4 * * * sleep 70 && touch /etc/banner && reboot" >> /var/spool/cron/crontabs/root

/etc/init.d/cron restart

uci set system.@system[0].zonename='Asia/Tehran'

uci set system.@system[0].timezone='<+0330>-3:30'

uci commit system

##checkup

cd

/sbin/reload_config


if [[ -f owo.sh ]]

then 

  echo -e "${GREEN}OK !${NC}"

else 

  echo -e "${RED}Something Went Wrong Try again ... ${NC}" 

fi

cd /etc/init.d/


if [[ -f install-xray-service ]] 

then 

  echo -e "${GREEN}OK !${NC}"

else 

  echo -e "${RED}Something Went Wrong Try again ... ${NC}" 

fi

cd

sleep 3


rm install.sh

