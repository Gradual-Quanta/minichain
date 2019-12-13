#
export IPMS_HOME=$HOME/.ipms
export BRNG_HOME=$HOME/.brings
export IPFS_PATH=$HOME/.brings/ipfs
export PERL5LIB=$HOME/.brings/perl5/lib/perl5

if test -e $BRNG_HOME/envrc.sh; then
. $BRNG_HOME/envrc.sh
fi

if [ "x$PROJDIR" = 'x' ]; then
PROJDIR=$(pwd)
PATH="$PROJDIR/bin:$PATH"
fi
