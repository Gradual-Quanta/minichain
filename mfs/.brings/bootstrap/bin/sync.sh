#


for i in "$@"; do
case $i in
    -o|--offline) offline='--offline' ;;
    *) # unknown option ;;
esac
done

if echo "$0" | grep -q '^/'; then
  rootdir="${0%/bin/*}"
else
  rootdir="$(pwd)"; rootdir="${rootdir%/bin}"
fi
echo rootdir: $rootdir
symb="${rootdir##*/}"
if echo $symb | grep -q '^\.'; then
symb=$(echo $symb | sed -e 's/\.//')
fi
echo symb: $symb
# --------------------------------------------------------------
if ipms key list | grep -q -w $symb; then
 key=$(ipms key list -l | grep -w $symb | cut -d' ' -f 1)
 echo key: $key
   sed -i -e "s/symb='.*'$/symb='$symb'/" \
          -e "s/key='.*'$/key='$key'/" install.sh # $'s are important
fi
# --------------------------------------------------------------
if test -d $rootdir; then
  qm=$(ipms add -r -Q $rootdir)
  echo $symb: $qm
  sed -i -e "s/qm='.*'$/qm='$qm'/" \
         -e "s,ipath='/ipfs/.*'$,ipath='/ipfs/$qm'," install.sh
  qm=$(ipms add -r -Q $rootdir)
else
  qm='QmPTikJK88afXaXb1HP93JHFa3crTvX5TMDLLpTEAFBrgP'
fi
# --------------------------------------------------------------
if pv=$(ipms files stat --hash /.brings/$symb 2>/dev/null); then
  ipms files rm -r /.brings/$symb
  ipms files cp /ipfs/$qm /.brings/$symb
  if ipms files rm /.brings/$symb/prev 2>/dev/null; then true; fi
  ipms files cp /ipfs/$pv /.brings/$symb/prev
else 
  ipms files cp /ipfs/$qm /.brings/$symb
fi
# --------------------------------------------------------------
qm=$(ipms files stat --hash /.brings/$symb)
ipms $offline name publish --allow-offline --key=$symb /ipfs/$qm
# --------------------------------------------------------------
exit $?



true; # $Source: /my/shell/scripts/sync.sh$
