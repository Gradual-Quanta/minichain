# 

BRNG_HOME=${BRNG_HOME:-$HOME/.brings}
qm=$(ipms files stat --hash /.brings/bootstrap/bin)
ipms get $qm -o $BRNG_HOME/bin --progress=0
qm=$(ipms files stat --hash /.brings/bootstrap/etc)
ipms get $qm -o $BRNG_HOME/etc --progress=0
