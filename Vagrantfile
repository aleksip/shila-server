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

    # Provisioning folder
    shila.vm.synced_folder "shila/provisioning", "/vagrant", nfs: true, \
      :mount_options => ['nolock,vers=3,udp,noatime,actimeo=1']

    # Instances folder
    shila.vm.synced_folder "shila/instances", "/shila-vagrant", nfs: true, \
      :mount_options => ['nolock,vers=3,udp,noatime,actimeo=1']

    # bindfs remount
    # $ vagrant plugin install vagrant-bindfs
    shila.bindfs.bind_folder \
      "/shila-vagrant/shila-dev/data/drupal-files", "/shila-vagrant/shila-dev/data/drupal-files", \
      u: "33", g: "33", after: :provision

    shila.vm.provision :shell, :path => "shila/provisioning/bootstrap-privileged.sh"
    shila.vm.provision :shell, :path => "shila/provisioning/bootstrap-unprivileged.sh", privileged: false
    shila.vm.provision :shell, :path => "shila/provisioning/start-services.sh", run: "always"
  end

end
