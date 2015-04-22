# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box_url = "https://github.com/kraksoft/vagrant-box-ubuntu/releases/download/14.10/ubuntu-14.10-amd64.box"
  config.vm.box = "ubuntu14.10"
  config.vm.network :private_network, ip: "192.168.33.100"
  config.vm.network :forwarded_port, id: "ssh", guest: 22, host: 2223
  config.vm.synced_folder ".", "/vagrant", :mount_options => ['dmode=775', 'fmode=664']
  config.vm.hostname = "dev"
  config.vm.provision :shell, :path => "./provision.sh"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024]
  end
end

