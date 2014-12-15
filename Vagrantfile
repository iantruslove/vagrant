# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box              = "precise64"
  config.ssh.forward_agent   = true
  config.vbguest.auto_update = true

  config.vm.provision :ansible do |ansible|
    ansible.verbose = 'v'
    ansible.playbook = 'provisioning/main.yml'
    ansible.raw_ssh_args = ["-o UserKnownHostsFile=/dev/null", "-o ForwardAgent=yes"]
  end
  
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
  end

  # Forward some ports for web servers
  config.vm.network :forwarded_port, guest: 80, host: 10080, auto_correct: true
  config.vm.network :forwarded_port, guest: 8080, host: 18080, auto_correct: true
end
