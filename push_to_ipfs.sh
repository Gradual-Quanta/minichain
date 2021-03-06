#

cwd=$(pwd)
name=${cwd##*/}
tic=$(date +%s)
qm=$(ipms add -r -Q .)
bafy=$(ipms cid base32 $qm)
pv=$(tail -1 $name.log | cut -d' ' -f 2) 
ipms pin rm $pv
if ipfs files stat --hash /repo/$name; then
  ipfs files rm -r /repo/$name
else 
if ipfs files mkdir -p /repo; then true; fi
fi
ipfs files cp /ipfs/$qm /repo/$name
echo "$tic: $qm" >> $name.log
echo $tic: $qm
cat > LAST_HASH <<EOF
# $name ($tic)
# local browser view
url: http://127.0.0.1:8199/ipfs/$qm
# gateway view
url: http://127.0.0.1:5122/ipns/webui.ipfs.io/#/ipfs/$qm
url: http://127.0.0.1:5122/ipns/webui.ipfs.io/#/explore/ipfs/$qm
# public view
url: http://dweb.link/ipfs/$qm
url: https://cloudflare-ipfs.com/ipfs/$qm
url: https://$bafy.cf-ipfs.com/
# command line
cmd: |
qm=$qm
ipms ping -n 1 Qmd2iHMauVknbzZ7HFer7yNfStR4gLY1DSiih8kjquPzWV # OVH
ipms ping -n 1 QmZV2jsMziXwrsZx5fJ6LFXDLCSyP7oUdfjXdHSLbLXxKJ # michelc
ipms get \$qm -o blockchain; cd blockchain
xdg-open http://127.0.0.1:8199/ipfs/$qm
# previous: $pv
#
EOF
# --------------------------------------------
if [ "x$1" != 'x-n' ]; then
qm=$(ipms add -r -Q .)
git add LAST_HASH
git commit -m "HASH: $qm; $(date +'%D %T')"
git push
fi
# --------------------------------------------
ipms ping -n 1 Qmd2iHMauVknbzZ7HFer7yNfStR4gLY1DSiih8kjquPzWV
cat | ssh blockring sh -e  <<EOT
ps ux | grep [i]pfs
ipfs pin rm $pv
ipfs pin add $qm
ipfs files mkdir -p /repo
ipfs files rm -r /repo/$name
ipfs files cp /ipfs/$qm /repo/$name
EOT
xdg-open https://ipfs.blockringtm.ml/ipfs/$qm
# --------------------------------------------



exit $?
true; # $Source: /.brings/files/minichain/push_to_ipfs.sh$
