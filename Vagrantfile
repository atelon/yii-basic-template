# -*- mode: ruby -*-
# vi: set ft=ruby :

# Path to vagrant prefences
vagrant_folder = File.dirname(__FILE__) + '/vagrant'
config_folder = vagrant_folder + '/config'
provisions_folder = vagrant_folder + '/provisions'
utils_folder = vagrant_folder + '/utils'

curr_folder = File.dirname(__FILE__)

# Require files
require 'json'
require "#{utils_folder}/installPlugins.rb"

# Options
options = JSON.parse(File.read(config_folder + '/config.json'))

# Install plugins
installPlugins(options['BOX_PLUGINS'])

# Vagrant config
Vagrant.configure(options['API_VERSION']) do |config|

  # Box
  config.vm.box = options['BOX']

  # Update
  config.vm.box_check_update = options['CHECK_UPDATE']

  # machine name (for vagrant console)
  config.vm.define options['MACHINE_NAME']

  # machine name (for guest machine console)
  config.vm.hostname = options['MACHINE_NAME']

  # network
  config.vm.network "forwarded_port", guest: 80, host: 8080,
                                      host_ip: "127.0.0.1",
                                      id: 'apache'
  config.vm.network "forwarded_port", guest: 3306, host: 3306,
                                      host_ip: "127.0.0.1",
                                      id: 'mysql'

  # sync: folder 'yii2-template-project' (host machine) -> folder '/app' (guest machine)
  config.vm.synced_folder curr_folder, '/app', owner: 'vagrant', group: 'vagrant'

  # disable folder '/vagrant' (guest machine)
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # Sync folder '/vagrant'
  config.vm.synced_folder curr_folder, "/vagrant", type: 'virtualbox', owner: "root", group: "root"

  # VirtualBox
  config.vm.provider 'virtualbox' do |vb|
    # machine cpus count
    vb.cpus = options['VIRTUALBOX_PROVIDER']['cpus']
    # machine memory size
    vb.memory = options['VIRTUALBOX_PROVIDER']['memory']
    # machine name (for VirtualBox UI)
    vb.name = options['MACHINE_NAME']
    # linked clone
    vb.linked_clone = options['VIRTUALBOX_PROVIDER']['linked_clone']
  end

  # Provisions
  config.vm.provision "download",
    type: "shell",
    preserve_order: true,
    path: provisions_folder + "/download.sh"

  config.vm.provision "config",
    type: "shell",
    preserve_order: true,
    path: provisions_folder + "/config.sh"

end
