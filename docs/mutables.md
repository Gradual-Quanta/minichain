---
layout: default
---
# mutable conversion

This pages is a demo for converting the pathname passed as the URL#fragment
into an immutable address (based on SHA256).

The conversion is made by requesting the local ipms node to resolve
the addresses.

exemple of conversion :

* [/etc/motd](http://webui.local/webui#/files/etc/motd) -> [/webui#/files/etc/motd](http://webui.local/webui#/files/etc/motd)
* [/my/identity/public.yml](http://webui.local/webui#/files/my/identity/public.yml) -> [/webui#/files/my/identity/public.yml](http://webui.local/webui#/files/my/identity/public.yml)
* [/ipns][1][/self](http://gateway.local/ipns/%peerid%) -> [/webui#/files/root/](http://gateway.local/ipns/self)

### more info about this mini blockchain :

* [/minichain](.)

[1]: https://duckduckgo.com/?q=mutable+naming+system+blockRing
