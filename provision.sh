# Actualización de los paquetes disponibles
sudo apt update && sudo apt upgrade -y

# Instalación de OpenJDK 11, Tomcat 9 y Tomcat 9 Admin
sudo apt install -y openjdk-11-jdk tomcat9 tomcat9-admin

# Instalación de Maven
sudo apt-get update && sudo apt-get -y install maven

# Creación del grupo para Tomcat
sudo groupadd tomcat9 || true

# Creación del usuario para Tomcat
sudo useradd -s /bin/false -g tomcat9 -d /etc/tomcat9 tomcat9 || true

# Reinicio del servicio Tomcat para aplicar cambios
sudo systemctl restart tomcat9

# Creación de un proyecto Maven
mvn archetype:generate -DgroupId=org.zaidinvergeles -DartifactId=tomcat-war -Ddeployment -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false

# Crear la carpeta del proyecto si no existe
mkdir -p /vagrant/tomcat-war

# Copiar el archivo pom1.xml al directorio del proyecto
sudo cp /vagrant/pom1.xml /vagrant/tomcat-war/pom.xml

# Entrar en el directorio del proyecto
cd /vagrant/tomcat-war

# Despliegue de la aplicacion
mvn tomcat7:deploy

# Volver a la carpeta raíz
cd /

# Instalación de Git
sudo apt update && sudo apt install -y git

# Clonar el repositorio de la aplicación
git clone https://github.com/cameronmcnz/rock-paper-scissors.git

# Entrar en el directorio de la aplicación
cd rock-paper-scissors

# Cambiar de rama
git checkout patch-1

# Copiamos el archivo pom2.xml
sudo cp /vagrant/pom2.xml pom.xml

# Despliegue de la aplicacion
mvn tomcat7:deploy

# Reinicio del servicio Tomcat para aplicar cambios
sudo systemctl restart tomcat9

# Comprobación del estado del servicio Tomcat
sudo systemctl enable tomcat9
sudo systemctl start tomcat9
sudo systemctl status tomcat9