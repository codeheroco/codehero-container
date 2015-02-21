# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.4.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty32"

  # install guest additions
  # config.vbguest.auto_update = true

  # network
  config.vm.network :public_network, :bridge => 'en0: Wi-Fi (AirPort)'
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.ssh.forward_agent = true

  # VM settigns
  config.vm.provider :virtualbox do |vb|
    vb.name = "codehero-server"
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  # Upload scripts and nginx configuration
  config.vm.provision "file", source: "nginx", destination: "/tmp/nginx"
  config.vm.provision "file", source: "build-script.sh", destination: "/tmp/build-script.sh"
  config.vm.provision "file", source: "crontab-script.sh", destination: "/tmp/crontab-script.sh"

  # provision the VM
  config.vm.provision "shell", path: "install_deps.sh"
  config.vm.provision "shell", path: "server_config.sh"
  config.vm.provision "shell", inline: "/bin/su - codehero -c /home/codehero/build-script.sh"

end
