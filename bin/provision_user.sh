#!/usr/bin/env bash

# Ensure github.com's SSH key is in known_hosts
KNOWN_HOSTS_FILE=~/.ssh/known_hosts
[[ ! -e $KNOWN_HOSTS_FILE ]] && touch $KNOWN_HOSTS_FILE
ssh-keyscan -t rsa,dsa github.com 2>&1 | sort -u - $KNOWN_HOSTS_FILE > ~/.ssh/tmp_hosts
cat ~/.ssh/tmp_hosts >> $KNOWN_HOSTS_FILE
rm ~/.ssh/tmp_hosts

# #
# # Emacs config, cask and pallet
# #
# if [[ ! -d ~vagrant/.emacs.d ]] ; then
#     git clone https://github.com/iantruslove/.emacs.d.git ~vagrant/.emacs.d
# fi

# CASK=~vagrant/.cask/bin/cask

# if [[ ! -x $CASK ]] ; then
#     echo "Installing cask..."
#     # Note the $HOME override - this script is not run as the vagrant user...
#     curl -fsSkL https://raw.github.com/cask/cask/master/go | HOME=~vagrant python
# fi

# # I think cask install is close enough to idempotent...
# cd ~vagrant/.emacs.d && $CASK install && cd ~vagrant && chown -R vagrant ~vagrant/.emacs.d

#
# Dotfiles
#
##bash -c "$(wget -qO - https://raw.github.com/iantruslove/.dotfiles/master/bin/dotfiles)" && source ~/.bashrc
git clone https://github.com/iantruslove/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git checkout DoC
bash -c "$(cat ~/.dotfiles/bin/dotfiles)" && source ~/.bashrc
