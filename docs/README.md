---
layout: default
---
## mini blockchain ([mychelium][42])
<meta charset="utf8"/>
<!-- {% if site.GH_ENV == 'gh_pages' %} -->
[![HitCount](https://hits.dwyl.io/Gradual-Quanta/minichain.svg)](http://hits.dwyl.io/Gradual-Quanta/minichain)
<!-- {% endif %} -->
[![Netlify Status](https://api.netlify.com/api/v1/badges/9861b9fa-9749-4a61-b1fb-f32502348934/deploy-status)](https://app.netlify.com/sites/festive-leakey-329460/deploys)
[![Github all releases](https://img.shields.io/github/downloads/Gradual-Quanta/minichain/total.svg)](https://GitHub.com/Gradual-Quanta/minichain/releases/)

Our blockchain uses [IPFS][4] as a backbone, and has a application layer made with [perl][5],
so it requires the installation of a few modules prior to use.

 blockchain is build on 3 

* a [content addressed storage][9] using a cryptographycally [secured hash][8]
  (here we use [ipfs][4])
* a mutable to immutable resolver acting as a [decentralized namespace][6]
* an authentication system for access control ([ydentity][7]'s [HIP6][10])

### mutables and immutables address

A mutable address is a permanent reference (URI) to a document which content can be update
without changing in its address.

On the opposite side a immutable is a read-only record that can't be tampered without
breaking its URI, i.e. the slightest change in the content lead to a change in its address.
Therefore the integrity of a document referenced with an immutable address is guaranteed.

[6]: https://duckduckgo.com/?q=!g+decentralized+namespace
[7]: https://duckduckgo.com/?q=!g+decentralized+identity+site:ydentity.ml
[8]: https://duckduckgo.com/?q=!g+cryptographycally+secure+hash+%23M4GC
[9]: https://duckduckgo.com/?q=!g+content+addressed+storage
[10]: https://duckduckgo.com/?q=!g+Human+IP+address+ydentity
[42]: https://duckduckgo.com/?q=!g+%22mychelium%22

#### examples

* mutable : [/files/etc/motd](http://gateway.local/webui#/files/etc/motd)

* immutable : [/ipfs/{{site.docs.data.install.qm}}](https://cloudflare-ipfs.com/ipfs/{{site.docs.data.install.qm}})

## INSTALLATION (2 methods)

A. running a shell script :


 1. clone this [repository][1] :
 ```sh
 git clone https://github.com/Gradual-Quanta/minichain.git minichain
 ```
 2. run the command :
 ```sh
 cd minichain
 sh ./install.sh
 ```

B. running the script form the web (curl) :

 Directly execute the /bin/sh [shell script][2] from [github][3] or from [IPFS][2]
 ```sh
 curl -s https://raw.githubusercontent.com/Gradual-Quanta/minichain/master/install.sh | sh /dev/stdin
 ```
 or 
 ```sh
   curl https://ipfs.blockring™.ml/ipfs/{{site.docs.data.install.qmhash}} | sh /dev/stdin
 ```

[1]: https://github.com/Gradual-Quanta/minichain
[2]: https://github.com/Gradual-Quanta/minichain/blob/master/install.sh
[2raw]: https://raw.githubusercontent.com/Gradual-Quanta/minichain/master/install.sh 
[3]: https://github.com/Gradual-Quanta
[4]: https://github.com/ipfs/go-ipfs
[5]: https://github.com/Perl/perl5
