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
        config.vm.provision "install_docker", type: "ansible" do |ansible|
            ansible.playbook = "Playbooks/install_docker_daemon.yml"
        end
    
        config.vm.provision "install_cri", type: "ansible" do |ansible|
            ansible.playbook = "Playbooks/instal_cri_dockerd.yml"
        end
    
        config.vm.provision "install_kubernetes", type: "ansible" do |ansible|
            ansible.playbook = "Playbooks/install_kubernetes.yml"
        end

        main_node.vm.provision "ansible" do |ansible|
            ansible.playbook = "Playbooks/initialize_cluster.yml"
        end

        main_node.vm.provision "ansible" do |ansible|
            ansible.playbook = "Playbooks/install_flannel.yml"
        end
    end

    config.vm.define "worker_1" do |worker_1|
        worker_1.vm.network "private_network", ip: "192.168.56.12"
        worker_1.vm.hostname = "worker1"
        config.vm.provision "install_docker", type: "ansible" do |ansible|
            ansible.playbook = "Playbooks/install_docker_daemon.yml"
        end
    
        config.vm.provision "install_cri", type: "ansible" do |ansible|
            ansible.playbook = "Playbooks/instal_cri_dockerd.yml"
        end
    
        config.vm.provision "install_kubernetes", type: "ansible" do |ansible|
            ansible.playbook = "Playbooks/install_kubernetes.yml"
        end
    end
end

