#

set -ex
gwhost=$(ipms config Addresses.Gateway | cut -d'/' -f 3)
gwport=$(ipms config Addresses.Gateway | cut -d'/' -f 5)
peerid=$(ipms --offline config Identity.PeerID)
qm=$(ipms add -Q $HOME/.brings/system/bin/fullname.pl --progress=0)
bin=$(ipms files stat --hash /.brings/system/bin)
brng=$(ipms files stat --hash /.brings)
ipms --offline name publish --allow-offline /ipfs/$brng

CF=https://cloudflare-ipfs.com
GW=https://gateway.ipfs.io
DW=http://dweb.link
if [ "x$peerid" = 'xQmZV2jsMziXwrsZx5fJ6LFXDLCSyP7oUdfjXdHSLbLXxKJ' ]; then
false
fi

main() {
     ipms files read /.brings/system/bin/fullname.pl | perl /dev/stdin $*
     ipms cat /ipfs/$qm | perl /dev/stdin $*
     curl -s https://ipfs.blockringtm.ml/ipfs/$qm | perl /dev/stdin $*
     curl --connect-timeout 5 --max-time 67 $GW/ipfs/$brng/system/bin/fullname.pl | perl /dev/stdin $*
     curl http://$gwhost:$gwport/ipns/$peerid/system/bin/fullname.pl | perl /dev/stdin $*
     curl -s $CF/ipfs/$bin/fullname.pl | perl /dev/stdin $*
     curl -s http://$gwhost:$gwport/ipfs/$qm | perl /dev/stdin $*
}

main $@;
exit $?; # $Source: /my/shell/script/fullname-remote.sh$
