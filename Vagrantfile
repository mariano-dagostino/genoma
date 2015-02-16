# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "../debian7-6.box"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.55.10"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM.
  config.vm.synced_folder ".", "/vagrant", :nfs => true
  
  config.vm.provider "virtualbox" do |vb|
      # Change memory:
      vb.customize ["modifyvm", :id, "--memory", "1024"]
  end


  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/ansible.yml"
  end
end
