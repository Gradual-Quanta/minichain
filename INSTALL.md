#
rm -rf minichain
git clone https://github.com/Gradual-Quanta/minichain.git

cd minichain
git pull

# set env' variables
. ./config.sh

# installation des modules perl
sh .brings/bootstrap/perl5/install-local-lib.sh
sh .brings/bootstrap/perl5/install_modules.sh

sh start.sh

fullname -a $(peerid)

