#

set -e
# this script sync up w/ mfs
# $qm: ~$
#
dir=$(pwd)
name=${dir##*/.brings/}
echo name: $name

qm=$(ipms add -Q -r .)
if pv=$(ipms files stat --hash /.brings/$name); then
 ipms files rm -r /.brings/$name
 ipms files cp /ipfs/$qm /.brings/$name
 ipms files cp /ipfs/$pv /.brings/$name/prev
else
 if ipms files mkdir -p /.brings/$name 1>/dev/null; then true; fi
 ipms files cp /ipfs/$qm /.brings/$name
fi
qm=$(ipms files stat --hash /.brings/$name)
echo "qm: $qm # copied to /.brings/$name"
echo url: https://gateway.ipfs.io/ipfs/$qm
xdg-open https://cloudflare-ipfs.com/ipfs/$qm

exit $?;
true; # $Source: /.brings/system/bin/sync.sh$
