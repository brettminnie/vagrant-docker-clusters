BOX_IMAGE = "ubuntu/bionic64"
PRIVATE_IP = "10.0.0.2"
bootstrap_target = ENV["BOOTSTRAP_TARGET"] || "REDIS"
rabbitmq_cluster_cookie = ENV["RABBITMQ_CLUSTER_COOKIE"] || "cluster_cookie"
rabbitmq_admin_user = ENV["RABBITMQ_ADMIN_USER"] || "admin"
rabbitmq_admin_password = ENV["RABBITMQ_ADMIN_PASSWORD"] || "admin"

Vagrant.configure("2") do |config|
  config.vm.box = BOX_IMAGE
  config.vm.box_check_update = false
  config.vm.synced_folder ".data/", "/data", create: true
  config.vm.provider "virtualbox" do |l|
    l.cpus = 4
    l.memory = "8192"
  end

  # Port forwards for Redis
  config.vm.network "forwarded_port", guest: 6379, host: 6379 if bootstrap_target != "RABBITMQ" and bootstrap_target != "MYSQL"

  # Port forwards for RabbitMQ
  config.vm.network "forwarded_port", guest: 5672, host: 5672 if bootstrap_target == "RABBITMQ"
  config.vm.network "forwarded_port", guest: 1936, host: 1936 if bootstrap_target == "RABBITMQ"
  config.vm.network "forwarded_port", guest: 15672, host: 15672 if bootstrap_target == "RABBITMQ"

  # Port forwards for mysql
  config.vm.network "forwarded_port", guest: 3306, host: 3306 if bootstrap_target == "MYSQL"
  config.vm.network "forwarded_port", guest: 8080, host: 8080 if bootstrap_target == "MYSQL"

  config.vm.define "clusterhost" do |host|
    host.vm.hostname = "clusterhost"
    host.vm.network :private_network, ip: PRIVATE_IP
    host.vm.provision "file", source: "./scripts/", destination: "/home/vagrant/"
    host.vm.provision "file", source: "./ansible/", destination: "/home/vagrant/"
        host.vm.provision :shell, inline: <<-SHELL
        chmod +x /home/vagrant/scripts/*;
    SHELL
    host.vm.provision "shell", path: "scripts/bootstrap.sh", env: {
        "BOOTSTRAP_TARGET" => bootstrap_target,
        "RABBITMQ_CLUSTER_COOKIE" => rabbitmq_cluster_cookie,
        "RABBITMQ_ADMIN_USER" => rabbitmq_admin_user,
        "RABBITMQ_ADMIN_PASSWORD" => rabbitmq_admin_password
    }
  end


end
