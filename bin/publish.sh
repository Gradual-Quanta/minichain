# 

# this script publish the hash of /.brings to the peerid

set -e

if [ "x$1" = 'x-off' ]; then shift; offline='--offline'; fi

# set up local IPFS environment ...
export IPFS_PATH=$(pwd)/_ipfs
export PATH=_ipfs/bin:$(pwd)/bin:$PATH
#export LC_TIME='fr_FR.UTF-8'

if ! perl -Mlocal::lib=$(pwd)/_perl5 -e 1; then
  echo "perl: local::lib not found"
  echo " check if your PERL5LIB environment variable is properly set"
  echo " maybe you forgot to run . rc.sh !"
  exit $?
fi

gwhost=$(ipfs config Addresses.Gateway | cut -d'/' -f 3)
gwport=$(ipfs config Addresses.Gateway | cut -d'/' -f 5)
peerid=$(ipfs config Identity.PeerID)
eval "$(fullname -a $peerid | eyml)"

if ! ipfs files stat --hash /.brings 1>/dev/null 2>&1; then
ipfs files mkdir -p /.brings
fi

tic=$(date +%s)

qm=$(ipfs files stat --hash /my/identity/public.yml)
if sz=$(ipfs files stat --format="<size>" /.brings/identity.log 2>/dev/null); then
echo "$tic: $qm" | ipfs files write -o $sz --raw-leaves "/.brings/identity.log"
else
echo "$tic: $qm" | ipfs files write --create --raw-leaves "/.brings/identity.log"
fi

# publish /public
qm=$(ipfs files stat --hash /public)
if sz=$(ipfs files stat --format="<size>" /.brings/public.log 2>/dev/null); then
echo "$tic: $qm" | ipfs files write -o $sz "/.brings/public.log"
else
echo "$tic: $qm" | ipfs files write --create "/.brings/public.log"
fi
# publish root
if ! ipfs files stat --hash /root/directory 1>/dev/null 2>&1; then
  ipfs files mkdir /root/directory
else
  if ipfs files rm -r "/root/directory/$email" 2>/dev/null; then true; fi
fi
qm=$(ipfs files stat --hash /my/identity)
ipfs files cp /ipfs/$qm "/root/directory/$email"
qm=$(ipfs files stat --hash /root)
if sz=$(ipfs files stat --format="<size>" /.brings/root.log 2>/dev/null); then
echo "$tic: $qm" | ipfs files write -o $sz "/.brings/root.log"
else
echo "$tic: $qm" | ipfs files write --create "/.brings/root.log"
fi
# publish my
qm=$(ipfs files stat --hash /my)
if sz=$(ipfs files stat --format="<size>" /.brings/my.log 2>/dev/null); then
echo "$tic: $qm" | ipfs files write -o $sz "/.brings/my.log"
else
echo "$tic: $qm" | ipfs files write --create --truncate "/.brings/my.log"
fi

# publish brings itself !
bot=$(ipfs add -Q $0)
if ipfs files rm /.brings/publish.sh 2>/dev/null; then true; fi
ipfs files cp /ipfs/$bot "/.brings/${0##*/}"
brkey=$(ipfs files stat --hash /.brings)
echo "brkey: $brkey"
#ipfs files read /.brings/brings.log
#ipfs files read /.brings/brings.log | wc
#ipfs files stat /.brings/brings.log
echo .
if ipfs files stat --hash /.brings/brings.log 1>/dev/null 2>&1 ; then
sz=$(ipfs files stat --format="<size>" /.brings/brings.log 2>/dev/null)
echo "$tic: $brkey" | ipfs files write -o $sz --raw-leaves "/.brings/brings.log"
ipfs files read /.brings/brings.log 2>/dev/null | wc -c
else
echo "$tic: $brkey" | ipfs files write --create --raw-leaves "/.brings/brings.log"
fi
ipfs files read "/.brings/brings.log"
ipfs files stat /.brings/brings.log
echo .
brkey=$(ipfs files stat --hash /.brings)
ipfs --offline name publish --allow-offline $brkey 1>/dev/null 2>&1
echo "url: https://gateway.ipfs.io/ipfs/$brkey"
echo "url: http://$gwhost:$gwport/ipns/$peerid"
ipfs $offline name publish --allow-offline $brkey | sed -e 's/^/info: /'


if ! ipfs files stat --hash /my/friends 1>/dev/null 2>&1; then
ipfs files mkdir -p /my/friends
ipfs files cp /ipns/QmZV2jsMziXwrsZx5fJ6LFXDLCSyP7oUdfjXdHSLbLXxKJ /my/friends/michelc
ipfs file cp /ipns/QmVMV1xJsLH3rxmmYVEU4SZ4rjmdGBgLZF3ddbXuyKXSBy /my/friends/emilea
fi


