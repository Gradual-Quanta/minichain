# 
export BRNG_HOME=${BRNG_HOME:-$HOME/.brings}
export IPMS_HOME=${IPMS_HOME:-$HOME/.ipms}
export IPFS_PATH=${IPFS_PATH:-$BRNG_HOME/ipfs}
export PATH=$BRNG_HOME/bin:$IPMS_HOME/bin:$PATH
ipms shutdown
sleep 1
ps ux | grep -w [i]p[fm]s
echo .

