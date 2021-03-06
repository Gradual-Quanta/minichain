---
layout: default
---
<meta charset="utf8"/>
## mini blockchain ([mychelium][42])

<!-- {% if site.GH_ENV == 'gh_pages' %} /-->
[![HitCount](https://hits.dwyl.io/Gradual-Quanta/minichain.svg)](http://hits.dwyl.io/Gradual-Quanta/minichain)
<!-- {% endif %} /-->
[![Netlify Status](https://api.netlify.com/api/v1/badges/9861b9fa-9749-4a61-b1fb-f32502348934/deploy-status)](https://app.netlify.com/sites/festive-leakey-329460/deploys)
[![Github all releases](https://img.shields.io/github/downloads/Gradual-Quanta/minichain/total.svg)](https://GitHub.com/Gradual-Quanta/minichain/releases/)

Our blockchain uses [IPFS][4] as a backbone, and has a application layer made with [perl][5],
so it requires the installation of a few modules prior to use.

 blockchain is build on 3 

* a [content addressed storage][9] using a cryptographycally [secured hash][8]
  (here we use [ipfs][4])
* a mutable to immutable resolver acting as a [decentralized namespace][6]
* an authentication system for access control ([ydentity][7]'s [HIP6][10])

### mutables and immutables addresses

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

## MINICHAIN DEMO

All blockRing have two disctinctive part : the [list of records][LoR] on one side which are immutable,
and a [mutable record][mut] to store the "head" of the blockchain.
all mutables are organized as a global mutable file system, where every participant have their own [name-space][files].
all script and commands are specific for each blockring allowing infinite customization.
In fact, it is like a generalization of smart contact, which can be **any** piece of code, that can safely
run on any computers... if the code is stored on a "cas" system then the integrity of it is guaranteed and can
easily verified before execution, for example the [pirl] script is executing remote perl from the IPFS network

To run the demo :

1. install the tools (see below INSTALLATION SECTION)
2. source config.sh file
3. bradd myfirstblock.md # to add file to the blockring
4. xdg-open http://127.0.0.1:5122/webui/#/files/

### Block Ring commands (*smart contract*)

* brget, brput
* brpull (brfetch, brmerge, brreduce)
* bradd, brlink, brpost
* brpush, brirq

### Network discovery

* discover (hop from friends to friends)
* resolver (turn a mutable is an immutable)
* circle join, leave

### identity reputation and web of trust

* follow
* invite
* sign

### Explorer &amp; Navigator

* javascript based resolver

### DATA ORGANIZATION [#/files/][files]

* [/.brings](http://ipfs.io/webui/#/files/.brings) : where the software reside
* [/root](http://ipfs.io/webui/#/files/root) : the /root for sharing files
* [/public](http://ipfs.io/webui/#/files/public) : the your public files
* [/my](http://ipfs.io/webui/#/files/my) : the your personal files
* [/etc](http://ipfs.io/ipns/webui.ipfs.io/#/files/etc ) : miscelleaneous files

The only required files are under [/.brings][brng]

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

For the present, only \*nix is supported, however the script might run under *windows10's bash*.

This installation is does the following

* download the IPFS archive [v0.4.22][43] and *untar* it
* download the perl's [Local::lib][44] module
* and it installs the required CPAN modules runnning an perl [installation script][45]


[1]: https://github.com/Gradual-Quanta/minichain
[2]: https://github.com/Gradual-Quanta/minichain/blob/master/install.sh
[2raw]: https://raw.githubusercontent.com/Gradual-Quanta/minichain/master/install.sh 
[3]: https://github.com/Gradual-Quanta
[4]: https://github.com/ipfs/go-ipfs
[5]: https://github.com/Perl/perl5
[43]: https://dist.ipfs.io/go-ipfs/v0.4.22/go-ipfs_v0.4.22_linux-amd64.tar.gz
[44]: https://duckduckgo.com/?q=Perl+Local::Lib
[45]: https://github.com/Gradual-Quanta/minichain/blob/master/.brings/bootstrap/perl5/install_modules.sh
[LoR]: https://ipfs.io/ipfs/QmfQkD8pBSBCBxWEwFSu4XaDVSWK6bjnNuaWZjMyQbyDub/#/files/.brings/files
[mut]: https://ipfs.io/ipfs/QmfQkD8pBSBCBxWEwFSu4XaDVSWK6bjnNuaWZjMyQbyDub/#/files/.brings/mutables
[files]: https://ipfs.io/ipfs/QmfQkD8pBSBCBxWEwFSu4XaDVSWK6bjnNuaWZjMyQbyDub/#/files/
[brng]: https://ipfs.io/ipfs/QmfQkD8pBSBCBxWEwFSu4XaDVSWK6bjnNuaWZjMyQbyDub/#/files/.brings
[pirl]: https://github.com/Gradual-Quanta/minichain/tree/master/.brings/minimal/bin/pirl


