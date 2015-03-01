# Vagrant Dev VM

How many Vagrant VMs must I set up before I realize I should automate it?  NO MORE!

## Installation

1. Prerequisites:
  * [Vagrant](http://www.vagrantup.com/)
  * vagrant-vbguest
  * Ansible
2. `vagrant up && vagrant ssh`
3. There is no step 3.

## What does it do?

* Creates a virtual machine, using the official Precise 64-bit Ubuntu Linux base image
* As root:
  * Installs Emacs 24, git, tmux, a headless install of Oracle Java 7, Leiningen
* As the vagrant user:
  * Installs my emacs config, and my neato self-bootstrapping bashrc (totally stolen from @cowboy)

