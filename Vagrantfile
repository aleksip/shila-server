# -*- mode: ruby -*-
# vi: set ft=ruby :
Encoding.default_external = "utf-8"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
  end

  config.vm.define "shila", autostart: false do |shila|
    shila.vm.box = "debian/jessie64"
    shila.vm.hostname = 'shila.vm'
    shila.vm.network :private_network, ip: '192.168.33.10'
    shila.vm.synced_folder "shila", "/vagrant", nfs: true
    # $ vagrant plugin install vagrant-bindfs
    shila.bindfs.bind_folder \
      "/vagrant/instances/shila-dev/data/drupal-files", \
      "/vagrant/instances/shila-dev/data/drupal-files", \
      u: "33", g: "33", after: :provision
    shila.vm.provision :shell, :path => "shila/provisioning/bootstrap-host.sh"
    shila.vm.provision :shell, :path => "shila/provisioning/bootstrap-code.sh", privileged: false
    shila.vm.provision :shell, :path => "shila/provisioning/bootstrap-data.sh", privileged: false
  end

end
