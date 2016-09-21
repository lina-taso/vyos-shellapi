#!/bin/sh

WD="/home/vyos/"
VYOS_SETCMD="set-firewall-IPaddrlist.sh"
APNICURL="http://ftp.apnic.net/stats/apnic/delegated-apnic-latest"
APNICFILE="delegated-apnic-latest"

cd $WD

# download APNIC addr assignments
wget $APNICURL

# create ip addr list
if [ -f $APNICFILE ]; then
    awk 'BEGIN {FS="|"; OFS="/"} $2=="JP" && $3=="ipv4" {print $4, 32-log($5)/log(2)}' "$APNICFILE" > JP-IPaddrlist.txt
else
    exit 1
fi

# set to firewall
sh $VYOS_SETCMD < JP-IPaddrlist.txt

# clean garbage
rm $APNICFILE JP-IPaddrlist.txt
