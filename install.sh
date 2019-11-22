# 

# installation [script](https://raw.githubusercontent.com/Gradual-Quanta/minichain/master/_data/install.yml)

# 1. INSTALLING LOCAL PERL MODULES ...
# ------------------------------------

echo running _perl5/boostrap.sh
curl -s https://raw.githubusercontent.com/Gradual-Quanta/minichain/master/_perl5/bootstrap.sh | sh /dev/stdin

echo running bin/install_modules.sh
curl -s https://raw.githubusercontent.com/Gradual-Quanta/minichain/master/bin/install_modules.sh | sh /dev/stdin


# 2. INSTALLING IPFS ...
# ----------------------

echo _ipfs/bin/bootstrap.sh
curl -s https://raw.githubusercontent.com/Gradual-Quanta/minichain/master/_ipfs/bin/bootstrap.sh | sh /dev/stdin
