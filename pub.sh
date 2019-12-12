#

# /!\ not the same IPFS node, but the default user's one
export IPFS_PATH=$HOME/.ipfs
pv=$(ipms --offline add -Q -n https://raw.githubusercontent.com/Gradual-Quanta/minichain/master/install.sh --progress=false)
if ipms --offline pin rm $pv 2>/dev/null; then false; fi
qm=$(ipms --offline add -Q install.sh --progress=false --pin=true)
echo qm: $qm

cat > docs/_data/install.yml <<EOF
--- # install scripts, command line
pk: QmcfHufAK9ErQ9ZKJF7YX68KntYYBJngkGDoVKcZEJyRve
date: $(date)
pv: $pv
qm: $qm
cmd: "curl https://ipfs.blockring™.ml/ipfs/$qm | sh /dev/stdin"
EOF
git add docs/_data/install.yml

echo url: https://ipfs.blockring™.ml/ipfs/$qm 
