#!/usr/bin/env bash

## Only run for precise64
[[ -z `uname -a | grep precise64` ]] && echo "Error: This is not precise." && exit 1 || echo "Provisioning for Precise64..."

apt-get update

## Idempotently check for presence of and install a package
check_and_install () {
    if [[ ! -x `which $1` ]] ; then
        echo "Installing $1..."
        apt-get install $1 -y
    else
        echo "$1 already installed, skipping."
    fi
}

if [[ ! -x `which apt-add-repository` ]] ; then
    echo "Installing apt-add-repository..."
    sudo apt-get install python-software-properties -y
fi

if [[ -z `emacs --version | grep "Emacs 24"` ]] ; then
    echo "Installing emacs 24..."
    apt-add-repository ppa:cassou/emacs
    apt-get update
    apt-get install emacs24 -y
fi

check_and_install curl


check_and_install git
check_and_install tmux
check_and_install zsh

