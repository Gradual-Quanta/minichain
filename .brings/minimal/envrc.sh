#

export BRNG_HOME=${BRNG_HOME:=$HOME/.brings}
export IPMS_HOME=${IPMS_HOME:=$HOME/.ipms}
export IPFS_PATH=${IPFS_PATH:-$BRNG_HOME/repos}

# vim: sw=3 et ts=2
if test -e /etc/environment; then
   . /etc/environment
else
   export PATH=/usr/local/bin:/usr/bin:/bin; 
fi
# ---------------------------------------------------------------------
echo IPFS_PATH: $IPFS_PATH

if test -d $IPMS_HOME/bin ; then
PATH="$IPMS_HOME/bin:$PATH"
fi
if test -d $BRNG_HOME/bin ; then
PATH="$BRNG_HOME/bin:$PATH"
fi
if test -d $BRNG_HOME/etc; then
export DICT="$BRNG_HOME/etc"
fi
# ---------------------------------------------------------------------
if test -d $BRNG_HOME/perl5/lib/perl5; then
# perl's local lib
eval $(perl -I$BRNG_HOME/perl5/lib/perl5 -Mlocal::lib=$BRNG_HOME/perl5)
fi

unset LC_MEASUREMENT
unset LC_PAPER
unset LC_MONETARY
unset LC_NAME
unset LC_ADDRESS
unset LC_NUMERIC
unset LC_TELEPHONE
unset LC_IDENTIFICATION
unset LC_TIME
unset LC_ALL

