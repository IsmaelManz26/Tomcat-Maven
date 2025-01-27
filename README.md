# Tomcat-Maven

## Descripción

Este proyecto demuestra cómo desplegar aplicaciones web en Apache Tomcat utilizando Maven. Incluye configuraciones para desplegar, volver a desplegar y eliminar aplicaciones web en un servidor Tomcat.

---

## Estructura del Proyecto

```
.gitattributes
.vagrant/
  bundler/
  global.sol
  machines/
    default/
      virtualbox/
        action_provision
        action_set_name
        box_meta
        creator_uid
        id
        index_uuid
        private_key
        ...
        rgloader/
          loader.rb
capturas/
  context.xml
  pom1.xml
  pom2.xml
  provision.sh
  README.md
  settings.xml
  tomcat-users.xml
tomcat-war/
  pom.xml
  target/
    maven-archiver/
      pom.properties
  tomcat-war-deployment/
    META-INF/
    WEB-INF/
      classes/
  tomcat-war-deployment.war
  tomcat1.war
Vagrantfile
```

---

## Despliegue

Para desplegar la aplicación, utiliza los siguientes comandos de Maven:

```sh
mvn tomcat7:deploy
mvn tomcat7:redeploy
mvn tomcat7:undeploy
```

Después de ejecutar estos comandos, deberías ver un mensaje de `BUILD SUCCESS`.

---

## Capturas de Pantalla

### Página Principal (localhost)

![localhost](../capturas/locaclhost.png)

### Manager

![manager](../capturas/manager.png)

### Host Manager

![host-manager](../capturas/host-manager.png)

### Aplicación tomcat1war

![tomcat1war](../capturas/tomcat1war.png)

### Aplicación Despliegue

![despliegue](../capturas/despliegue.png)

### Aplicación RPS

![rps](../capturas/rps.png)

---

## Configuración de Usuarios de Tomcat

El archivo `tomcat-users.xml` contiene la configuración de usuarios y roles necesarios para acceder a las interfaces de administración de Tomcat:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xsi:schemaLocation="http://www.apache.org/xml tomcat-users.xsd"
               version="1.0">
  <role rolename="admin"/>
  <role rolename="admin-gui"/>
  <role rolename="manager"/>
  <role rolename="manager-gui"/>
  <user username="alumno"
        password="1234"
        roles="admin,admin-gui,manager,manager-gui"/>
  <user username="deploy" password="1234" roles="manager-script"/>
</tomcat-users>
```

---

## Configuración de Maven

El archivo `pom.xml` contiene la configuración del plugin de Maven para Tomcat:

```xml
<build>
  <finalName>tomcat-war-deployment</finalName>
  <plugins>
    <plugin>
      <groupId>org.apache.tomcat.maven</groupId>
      <artifactId>tomcat7-maven-plugin</artifactId>
      <version>2.2</version>
      <configuration>
        <url>http://localhost:8080/manager/text</url>
        <server>Tomcat</server>
        <path>/despliegue</path>
      </configuration>
    </plugin>
  </plugins>
</build>
```

---

## Vagrant

El archivo `Vagrantfile` contiene la configuración para provisionar una máquina virtual con Tomcat y Maven instalados:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt update && sudo apt upgrade -y
    sudo apt-get install -y tomcat9 tomcat9-admin maven 
    sudo cp /vagrant/tomcat-users.xml /etc/tomcat9/tomcat-users.xml
    sudo cp /vagrant/context.xml /usr/share/tomcat9-admin/host-manager/META-INF/context.xml
    sudo cp /vagrant/settings.xml /etc/maven/settings.xml
  SHELL
  config.vm.provision "shell", path: "provision.sh"
end
