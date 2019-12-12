#!/bin/sh

# this script publish the hash of /.brings to the peerid
# $Date: 12/12/19$
# $tic: 1576165431$
# $qm: z2kauxcKpPgNG2Y6Pit8kxGh2BjjQeSo1JQnxQWFniAw133$

export BRNG_HOME=${BRNG_HOME:-$HOME/.brings}
export PATH=$BRNG_HOME/bin:$PATH

set -e
yellow="[33m"
red="[31m"
nc="[0m"
tic=$(date +%s)
# set up local IPFS environment ...
export IPFS_PATH=${IPFS_PATH:-$HOME/.brings/ipms}

main(){

debug=0
verbose=0
trace=0
for i in "$@"; do
case $i in
    -o|--offline) offline='--offline' ;;
    -d|--debug) debug=1 ;;
    -v|--verbose) verbose=1 ;;
    -t|--trace) trace=1 ;;
    *) # unknown option ;;
esac
done

check_perl_local_lib;
check_ipms_running;

# get ipms config parameters ...
gwhost=$(ipms config Addresses.Gateway | cut -d'/' -f 3)
gwport=$(ipms config Addresses.Gateway | cut -d'/' -f 5)
peerid=$(ipms config Identity.PeerID)
# get fullname and emails associated with peerid
eval "$(fullname -a $peerid | eyml)"


# key is harcoded in function...
update_bootstrap_path /.brings/bootstrap 

post_identity_to_root;

check_exist_of_directory "/.brings/logs"
writelog_of_mutable_of_logfile /my/identity/public.yml /.brings/logs/identity.log
writelog_of_mutable_of_logfile /public /.brings/logs/public.log

writelog_of_mutable_of_logfile /root /.brings/logs/root.log
writelog_of_mutable_of_logfile /my /.brings/logs/my.log

post_brings;

#ipms files read "/.brings/logs/brings.log"
ipms files stat /.brings/logs/brings.log
echo .
brkey=$(ipms files stat --hash /.brings)
ipms --offline name publish --allow-offline $brkey 1>/dev/null 2>&1
echo "url: https://gateway.ipfs.io/ipfs/$brkey"
echo "url: http://$gwhost:$gwport/ipns/$peerid"

# -----------------------------------------------------------------------
# PUBLISH /.brings to self (peerid)
ipms $offline name publish --allow-offline $brkey | sed -e 's/^/info: /';
# -----------------------------------------------------------------------

}

check_exist_of_directory()
{
    if ! ipms files stat --hash "$1" 1>/dev/null 2>&1; then
	    ipms files mkdir -p "$1"
    fi
}

check_ipms_running()
{
   #if ! ipms cat mAVUACHJ1bm5pbmcK 1>/dev/null 2>&1; then false; fi
   if ! ipms swarm addrs local | sed -e 's/^/info: /'; then
      echo " ${yellow}WARNING no ipms daemon running${nc}"
      echo " ${yellow}INFO running start.sh${nc}"
      ipfsd.sh
      sleep 2
   fi
}

check_perl_local_lib()
{
    if ! perl -Mlocal::lib=$BRNG_HOME/perl5 -e 1 2>/dev/null; then
	if [ $debug -eq 1 ]; then
  	echo " WARNING perl: local::lib not found"
	echo " running $BRNG_HOME/envrc.sh"
        fi
	. $BRNG_HOME/envrc.sh
    fi
    echo DICT: $DICT
}

create_identity()
{
  peerid=$1;
  eval $(hip6 -a 2>/dev/null | eyml)
  eval "$(fullname -a $peerid 2>/dev/null | eyml)"
  date=$(date +"%D")
  check_exist_of_directory /my/identity/attr
  type= $(echo "is an early adopter" | ipms add -Q -n --hash sha1 --cid-base base58btc)
  status= $(echo "is alive" | ipms add -Q -n --hash sha1 --cid-base base58btc)
  human= $(echo "is a robot" | ipms add -Q -n --hash sha1 --cid-base base58btc)
  ipms files cp /ipfs/$type /my/identity/attr/type
  ipms files cp /ipfs/$status /my/identity/attr/status
  ipms files cp /ipfs/$human /my/identity/attr/botonot
  attr=$(ipms files stat --hash /my/identity/attr)
  ipms files write --create --truncate /my/identity/public.yml <<EOF
--- # This is my blockRing™ Sovereign identity
name: "$fullname"
uniq: "$uniq"
date: $date
exp: never
hip6: $hip6
attr: $attr
EOF

}

ipms_append_of_text_of_file()
{
    text=$1;
    file=$2;
    fname=$(basename $2)

    echo "ipms_append_of_file : $file"
    
    ipms files read "${file}" > /tmp/${fname}
    echo "$text" >> /tmp/${fname}
    ipms files write --create  --truncate "${file}" < /tmp/${fname}
    rm -f /tmp/${fname}
}

writelog_of_mutable_of_logfile()
{
   mutable=$1
   logfile=$2
   here=writelog_of_mutable_of_logfile

   tic=$(date +%s)

   if [ $debug -eq 1 ]; then
      echo "Entering in $here $*"
   fi

   if [ $# -ne 2 ]
   then
      echo "Input parameters : $*"
      echo "ERROR"
      echo "Usage: $here <mutable> <logfile>"
      exit $$
   else 
     echo logfile: $logfile
   fi
   qm=$(ipms files stat --hash ${mutable})

   if sz=$(ipms files stat --format="<size>" ${logfile} 2>/dev/null)
   then
      ipms_append_of_text_of_file "$tic: ${qm}" ${logfile}
   else
      ipms files write --create --raw-leaves "${logfile}" <<EOF
# log-file for ${mutable}
# \$Source: ${logfile} \$
$tic: ${qm}
EOF
   fi
}

post_brings()
{
    if [ $debug -eq 1 ]; then
	echo "Entering in post_brings $*"
    fi
    
    bot=$(ipms add -Q $0) # adding self 
    if ipms files rm /.brings/${0##*/} 2>/dev/null; then true; fi
    ipms files cp /ipfs/$bot "/.brings/${0##*/}"

    brkey=$(ipms files stat --hash /.brings)
    echo "brkey: $brkey"

    writelog_of_mutable_of_logfile /.brings /.brings/logs/brings.log
}

post_identity_to_root()
{
   if [ $debug -eq 1 ]; then
      echo "Entering in post_identity_to_root $*"
   fi

   if [ "x$peerid" = 'x' ]; then
     peerid=$(ipms --offline config Identity.PeerID)
   fi
   if [ "x$email" = 'x' ]; then
      eval "$(fullname -a $peerid | eyml)"
   fi

   if ! ipms files stat --hash /root/directory 1>/dev/null 2>&1; then
      ipms files mkdir -p /root/directory
   else
      if ipms files rm -r "/root/directory/$email" 2>/dev/null; then true; fi
   fi

   if qm=$(ipms files stat --hash /my/identity); then
     ipms files cp /ipfs/$qm "/root/directory/$email"
   else
     create_identity $peerid
   fi
}

update_bootstrap_path() {
  # usage: update_bootstrap_path /.brings/bootstrap
  echo update: bootstrap

   key="QmVdu2zd1B8VLn3R8xTMoD2yBVScQ1w9UMbW7CR1EJTVYw"
   mfspath="$1"

   if [ $debug -eq 1 ]; then
      echo "Entering in update_bootstrap_path $*"
   fi

   if ! ipms files stat --hash ${mfspath%/*} 1>/dev/null 2>&1; then
      ipms files mkdir -p ${mfspath%/*}
   fi
   if ipath=$(ipms --timeout 10s name resolve ${key} 2>/dev/null); then
      if ipms files rm -r ${mfspath} 2>/dev/null; then true; fi
      if ipms files cp ${ipath} ${mfspath}; then true; fi
   else
      echo "${yellow}warning: ${key} not resolved${nc}"
   fi

   # republish bootstrap if key present ...
   if ipms key list | grep -q -w bootstrap; then
     qm=$(ipms files stat --hash ${mfspath}) 
     ipms $offline name publish --allow-offline --key=bootstrap /ipfs/$qm | sed -e 's/^/info: /'
   fi
  
}

main $@ ;

exit 0
