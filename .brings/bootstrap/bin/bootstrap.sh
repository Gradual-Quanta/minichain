#
# ----------------------------------------------------------------
# update bootstrap folder (Pablo O. Haggar)
key='QmVdu2zd1B8VLn3R8xTMoD2yBVScQ1w9UMbW7CR1EJTVYw'
# ipfs name publish --key=bootstrap $(ipfs add -r -Q $PROJDIR/.brings/bootstrap)
if ipath=$(ipms --timeout 5s resolve /ipns/$key 2>/dev/null); then
 echo "bootstrap: $ipath # (global)"
else
  # default to Elvis C. Lagoo
  # ipfs add -r -Q $PROJDIR/.brings/bootstrap
  ipath='/ipfs/QmRHojNyd6zabbDE5ZyNnXJdNKb1pTjXQvWx5UQFmFy3g7'
  echo "bootstrap: ${ipath#/ipfs/}"
fi
if ipms files stat --hash /.brings 1>/dev/null 2>&1; then
  if pv=$(ipms files stat --hash /.brings/bootstrap 2>/dev/null); then
    ipfs files rm -r /.brings/bootstrap
    ipms files cp $ipath /.brings/bootstrap
    if [ "${ipath#/ipfs/}" != "$pv" ]; then
      if ipfs files rm -r /.brings/bootstrap/prev 2>/dev/null; then true; fi
      ipms files cp /ipfs/$pv /.brings/bootstrap/prev
      ipath=/ipfs/$(ipms files stat --hash /.brings/bootstrap)
      echo "bootstrap: ${ipath#/ipfs/} # (new)"
    fi
  else
    ipms files cp $ipath /.brings/bootstrap
  fi
else
  ipms files mkdir /.brings
  ipms files cp $ipath /.brings/bootstrap
fi
# ---------------------------------------------------------------------


