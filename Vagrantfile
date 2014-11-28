# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"

  config.ssh.forward_agent = true
  
  # Basic provisioning is via a shell script
  config.vm.provision "shell", path: "bin/provision.sh"

  # Some userland configuration needs doing too
  config.vm.provision "shell",  path: "bin/provision_user.sh", privileged: false

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
  end

  # Forward some ports for web servers
  config.vm.network :forwarded_port, guest: 80, host: 10080, auto_correct: true
  config.vm.network :forwarded_port, guest: 8080, host: 18080, auto_correct: true
end
