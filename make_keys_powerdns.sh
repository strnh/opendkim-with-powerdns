#!/bin/sh
# 
# opendkim-gen wapper multi/subdomains
#    for powerdns TXT  with  opendkim-genkey 
#
# 
#  2024/08/24 by @strnh 
#  
#  Tested : FreeBSD/14.1

KEYDIR=/usr/local/etc/mail/keys
KEYLEN=2048
BASEDOM=example.com

/usr/local/sbin/opendkim-genkey --note=$BASEDOM --domain=$BASEDOM --bits=$KEYLEN --restrict --directory=$KEYDIR


SUBDOM=$(cat <<EOS
foo
bar
baz
hoge
fuga
piyo
EOS
)
set $SUBDOM ;

while [ $# -gt 0 ]
do
 opendkim-genkey --note=$1 --selector=$1 --domain=$1.$BASEDOM --bits=$KEYLEN --restrict --directory=$KEYDIR
  (cd $KEYDIR; cat $1.txt | sed "s/[()]//g" | awk 'BEGIN { getline ; sl0=length($0); s0=substr($0,0,(sl0-1)); getline; sl1=length($0) ; s1=substr($0,1,(sl1-1)); getline; sl2=length($0); s2=substr($1,5,(sl2)); printf("%s%s%s\n", s0,s1,s2) }' > $1.txt.pdns
 )
  shift
done


cd $KEYDIR

#  sed "s/[()]//g" | awk 'BEGIN { getline ; sl0=length($0); s0=substr($0,0,(sl0-1)); getline; sl1=length($0) ; s1=substr($0,5,(sl1-1)); getline; sl2=length($0); s2=substr($1,5,(sl2)); printf("%s%s%s\n", s0,s1,s2)  }'
