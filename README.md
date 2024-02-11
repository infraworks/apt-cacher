# apt-cacher
apt-cacher is a Debian package caching proxy solution.


* Add proxy

```bash
echo "Acquire::http::Proxy \"http://192.168.42.27:3142\";" > /etc/apt/apt.conf.d/00aptproxy
```
