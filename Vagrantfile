# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box              = 'trusty64'
  config.vm.box_url          = 'http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
  config.ssh.forward_agent   = true
  config.vbguest.auto_update = true

  config.vm.provision :ansible do |ansible|
    ansible.verbose = 'vvv'
    ansible.playbook = 'provisioning/main.yml'
    ansible.raw_ssh_args = ["-o UserKnownHostsFile=/dev/null", "-o ForwardAgent=yes"]
  end
  
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "1"]
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
  end

  # Forward some ports for web servers
  config.vm.network :forwarded_port, guest: 80, host: 10080, auto_correct: true
  config.vm.network :forwarded_port, guest: 8080, host: 18080, auto_correct: true
end
