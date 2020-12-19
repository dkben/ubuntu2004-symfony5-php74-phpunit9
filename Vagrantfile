Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.network "forwarded_port", guest: 80, host: 11000
  config.vm.synced_folder ".", "/var/www/html", owner: "www-data", group: "www-data"
  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.hostname = "dkben-ubuntu-20.04"
end