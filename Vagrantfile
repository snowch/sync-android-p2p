# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

    config.vm.box = "phusion/ubuntu-14.04-amd64"

    # Only run provisioning on first 'vagrant up'
    if Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/default/*/id").empty?
        # Install Docker
        pkg_cmd = "wget -q -O - https://get.docker.io/gpg | apt-key add -;" \
            "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list;" \
            "apt-get update -qq; apt-get install -q -y --force-yes lxc-docker; "
        # Add vagrant user to the docker group
        pkg_cmd << "usermod -a -G docker vagrant; "
        pkg_cmd << "sed -i '/^#DOCKER_OPTS=.*$/a DOCKER_OPTS=\"-H tcp://localhost:2375\"' /etc/default/docker; "
        pkg_cmd << "service docker restart; "
        config.vm.provision :shell, :inline => pkg_cmd
    end

    # Only run provisioning on first 'vagrant up'
    if Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/default/*/id").empty?
        # Install JDK
        pkg_cmd = "apt-get update -qq; apt-get install -q -y --force-yes openjdk-7-jdk; "
        # Download latest gradle
        pkg_cmd << "sudo -u vagrant -i sh -c 'cd /vagrant; ./gradlew pullDockerCouchdb'; "
        config.vm.provision :shell, :inline => pkg_cmd
    end
end
