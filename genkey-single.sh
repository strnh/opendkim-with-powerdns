
#!/bin/sh
#
# opendkim-gen wapper single-domain
#    for powerdns TXT  with  opendkim-genkey (FreeBSD)
#
#
#  2024/08/25  by @strnh
# 
#  Tested : FreeBSD/14.1

KEYDIR=/usr/local/etc/mail/keys
KEYLEN=2048
BASEDOM=example.dom

/usr/local/sbin/opendkim-genkey --note=$BASEDOM --domain=$BASEDOM --bits=$KEYLEN
 --restrict --directory=$KEYDIR

(cd $KEYDIR; cat default.txt | sed "s/[()]//g" | awk 'BEGIN { getline ; sl0=leng
th($0); s0=substr($0,0,(sl0-1)); getline; sl1=length($0) ; s1=substr($0,5,(sl1-1
)); getline; sl2=length($0); s2=substr($1,5,(sl2)); printf("%s%s%s\n", s0,s1,s2)
 }' > default.txt.pdns
 )

