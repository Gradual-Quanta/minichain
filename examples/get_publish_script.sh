#

# script for retrieving publish.sh (it places a copy at official_publishj.sh)
# $author: QmZV2jsMziXwrsZx5fJ6LFXDLCSyP7oUdfjXdHSLbLXxKJ@ipfs$
# $qm: z6t$

echoerr() { printf "%s\n" "$*" >&2; }

main(){
 set -e
 get_publish_script;
}

get_publish_script() {
 addr=$(get_ipfs_addr)
 fetch_from_ipms $addr official_publish.sh
 echoerr ${0##*/}: official_publish.sh downloaded
}

get_ipfs_addr(){
  brings_path=$(get_brings_ipath)
  echo $(resolve_path $brings_path/publish.sh)
}
get_brings_ipath(){
  michel_id='QmZV2jsMziXwrsZx5fJ6LFXDLCSyP7oUdfjXdHSLbLXxKJ'
  echo $(resolve_peerid $michel_id)
}

fetch_from_ipms(){
  echoerr ${0##*/}: get $1
  ipms get "$1" -o "$2"
}

resolve_peerid(){
  echoerr ${0##*/}: resolving $1
  echo $(ipms name resolve "$1")
}
resolve_path(){
  echoerr ${0##*/}: resolving $1
  echo $(ipms resolve "$1")
}


main;
exit $?; # $Source: /.brings/files/examples/get_publish_script.sh$
