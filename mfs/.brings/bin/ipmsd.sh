#

green="[32m"
yellow="[33m"
red="[31m"
nc="[0m"

if echo $0 | grep -q '/'; then
bindir=${0%/*}
else
bindir=.
fi

PATH=$bindir:$PATH
if [ "x$DICT" = 'x' ]; then
export DICT=$bindir/../etc
fi
if [ "x$IPMS_HOME" != 'x' ]; then
export PATH=$IPMS_HOME/bin:$PATH
fi

#qm=$(echo "IPFS is active" | ipms add --offline -Q) && echo "qm: $qm"
which ipms

#export IPFS_PATH=${IPFS_PATH:=$BRNG_HOME/ipfs}
if ! ipms swarm addrs local 2>/dev/null; then
  echo "${yellow}Starting ipms daemon${nc}"
  OPTIONS="--unrestricted-api --enable-namesys-pubsub"
  if [ "x$IPFS_PATH" != 'x' ]; then
    pp=$(cat $IPFS_PATH/config | xjson Addresses.Gateway | cut -d'/' -f 5)
    peerid=$(cat $IPFS_PATH/config | xjson Identity.PeerID)
  else
    pp=$(ipms --offline config Addresses.Gateway | cut -d'/' -f 5)
    peerid=$(ipms --offline config Identity.PeerID)
  fi
  name=$(perl -S fullname.pl $peerid)

  if which rxvt 1>/dev/null; then
    rxvt -geometry 128x18 -bg black -fg orange -name IPFS -n "$pp" -title "ipms daemon:$pp (${IPFS_PATH:-~/.ipfs}) ~ $name" -e ipms daemon $OPTIONS &
  else
    if which xterm 1>/dev/null; then
      xterm -geometry 128x18 -bg black -fg orange -name IPFS -n "$pp" -title "ipms daemon:$pp (${IPFS_PATH:-~/.ipfs}) ~ $name" -e ipms daemon $OPTIONS &
    else
      if which xterm 1>/dev/null; then
        gnome-terminal --title "ipms daemon:$pp ($IPFS_PATH) ~ $name" -- ipms daemon $OPTIONS &
      else
        ipms daemon $OPTIONS &
      fi
    fi
  fi

  sleep 7

else
  echo "${green}ipms daemon is already running${nc}"
  gwhost=$(ipms config Addresses.Gateway | cut -d'/' -f 3)
  gwport=$(ipms config Addresses.Gateway | cut -d'/' -f 5)
  peerid=$(ipms config Identity.PeerID)
  name=$($bindir/fullname $peerid)
  echo "ipms: 'daemon:$gwport ($IPFS_PATH) ~ $name'"

  apihost=$(ipms config Addresses.API | cut -d'/' -f 3)
  apiport=$(ipms config Addresses.API | cut -d'/' -f 5)
  echo "url: http://$apihost:$apiport/webui"

fi



