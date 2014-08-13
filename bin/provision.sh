#!/usr/bin/env bash

## Only run for precise64
[[ -z `uname -a | grep precise64` ]] && echo "Error: This is not precise." && exit 1 || echo "Provisioning for Precise64..."

# It's not ideal, but this just needs to happen first
apt-get update

# Add sources for Java
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886

# Ensure apt-add-repository is available
if [[ ! -x `which apt-add-repository` ]] ; then
    echo "Installing apt-add-repository..."
    sudo apt-get install python-software-properties -y
fi

# Add PPA source for Emacs 24
apt-add-repository ppa:cassou/emacs

# Pull in all new sources' package information
apt-get update

# There's plenty of new security updates; get them!
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

## Idempotently check for presence of and install a package
check_and_install () {
    if [[ ! -x `which $1` ]] ; then
        echo "Installing $1..."
        apt-get install $1 -y
    else
        echo "$1 already installed, skipping."
    fi
}

# Install the editor
if [[ -z `emacs --version | grep "Emacs 24"` ]] ; then
    echo "Installing emacs 24..." 
    apt-get install emacs24 -y
fi

check_and_install curl
check_and_install git
check_and_install tmux
check_and_install tree
check_and_install vim
check_and_install zsh

# Install Oracle Java 7
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get install oracle-java7-installer -y

# Install Leiningen
wget https://raw.github.com/technomancy/leiningen/stable/bin/lein -O /usr/local/bin/lein
chmod a+x /usr/local/bin/lein

cat >> /etc/motd.tail <<EOF
Emacs (with emacs-live) is ready to go.
The tmux prefix key is C-z.
EOF
