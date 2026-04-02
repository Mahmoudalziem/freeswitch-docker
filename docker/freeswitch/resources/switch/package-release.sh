#!/bin/sh

#move to script directory so all relative paths work
cd "$(dirname "$0")"

#includes
. ../config.sh
. ../colors.sh
. ../environment.sh

apt-get update && apt-get install -y curl memcached haveged apt-transport-https sox libsox-fmt-all

if [ ."$os_codename" = ."xenial" ]; then
	wget -O - https://files.freeswitch.org/repo/ubuntu-1604/freeswitch-1.6/freeswitch_archive_g0.pub | apt-key add -
	echo "deb http://files.freeswitch.org/repo/ubuntu-1604/freeswitch-1.6/ xenial main" > /etc/apt/sources.list.d/freeswitch.list
else
	wget -O - https://files.freeswitch.org/repo/ubuntu-1604/freeswitch-1.6/freeswitch_archive_g0.pub | apt-key add -
	echo "deb http://files.freeswitch.org/repo/ubuntu-1604/freeswitch-1.6/ xenial main" > /etc/apt/sources.list.d/freeswitch.list
fi

apt-get update
apt-get install -y libyuv-dev

#remove the music package to protect music on hold from package updates
mkdir -p /usr/share/freeswitch/sounds/temp
mv /usr/share/freeswitch/sounds/music/*000 /usr/share/freeswitch/sounds/temp
mv /usr/share/freeswitch/sounds/music/default/*000 /usr/share/freeswitch/sounds/temp
apt-get remove -y freeswitch-music-default
mkdir -p /usr/share/freeswitch/sounds/music/default
mv /usr/share/freeswitch/sounds/temp/* /usr/share/freeswitch/sounds/music/default
rm -R /usr/share/freeswitch/sounds/temp
