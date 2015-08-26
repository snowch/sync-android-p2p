# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

    config.vm.box = "zyga/ubuntu-precise-desktop-i386"

    config.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", 1024]
      vb.customize ["modifyvm", :id, "--vram", 64]
      vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    end

    # Automatically use local apt-cacher-ng if available
    if File.exists? "/etc/apt-cacher-ng"
      # If apt-cacher-ng is installed on this machine then just use it.
      require 'socket'
      guessed_address = Socket.ip_address_list.detect{|intf| !intf.ipv4_loopback?}
      if guessed_address
        config.vm.provision :shell, :inline => "echo 'Acquire::http { Proxy \"http://#{guessed_address.ip_address}:3142\"; };' > /etc/apt/apt.conf.d/00proxy"
      end
    end

    # Update to have the latest packages, remove if you don't need that
    config.vm.provision :shell, :inline => "apt-get update"
    config.vm.provision :shell, :inline => "DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade --yes"
end
