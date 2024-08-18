Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/focal64"
    config.vm.provision "shell", inline: <<-SHELL
        apt update
        apt -y upgrade
    SHELL
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = "2"
    end

    config.vm.define "main_node", primary: true do |main_node|
        main_node.vm.network "private_network", ip: "192.168.56.11"
    end

    config.vm.define "worker_1" do |worker_1|
        worker_1.vm.network "private_network", ip: "192.168.56.12"
    end

    config.vm.define "worker_2" do |worker_2|
        worker_2.vm.network "private_network", ip: "192.168.56.13"
    end
end

