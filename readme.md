# BRAT Server Setup
Just a couple of scripts to configure a working [BRAT annotator][brat-url] on a
Debian 10 or Ubuntu 20.04 server through apache. Note that these will overwrite
config files under `/etc/apache` so you probably should avoid running these
scripts outside of a fresh vm install.

I've tested this setup on a `f1-micro` compute engine on [Google Cloud][gcp]
with the `debian-10-buster-v20200714` image.

## Setting up the server
Run `/serverconfig.sh` to download, install and configure the server.

## Configure extra stuff
Running `/enviroconfig.sh` will setup some utilities for better file editing
and navigation (neovim, fuzzyfind and nnn, as well as some aliases and
environment variables). You'll need to manually edit this script incase you're
using an Ubuntu instance instead of Debian.

[brat-url]: https://brat.nlplab.org/index.html
[gcp]: https://cloud.google.com/free