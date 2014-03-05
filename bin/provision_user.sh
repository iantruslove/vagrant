#!/usr/bin/env bash

# Ensure github.com's SSH key is in known_hosts
KNOWN_HOSTS_FILE=~/.ssh/known_hosts
[[ ! -e $KNOWN_HOSTS_FILE ]] && touch $KNOWN_HOSTS_FILE
ssh-keyscan -t rsa,dsa github.com 2>&1 | sort -u - $KNOWN_HOSTS_FILE > ~/.ssh/tmp_hosts
cat ~/.ssh/tmp_hosts >> $KNOWN_HOSTS_FILE
rm ~/.ssh/tmp_hosts

#
# Emacs config, cask and pallet
#
if [[ ! -d ~vagrant/.emacs.d ]] ; then
    git clone https://github.com/iantruslove/.emacs.d.git ~vagrant/.emacs.d
fi

CASK=~vagrant/.cask/bin/cask

if [[ ! -x $CASK ]] ; then
    echo "Installing cask..."
    # Note the $HOME override - this script is not run as the vagrant user...
    curl -fsSkL https://raw.github.com/cask/cask/master/go | HOME=~vagrant python
fi

# I think cask install is close enough to idempotent...
cd ~vagrant/.emacs.d && $CASK install && cd ~vagrant && chown -R vagrant ~vagrant/.emacs.d

#
# Zsh config
#
if [[ ! -d ~vagrant/.oh-my-zsh ]] ; then
    git clone https://github.com/iantruslove/oh-my-zsh.git ~vagrant/.oh-my-zsh
fi
if [[ ! -e ~vagrant/.zshrc ]] ; then
    ln -s ~vagrant/.oh-my-zsh/zshrc ~vagrant/.zshrc
fi

sudo chsh -s /bin/zsh vagrant

#
# Tmux (dotfiles)
#
DOTFILES_DIR=~vagrant/.dotfiles
if [[ ! -d $DOTFILES_DIR ]] ; then
    git clone https://github.com/iantruslove/.dotfiles.git $DOTFILES_DIR
fi
if [[ ! -e ~vagrant/.tmux.conf ]] ; then
    ln -s $DOTFILES_DIR/link/.tmux.conf ~vagrant/.tmux.conf
fi
