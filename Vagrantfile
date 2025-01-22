Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  config.vm.box = "debian/bullseye64"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.provision "shell", inline: <<-SHELL
    # Copiar el archivo de configuración de usuarios y permisos a la ubicación de Tomcat
    sudo cp /vagrant/tomcat-users.xml /etc/tomcat9/tomcat-users.xml

    # Copiar el archivo de configuración de context.xml a la ubicación de Tomcat
    sudo cp /vagrant/context.xml /usr/share/tomcat9-admin/host-manager/META-INF/context.xml

    # Copiar el archivo de configuración de settings.xml a la ubicación de Maven
    sudo cp /vagrant/settings.xml /etc/maven/settings.xml

  SHELL
  config.vm.provision "shell", path: "provision.sh"
end