# 

BRNG_HOME=${BRNG_HOME:-$HOME/.brings}
key='QmVQd43Y5DQutAbgqiQkZtKJNd8mJiZr9Eq8D7ac2PeSL1' # minimal's key
# ipms name publish --key=minimal $(ipms add -r -Q $PROJDIR/.brings/minimal)
ipath=$(ipms resolve $key/system)
qm='QmbXjzH9LzbxP7pCstKVEQZdXyLDkP2jAZFstzbfe9ju4W';
ipms get $qm -o $BRNG_HOME/system --progress=0