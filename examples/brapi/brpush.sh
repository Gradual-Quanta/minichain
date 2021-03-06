#

# dependencies:
upload="/.brings/system/bin/upload.sh"

list="mutable.log README.md dircolors dircolorrc test.sh"

tic=$(date +%s)
qm=$(ipms add -Q -w $list)
echo $tic: $qm
perl -npi -e "s,Qm[^/]+,$qm,g; s,\\\$tic: \w+\\\$,\\\$tic: $tic\\\$," README.md
pandoc README.md -o README.html

# update mutable ...
echo $tic: $qm >> mutable.log
qm=$(ipms add -Q -w $list "$0" README.html)
sed -i -e "s,date: .*$,date: $(date +%D)," \
       -e "s,url: .*$,url: https://gateway.ipfs.io/ipfs/$qm," mutable.log
echo url: http://dweb.link/ipfs/$qm

ipms files read $upload | sh /dev/stdin $list

exit 0
