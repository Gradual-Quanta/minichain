#

set -e
apihost=$(ipfs config Addresses.API | cut -d'/' -f 3)
apiport=$(ipfs config Addresses.API | cut -d'/' -f 5)
gwhost=$(ipfs config Addresses.Gateway | cut -d'/' -f 3)
gwport=$(ipfs config Addresses.Gateway | cut -d'/' -f 5)
gwhost=$(ipfs config Addresses.Gateway | cut -d'/' -f 3)
gwport=$(ipfs config Addresses.Gateway | cut -d'/' -f 5)
peerid=$(ipfs config Identity.PeerID)

echo peerid: $peerid
ipfs --offline name publish --allow-offline $(ipfs files stat --hash /.brings) 1>/dev/null
echo  url: http://$gwhost:$gwport/ipns/$peerid
echo  url: http://$apihost:$apiport/webui/#/explore/ipns/$peerid
xdg-open "http://$apihost:$apiport/ipns/webui.ipfs.io/#/explore/ipns/$peerid"


