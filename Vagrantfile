# -*- mode: ruby -*-
# vi: set ft=ruby :
Encoding.default_external = "utf-8"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 3072

    # Don't create ubuntu-bionic-18.04-cloudimg-console.log file
    vb.customize ["modifyvm", :id, "--uartmode1", "disconnected"]
  end

  config.vm.define "shila" do |shila|
    shila.vm.box = "ubuntu/bionic64"
    shila.vm.hostname = 'shila.vm'
    shila.vm.network :private_network, ip: '192.168.33.10'
    # shila.vbguest.auto_update = false

    # Disable default mount
    shila.vm.synced_folder ".", "/vagrant", disabled: true

    # Provisioning folder
    if Vagrant::Util::Platform.windows? then
      shila.vm.synced_folder "provisioning", "/shila-provisioning", type: "smb"
    else
      shila.vm.synced_folder "provisioning", "/shila-provisioning", nfs: true, \
        :mount_options => ['nolock,vers=3,udp,noatime,actimeo=1']
    end

    # Instances folder
    if Vagrant::Util::Platform.windows? then
      shila.vm.synced_folder "instances", "/shila-instances", type: "smb"
    else
      shila.vm.synced_folder "instances", "/shila-instances", nfs: true, \
        :mount_options => ['nolock,vers=3,udp,noatime,actimeo=1']
    end

    # bindfs remount
    shila.bindfs.bind_folder \
      "/shila-instances/shila/data/drupal-files", "/shila-instances/shila/data/drupal-files", \
      u: "33", g: "33", after: :provision

    shila.vm.provision :shell, :path => "provisioning/shila/bootstrap-privileged.sh"
    shila.vm.provision :shell, :path => "provisioning/shila/bootstrap-unprivileged.sh", privileged: false
    shila.vm.provision :shell, :path => "provisioning/shila/start-services.sh", run: "always"
  end

end
