# 

BRNG_HOME=${BRNG_HOME:-$HOME/.brings}
key=''
# ipfs name publish --key=system $(ipfs add -r -Q $PROJDIR/.brings/system)
ipath=$(ipms resolve $key/system)
qm='QmbXjzH9LzbxP7pCstKVEQZdXyLDkP2jAZFstzbfe9ju4W';
ipms $qm -o $BRNG_HOME/system