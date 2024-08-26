#!/bin/sh
# 
# pdns.sh
# opendkim-gen wapper 
# for powerdns TXT  with  opendkim-genkey 
#
# 
#  2024/08/26 13:32 JST by @strnh 
#  
#  Tested : FreeBSD/14.1
#  

KEYDIR=/usr/local/etc/mail/keys
KEYLEN=2048
BASEDOM=example.dom
TTL=86400

/usr/local/sbin/opendkim-genkey --selector=default --note=$BASEDOM --domain=$BASEDOM --bits=$KEYLEN --restrict --directory=$KEYDIR

(cd $KEYDIR; cat default.txt | sed "s/\"//g"  | sed "s/\\\//g" |  sed "s/^[ \t]+//g" | sed "s/[()]//g" | awk 'BEGIN { getline ; sl0=length($0); s0=substr($0,0,sl0); getline; sl1=length($0) ;s1=substr($1,0,sl1); getline; sl2=length($0); s2=substr($1,5,(sl2)); printf("%s%s%s\n", s0,s1,s2) }'| awk -v domttl="$BASEDOM $TTL" '{ printf("%s.%s %s %s \"%s %s %s %s %s\" \n",$1,domttl,$2,$3,$4,$5,$6,$7,$8); }' > default.txt.pdns
 )
