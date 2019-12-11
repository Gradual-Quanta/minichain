# installing perlmodules ...

rootdir=${BRNG_HOME:-$HOME/.brings}

if test -e /etc/environment; then
   . /etc/environment
else
   export PATH=/usr/local/bin:/usr/bin:/bin; 
fi
export PATH=${rootdir}/bin:$PATH

# perl's local lib
eval $(perl -I$rootdir/perl5/lib/perl5 -Mlocal::lib=$rootdir/perl5)

perl -MCPAN -Mlocal::lib=$rootdir/perl5 -e 'CPAN::install(YAML::Syck)'
perl -MCPAN -Mlocal::lib=$rootdir/perl5 -e 'CPAN::install(MIME::Base32)'
perl -MCPAN -Mlocal::lib=$rootdir/perl5 -e 'CPAN::install(Math::BigInt)'
perl -MCPAN -Mlocal::lib=$rootdir/perl5 -e 'CPAN::install(Encode::Base58::BigInt)'
