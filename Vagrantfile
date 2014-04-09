# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

provisioner = {
  cookbooks: "cookbooks",
  roles: "roles",
  databags: "data_bags"
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #config.vm.provision :shell, :inline => "C:/Windows/System32/sysprep/sysprep.exe /generalize /reboot /quiet"

  config.vm.define "sql" do |sql|
    sql.vm.box = "win2k8"
    sql.vm.guest = :windows
    sql.windows.halt_timeout = 30
    sql.winrm.username = "vagrant"
    sql.winrm.password = "vagrant"
    sql.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
      v.gui = true
    end

    sql.vm.network :private_network, ip: "192.168.56.10"
    sql.vm.network :forwarded_port, guest: 3389, host: 33389
    sql.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true

    if Vagrant.has_plugin?("vagrant-cachier")
      sql.cache.auto_detect = true
    end

    sql.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = provisioner[:cookbooks]
      chef.roles_path = provisioner[:roles]
      chef.data_bags_path = provisioner[:databags]
      #chef.arguments = '-l debug'
      chef.run_list = [
#        "recipe[sharepoint::sql_server]",
        "recipe[sharepoint::prerequisites]"
      ]
      chef.json = {
      }
    end
  end

  config.vm.define "sharepoint" do |sharepoint|
    sharepoint.vm.box = "win2k8"
    sharepoint.vm.guest = :windows
    sharepoint.windows.halt_timeout = 30
    sharepoint.winrm.username = "Administrator"
    sharepoint.winrm.password = "vagrant"
    sharepoint.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
      v.gui = true
    end
    
    sharepoint.vm.network :private_network, ip: "192.168.56.11"
    sharepoint.vm.network :forwarded_port, guest: 3389, host: 43389
    sharepoint.vm.network :forwarded_port, guest: 5985, host: 45985, id: "winrm", auto_correct: true

    if Vagrant.has_plugin?("vagrant-cachier")
      sharepoint.cache.auto_detect = true
    end

    sharepoint.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = provisioner[:cookbooks]
      chef.roles_path = provisioner[:roles]
      chef.data_bags_path = provisioner[:databags]
      chef.arguments = '-l debug'
      chef.run_list = [
        "recipe[sharepoint::default]"
      ]
      chef.json = {
      }
    end
  end

end
