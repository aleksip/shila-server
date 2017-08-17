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
    shila.vm.box = "ubuntu/xenial64"
    shila.vm.hostname = 'shila.vm'
    shila.vm.network :private_network, ip: '192.168.33.10'
    # shila.vbguest.auto_update = false

    # Disable default mount
    shila.vm.synced_folder ".", "/vagrant", disabled: true

    # Provisioning folder
    if Vagrant::Util::Platform.windows? then
      shila.vm.synced_folder "shila/provisioning", "/shila-provisioning", type: "smb"
    else
      shila.vm.synced_folder "shila/provisioning", "/shila-provisioning", nfs: true, \
        :mount_options => ['nolock,vers=3,udp,noatime,actimeo=1']
    end

    # Instances folder
    if Vagrant::Util::Platform.windows? then
      shila.vm.synced_folder "shila/instances", "/shila-instances", type: "smb"
    else
      shila.vm.synced_folder "shila/instances", "/shila-instances", nfs: true, \
        :mount_options => ['nolock,vers=3,udp,noatime,actimeo=1']
    end

    # bindfs remount
    shila.bindfs.bind_folder \
      "/shila-instances/shila-dev/data/drupal-files", "/shila-instances/shila-dev/data/drupal-files", \
      u: "33", g: "33", after: :provision

    shila.vm.provision :shell, :path => "shila/provisioning/shila-dev/bootstrap-privileged.sh"
    shila.vm.provision :shell, :path => "shila/provisioning/shila-dev/bootstrap-unprivileged.sh", privileged: false
    shila.vm.provision :shell, :path => "shila/provisioning/shila-dev/start-services.sh", run: "always"
  end

end
