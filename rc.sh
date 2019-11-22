#


# vim: sw=3 et ts=2

cwd=$(pwd)

if test -e /etc/environment; then
   . /etc/environment
else
   export PATH=/usr/local/bin:/usr/bin:/bin; 
fi
export IPFS_PATH=${cwd}/_ipfs
export PATH=${cwd}/bin:$IPFS_PATH/bin:$PATH

if test -d $cwd/_perl5/lib/perl5; then
# perl's local lib
eval $(perl -I$cwd/_perl5/lib/perl5 -Mlocal::lib=$cwd/_perl5)
fi

if test -d $cwd/etc; then
export DICT=${cwd}/etc
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
