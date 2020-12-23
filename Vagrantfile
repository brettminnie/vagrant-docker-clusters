BOX_IMAGE = "ubuntu/bionic64"
PRIVATE_IP = "10.0.0.2"
bootstrap_target = ENV["BOOTSTRAP_TARGET"] || "REDIS"

Vagrant.configure("2") do |config|
  config.vm.box = BOX_IMAGE
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |l|
    l.cpus = 4
    l.memory = "8192"
  end

  config.vm.define "dockerhost" do |dockerhost|
    dockerhost.vm.hostname = "dockerhost"
    dockerhost.vm.network :private_network, ip: PRIVATE_IP
    dockerhost.vm.provision "file", source: "./scripts/", destination: "/home/vagrant/"
    dockerhost.vm.provision "file", source: "./ansible/", destination: "/home/vagrant/"
        dockerhost.vm.provision :shell, inline: <<-SHELL
        chmod +x /home/vagrant/scripts/*;
    SHELL
    dockerhost.vm.provision "shell", path: "scripts/bootstrap.sh", env: {"BOOTSTRAP_TARGET" => bootstrap_target}
  end


end
