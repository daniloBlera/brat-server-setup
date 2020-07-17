# Server Setup
Just a couple of scripts to configure a working [BRAT annotator][brat-url] on an
Ubuntu 20.04 server through apache. Note that these will overwrite config files
under `/etc/apache` so you should avoid running these scripts outside of a fresh
vm install.

Run `/serverconfig.sh` to download, install and configure the server.

Running `/enviroconfig.sh` will setup some utilities for better file editing and
navigation (neovim, fuzzyfind and nnn, as well as some aliases and environment
variables).

[brat-url]: https://brat.nlplab.org/index.html
