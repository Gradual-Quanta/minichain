#

# $Source: /.brings/system/bin/sync.sh$
qm=$(ipfs files stat --hash /.brings)
ipfs get /ipfs/$qm -o .

