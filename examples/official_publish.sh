#!/bin/sh

# this script publish the hash of /.brings to the peerid

set -e
yellow="[33m"
red="[31m"
nc="[0m"
tic=$(date +%s)
# set up local IPFS environment ...
export BRNG_HOME=${BRNG_HOME:-$HOME/.brings}
export IPFS_PATH=${IPFS_PATH:-$BRNG_HOME/ipfs}

main(){

debug=0
verbose=0
trace=0
for i in "$@"; do
case $i in
    -o|--offline)
    offline='--offline'
    ;;
    -d|--debug)
    debug=1
    ;;
    -v|--verbose)
    verbose=1
    ;;
    -t|--trace)
    trace=1
    ;;
    *)
    # unknown option
    ;;
esac
done

echo "verbose: $verbose"

check_perl_local_lib;
check_ipfs_running;

# get ipms config parameters ...
gwhost=$(ipms config Addresses.Gateway | cut -d'/' -f 3)
gwport=$(ipms config Addresses.Gateway | cut -d'/' -f 5)
peerid=$(ipms config Identity.PeerID)
# get fullname and emails associated with peerid
eval "$(fullname -a $peerid | eyml)"

check_exist_of_directory "/.brings"

writelog_of_mutable_of_logname /my/identity/public.yml identity
writelog_of_mutable_of_logname /public public

post_identity_to_root;

writelog_of_mutable_of_logname /root root
writelog_of_mutable_of_logname /my my

post_brings;

#ipms files read "/.brings/brings.log"
ipms files stat /.brings/brings.log
echo .
brkey=$(ipms files stat --hash /.brings)
ipms --offline name publish --allow-offline $brkey 1>/dev/null 2>&1
echo "url: https://gateway.ipfs.io/ipfs/$brkey"
echo "url: http://$gwhost:$gwport/ipns/$peerid"

# -----------------------------------------------------------------------
# PUBLISH /.brings to self (peerid)
ipms $offline name publish --allow-offline $brkey | sed -e 's/^/info: /';
# -----------------------------------------------------------------------

# key is harcoded in function...
update_bootstrap_path /.brings/bootstrap 

}

add_dotbrings_directory_of_file()
{
    fullpath=$1
    dir=$(dirname $fullpath)
    if [ "$dir" = "." ]; then
	fullpath="/.brings/"${fullpath}
    fi
    echo $fullpath
}

check_exist_of_directory()
{
    if ! ipms files stat --hash "$1" 1>/dev/null 2>&1; then
	ipms files mkdir -p "$1"
    fi
}

check_ipfs_running()
{
   #if ! ipms cat mAVUACHJ1bm5pbmcK 1>/dev/null 2>&1; then false; fi
   if ! ipms swarm addrs local | sed -e 's/^/info: /'; then
      echo " ${yellow}WARNING no ipms daemon running${nc}"
      echo " ${yellow}INFO running start.sh${nc}"
      ./start.sh
      sleep 2
   fi
}

check_perl_local_lib()
{
    if ! perl -Mlocal::lib=$(pwd)/_perl5 -e 1 2>/dev/null; then
	if [ $debug -eq 1 ]; then
  	echo " WARNING perl: local::lib not found"
	echo " running . rc.sh"
        fi
	. ./rc.sh
    fi
    echo DICT: $DICT
}

ipfs_append_of_text_of_file()
{
    text=$1;
    fullpath=$(add_dotbrings_directory_of_file $2)
    file=$(basename $2)

    echo "ipfs_append_of_file : fullpath $fullpath"
    echo "ipfs_append_of_file : file $file append"
    
    ipms files read "${fullpath}" > /tmp/${file}
    echo "$text" >> /tmp/${file}
    ipms files write --create  --truncate "${fullpath}" < /tmp/${file}
    rm -f /tmp/${file}
}

writelog_of_mutable_of_logname()
{
   mutable=$1
   logname=$2
   here=writelog_of_mutable_of_logname

   tic=$(date +%s)

   if [ $debug -eq 1 ]; then
      echo "Entering in $here $*"
   fi

   if [ $# -ne 2 ]
   then
      echo "Input parameters : $*"
      echo "ERROR"
      echo "Usage: $here <mutable> <logname>"
      exit
   fi
   qm=$(ipms files stat --hash ${mutable})

   fullpath=`add_dotbrings_directory_of_file ${logname}`
   logfile=$fullpath".log"
   echo logfile: $logfile

   if sz=$(ipms files stat --format="<size>" ${logfile} 2>/dev/null)
   then
      ipfs_append_of_text_of_file "$tic: ${qm}" ${logfile}
   else
      echo "$tic: $qm" | ipms files write --create --raw-leaves "${logfile}"
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

    writelog_of_mutable_of_logname /.brings brings
}

post_identity_to_root()
{
    if [ $debug -eq 1 ]; then
	echo "Entering in post_identity_to_root $*"
    fi
    
    if [ "x$email" = 'x' ]; then
       if [ "x$peerid" = 'x' ]; then
         peerid=$(ipms config Identity.PeerID)
       fi
       eval "$(fullname -a $peerid | eyml)"
    fi
    
    if ! ipms files stat --hash /root/directory 1>/dev/null 2>&1; then
	ipms files mkdir /root/directory
    else
	if ipms files rm -r "/root/directory/$email" 2>/dev/null; then true; fi
    fi

    qm=$(ipms files stat --hash /my/identity)
    ipms files cp /ipfs/$qm "/root/directory/$email"
}

update_bootstrap_path() {
  # usage: update_bootstrap_path /.brings/bootstrap

   key="QmVdu2zd1B8VLn3R8xTMoD2yBVScQ1w9UMbW7CR1EJTVYw"
   mfspath="$1"

   if [ $debug -eq 1 ]; then
      echo "Entering in update_bootstrap_path $*"
   fi

   if ! ipms files stat --hash ${mfspath%/*} 1>/dev/null 2>&1; then
      ipms files mkdir -p ${mfspath%/*}
   fi
   if ipath=$(ipms name resolve ${key} 2>/dev/null); then
      if ipms files rm -r ${mfspath} 2>/dev/null; then true; fi
      if ipms files cp ${ipath} ${mfspath}; then true; fi
   else
      echo "warning: ${key} not resolved"
   fi
  
}

main $@ ;

exit 0
