# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.ssh.forward_agent = true

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80,    host: 8080
  config.vm.network "forwarded_port", guest: 3306,  host: 33306

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.44.10", hostsupdater: 'skip'

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  # config.vm.synced_folder('----localfolder-----', '/home/vagrant/code', :nfs => true)
  # config.vm.synced_folder '.', '/home/vagrant/code', nfs: true
  config.vm.synced_folder '.', '/home/vagrant/code', group: "www-data", owner: "www-data"

  # OMS QRAVED
  config.vm.synced_folder "../imaginato_oms_oc_platform", "/var/www/imaginato_oms_oc_platform", type: "rsync", rsync__exclude: ['.git/', '.idea/'], owner: "www-data", group: "www-data"
  config.vm.synced_folder "../imaginato_oms_qraved", "/var/www/imaginato_oms_qraved", type: "rsync", rsync__exclude: ['.git/', '.idea/'], owner: "www-data", group: "www-data"

  # ROOANG
  config.vm.synced_folder "../imaginato_rooang_oc", "/var/www/imaginato_rooang_oc", type: "rsync", rsync__exclude: ['.git/', '.idea/', 'image/cache/', 'system/storage/'], owner: "www-data", group: "www-data"

  # QRAVED
  config.vm.synced_folder "../imaginato_oc_platform", "/var/www/oc_platform", type: "rsync", rsync__exclude: ['.git/', '.idea/', 'image/cache/', 'system/storage/'], owner: "www-data", group: "www-data"
  config.vm.synced_folder "../imaginato_qraved", "/var/www/qraved", type: "rsync", rsync__exclude: ['.git/', '.idea/', 'image/cache/', 'system/storage/'], owner: "www-data", group: "www-data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |v|
    # Don't boot with headless mode
    v.gui = false

    # Use VBoxManage to customize the VM. For example to change memory:
    v.customize ["modifyvm", :id, "--memory",               "1024"]
    v.customize ["modifyvm", :id, "--cpus",                 "1"]
    v.customize ["modifyvm", :id, "--cpuexecutioncap",      "95"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1",  "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1",         "on"]
  end

  # Fix for: "stdin: is not a tty"
  # https://github.com/mitchellh/vagrant/issues/1673#issuecomment-28288042
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # Shell provisioning
  # Install base packages
  config.vm.provision "shell" do |s|
    s.path = "provision/provision.sh"
  end

  config.vm.boot_timeout = 180
end
