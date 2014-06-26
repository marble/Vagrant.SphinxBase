# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian-720-x32"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-73-i386-virtualbox-puppet.box"
  # Keep the default Vagrant directory sync
  config.vm.synced_folder ".", "/vagrant", disabled: false
  # Keep downloaded Debian packages
  config.vm.synced_folder "tmp/var-cache-apt-archives", "/var/cache/apt/archives", create: true

  config.vm.provision "shell", path: "provision.sh"
end
