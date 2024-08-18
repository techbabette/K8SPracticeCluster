Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/focal64"
    config.vm.provision "shell", inline: <<-SHELL
        apt update
        apt -y upgrade
    SHELL

    config.vm.provision :ansible do |ansible|
        ansible.limit = "all"
        ansible.playbook = "Playbooks/install_docker_daemon.yml"
    end

    config.vm.provision "ansible" do |ansible|
        ansible.limit = "all"
        ansible.playbook = "Playbooks/instal_cri_dockerd.yml"
    end
    
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = "2"
    end

    config.vm.define "main_node", primary: true do |main_node|
        main_node.vm.network "private_network", ip: "192.168.56.11"
    end
end

