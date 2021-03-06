#

# $Source: /.brings/system/bin/upload.sh$
# $Parent: /my/shell/dircolors/brpush.sh$
# $Previous: ~$
# this script uploads files to ipms ...

list="$*"

# dependencies:
mfspath="/ipfs/QmX7v4ejhRAAgpFYYHoiJkrh23MnBSme8jh7TnyvVFdwLt/mfspath.pl"

gwhost=$(ipms config Addresses.Gateway | cut -d'/' -f 3)
gwport=$(ipms config Addresses.Gateway | cut -d'/' -f 5)
peerid=$(ipms config Identity.PeerID)

if ! ipms swarm addrs local | sed -e 's/^/info: /'; then
   die
fi



for file in $list; do
  source=$(curl -s "http://$gwhost:$gwport$mfspath" | perl /dev/stdin $file)
  source=${source##*:}
  #echo mfs: $source
  bdir=${source%/*}
  if test "x$bdir" != 'x' && ! ipms files stat --hash $bdir 1>/dev/null 2>&1 ; then
     echo "info: !-e $bdir"
     ipms files mkdir -p $bdir
  fi  
  if pv=$(ipms files stat --hash $source 2>/dev/null); then
     if echo $source | grep -q '/$'; then
	  ipms files rm -r $source
       else
	  ipms files rm $source
       fi
  else
    pv=$(ipms add -Q $file)
  fi
  if echo $source | grep -q '/$'; then
     cwd=$(pwd)
     bdir=${source%/*}
     qm=$(ipms add -Q -r $cwd)
  #echo info: ips files cp /ipfs/$qm $bdir
  ipms files cp /ipfs/$qm $bdir
  ipms files cp /ipfs/$pv $bdir/prev
  else
  sed -i -e "s,\\\$Previous: .*\\\$,\\\$Previous: /ipfs/$pv\\\$,g" \
         -e "s,\\\$tic: .*\\\$,\\\$tic: $tic\\\$," $file
  qm=$(ipms add -Q $file)
  ipms files cp /ipfs/$qm $source
  fi

done

