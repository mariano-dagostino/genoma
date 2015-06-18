# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "genoma-centos"

  config.vm.box_url = "../centos65-x86_64-20140116.box"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.71.10"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Set this variable to true to enable NFS synced folders.
  use_nfs = false

  # Share an additional folder to the guest VM.
  config.vm.synced_folder "./shared", "/vagrant", :nfs => use_nfs
  config.vm.synced_folder "./ansible", "/provisioning", :nfs => use_nfs

  config.vm.provider "virtualbox" do |vb|
      # Change memory:
      vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # If you have ansible installed on your machine, uncomment the following three
  # lines to provision the machine using "vagrant provision".
  #config.vm.provision "ansible" do |ansible|
  #  ansible.playbook = "ansible/ansible.yml"
  #end

  # If you don't have ansible installed or if you want to run ansible only in
  # the guest machine run the following commands:
  # vagrant up
  # vagrant ssh
  # /provisioning/run
end
