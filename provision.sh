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
cd 

# Instalación de Git
sudo apt update && sudo apt install -y git

# Clonar el repositorio de la aplicación
git clone https://github.com/cameronmcnz/rock-paper-scissors.git

# Entrar en el directorio de la aplicación
cd rock-paper-scissors

# Cambiar de rama
git checkout patch-1

# Modificacion del archivo pom.xml
sudo bash -c 'cat > pom.xml' <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mcnz.rps.web</groupId>
  <artifactId>roshambo</artifactId>
  <version>1.0</version>
  <packaging>war</packaging>
  <name>roshambo web application</name>
  <url>http://www.mcnz.com</url>
  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.7</maven.compiler.source>
    <maven.compiler.target>1.7</maven.compiler.target>
  </properties>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.11</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <build>
    <finalName>roshambo</finalName>
    <pluginManagement><!-- lock down plugins versions to avoid using Maven defaults (may be moved to parent pom) -->
       	<plugins>
        	<plugin>
            		<groupId>org.apache.tomcat.maven</groupId>
            		<artifactId>tomcat7-maven-plugin</artifactId>
            		<version>2.2</version>
            		<configuration>
                		<url>http://localhost:8080/manager/text</url>
                		<server>Tomcat</server>
                		<path>/rps</path>
            		</configuration>
        	</plugin>
   	 </plugins>
    </pluginManagement>
  </build>
</project>
EOF

# Despliegue de la aplicacion
mvn tomcat7:deploy

# Reinicio del servicio Tomcat para aplicar cambios
sudo systemctl restart tomcat9

# Comprobación del estado del servicio Tomcat
sudo systemctl enable tomcat9
sudo systemctl start tomcat9
sudo systemctl status tomcat9