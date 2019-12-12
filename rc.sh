
if envf=$($IPMS_HOME/bin/ipms files stat --hash /.brings/envrc.sh 2>/dev/null); then false; fi
envf=${envf:-QmatranAvyXAQ2eMKB1ZhZdtUaRzyohWHVkGi17GQHn7p7}
export BRNG_HOME=${BRNG_HOME:-$HOME/.brings}
export IPMS_HOME=${IPMS_HOME:-$BRNG_HOME/.ipms}
export IPFS_PATH=${IPFS_PATH:-$BRNG_HOME/ipfs}
export PERL5LIB=${PERL5LIB:-$BRNG_HOME/perl5/lib/perl5}

# ipms add -r -Q $PROJDIR/.brings/minimal/envrc.sh
eval "$($IPMS_HOME/bin/ipms cat /ipfs/$envf)"

if false; then
 raw=https://raw.githubusercontent.com/Gradual-Quanta/minichain/master
 envf=$($IPMS_HOME/bin/ipms add -Q $raw/.brings/minimal/envrc.sh --progress=0)
 sed -i -e "s/envf=\${envf:-.*}$/envf=\${envf:-$envf}/" -e 's/if [t]rue;/if false;/' $0
fi
true; # $Source: /my/shell/scripts/rc.sh$
