#!/usr/bin/env bash

## Only run for precise64
[[ -z `uname -a | grep precise64` ]] && echo "This is not precise" && exit 1 || echo "Provisioning for Precise64..."

#sudo apt-get update

check_and_install () {
    if [[ ! -x `which $1` ]] ; then
        echo "Installing $1..."
        sudo apt-get install $1 -y
    else
        echo "$1 already installed."
    fi
}

if [[ ! -x `which apt-add-repository` ]] ; then
    echo "Installing apt-add-repository..."
    sudo apt-get install python-software-properties -y
fi

#sudo apt-get install openjdk-6-jdk python-software-properties -y

if [[ -z `emacs --version | grep "Emacs 24"` ]] ; then
    echo "Installing emacs 24..."
    sudo apt-add-repository ppa:cassou/emacs
    sudo apt-get update
    sudo apt-get install emacs24 -y
fi

check_and_install git
check_and_install curl

if [[ ! -d ~vagrant/.emacs.d ]] ; then
    git clone https://github.com/iantruslove/.emacs.d.git ~vagrant/.emacs.d
fi

CASK=~vagrant/.cask/bin/cask

if [[ ! -x $CASK ]] ; then
    echo "Installing cask..."
    curl -fsSkL https://raw.github.com/cask/cask/master/go | python
fi

# I think cask install is pretty much idempotent...
cd ~vagrant/.emacs.d && $CASK install && cd ~vagrant


## Zsh

check_and_install zsh

if [[ ! -d ~vagrant/.oh-my-zsh ]] ; then
    git clone https://github.com/iantruslove/oh-my-zsh.git ~vagrant/.oh-my-zsh
fi
if [[ ! -e ~vagrant/.zshrc ]] ; then
    ln -s ~vagrant/.oh-my-zsh/zshrc ~vagrant/.zshrc
fi

sudo chsh -s /bin/zsh vagrant
