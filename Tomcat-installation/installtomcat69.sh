1. TOMCAT

1. Introduction:
   - Tomcat is used to deploy web applications ONLY
   - Java is the pre-requisite for Tomcat

2. Tomcat 9 Installation:
   - The following may be written as a script, when run installs Tomcat 9 plus others.
   ---------------------------------------------------------------------------------- 
   # Steps for Installing tomcat9 on rhel7&8
   # install Java JDK 1.8+ as a pre-requisit for tomcat to run.
   # https://github.com/LandmakTechnology/package-management/tree/main/Tomcat-installation
   sudo hostnamectl set-hostname tomcat
   cd /opt
   sudo yum install git wget vim -y
   sudo yum install java-1.8.0-openjdk-devel -y
   # Download tomcat software and extract it.
   # dowanload and extract tomcat software
   sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.tar.gz
   sudo tar -xvf apache-tomcat-9.0.73.tar.gz
   sudo rm apache-tomcat-9.0.73.tar.gz
   sudo mv apache-tomcat-9.0.73 tomcat9
   sudo chmod 777 -R /opt/tomcat9
   sudo sh /opt/tomcat9/bin/startup.sh
   # create a soft link to start and stop tomcat from anywhere
   # to manage tomcat as a service
   sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
   sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat
   sudo starttomcat
   echo "end on tomcat installation"
   sudo su - ec2-user

3. Starting Tomcat: Options
   - sudo starttomcat
   - sudo sh /opt/tomcat9/bin/startup.sh
   - sudo bin/catalina.sh start

4. Stopping Tomcat: Options
   - stoptomcat
   - sudo sh /opt/tomcat9/bin/shutdown.sh
   - sudo bin/catalina.sh stop

5. Verify Tomcat service/process is running:
   - ps -ef | grep tomcat  
   - curl -v localhost:8080
   - curl -v ipAddress:8080
   - Run ipAddress:8080 on the web browser 

6. Configure Tomcat:
   a. Changing the Port Number:
   - vim /opt/tomcat9/conf/server.xml
   - Locate the portion with this -
       <Connector port="8080" protocol="HTTP/1.1"
       <Host name="localhost"  appBase="webapps"
       unpackWARs="true" autoDeploy="true">    
   - You can change the port for security reasons, to any port like 8177
   - Restart tomcat by stopping and starting it again with any of the above commands
   - Then, add another inbound rule on the security group on the AWS server to open the new port
   - Verify with any of the above methods above




=======================================================================================================================================================
2. 

# Steps for Installing tomcat9 on rhel7&8
# install Java JDK 1.8+ as a pre-requisit for tomcat to run.
# https://github.com/LandmakTechnology/package-management/tree/main/Tomcat-installation
sudo hostnamectl set-hostname tomcat
cd /opt
sudo yum install git wget vim -y
sudo yum install java-1.8.0-openjdk-devel -y
# Download tomcat software and extract it.
# dowanload and extract tomcat software
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.69/bin/apache-tomcat-9.0.69.tar.gz
sudo tar -xvf apache-tomcat-9.0.69.tar.gz
sudo rm apache-tomcat-9.0.69.tar.gz
sudo mv apache-tomcat-9.0.69 tomcat9
sudo chmod 777 -R /opt/tomcat9
sudo sh /opt/tomcat9/bin/startup.sh
# create a soft link to start and stop tomcat from anywhere
# to manage tomcat as a service
sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat
sudo starttomcat
echo "end on tomcat installation"
sudo su - ec2-user
