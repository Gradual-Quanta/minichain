---
---
/*
 This script talk to the 5001 gateway to convert
 a mfs path into a immutable qm hash
*/
const status = resp => {
  if (resp.status >= 200 && resp.status < 300) {
    return Promise.resolve(resp)
  }
  return Promise.reject(new Error(resp.statusText))
}
const error = err => { console.log(err); }

// ipms config Addresses.API
//const webui = 'http://127.0.0.1:5001';
const webui = '{{site.data.ipfs.webui}}'
const api_url = webui + '/api/v0/'

//const lgw = 'http://127.0.0.1:8080'
const lgw = '{{site.data.ipfs.gateway}}'
const pgw = 'https://ipfs.blockringtm.ml';

var bod = document.getElementsByTagName('body')[0];
    bod.innerHTML = bod.innerHTML.replace(/http:\/\/gateway.local/g,lgw);
    bod.innerHTML = bod.innerHTML.replace(/http:\/\/gateway.public/g,pgw);

var map = {}
var promises = [ getPeerID().then( id => {
	    map['/ipns/self/'] = '/ipns/'+id+'/';
	    bod.innerHTML = bod.innerHTML.replace(/%peerid%/g,id);
	    bod.innerHTML = bod.innerHTML.replace(new RegExp('/ipns/self','g'),'/ipns/'+id);
}).catch(error) ]


/* Ex: /webui#/files/root/path/to/file -> /ipfs/QmePDtaxkqnR5kKL4qNp1w91WuJ6X5r3mYux7Bv6Vnd5zK */
// ( /webui#/files( /[^"" <>]* )? )/?( [^/"" <>]+ ) 
let matches = bod.innerHTML.matchAll(
    new RegExp('(/webui#/files(/[^" <>]*)?)/([^/" <>]+)','g') )
for(let result of matches) {
   let match = result[0]; // all that match
   let mutable = result[1]; // all mutable path
   let parentdir = result[2] || '/' ; // parent folder 
   let fname = result[3]; // filename

   console.log('result: ',result)
   if (typeof(map[mutable]) == 'undefined') {
      promises.push( getHashKey(parentdir).then( h => {
	 if (typeof(h) != 'undefined') {
	    console.log('[ '+match+'=> /ipfs/'+h+'/'+fname+' ]')
	    console.log('s,'+mutable+',/ipfs/'+h+',g') // OK
	    map[mutable] = '/ipfs/'+h;
	    bod.innerHTML = bod.innerHTML.replace( new RegExp(mutable,'g'),map[mutable]);
	    bod.innerHTML = bod.innerHTML.replace(/http:\/\/webui.local\/ip/g,lgw+'/ip');
	 }
      } ).catch(error) );

   } else {
      bod.innerHTML = bod.innerHTML.replace( new RegExp(mutable,'g'),map[mutable]);
      bod.innerHTML = bod.innerHTML.replace(/http:\/\/webui.local\/ip/g,lgw+'/ip');

   }

}

    Promise.all(promises).then(callback).catch(error)

function callback(results) {

  bod.innerHTML = bod.innerHTML.replace(/http:\/\/webui.local\/webui/g,webui+'/webui');
  console.log(results)
}

function getPeerID() {
  var url = api_url + 'config?&arg=Identity.PeerID&encoding=json'
  console.log(url);
  return fetchjson(url)
     .then( obj => { return Promise.resolve(obj.Value) })
     .catch(error)
}

function getHashKey(path) {
   // get the hash corresponding to the mfs path
   var url = api_url + 'files/stat?arg='+path+'&hash=1';
   console.log(url);
   return fetchjson(url)
      .then( obj => { console.log(obj); return obj.Hash; } )
      .then( mhash => {
            console.log('path: '+mhash+' '+path);
            return Promise.resolve(mhash) })
      .catch(error)
}

function fetchjson(url) {
  return fetch(url).then(status).then( resp => resp.json() )
}

