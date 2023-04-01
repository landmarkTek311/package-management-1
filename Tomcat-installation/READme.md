#  **<span style="color:green">Landmark Technologies, Ontario, Canada.</span>**
### **<span style="color:green">Contacts: +1437 215 2483<br> WebSite : <http://mylandmarktech.com/></span>**
### **Email: mylandmarktech@gmail.com**



## Apache Tomcat Installation And Setup In AWS EC2 Redhat Instance.
##### Prerequisite
+ AWS Acccount.
+ Create Redhat EC2 T2.micro Instance.
+ Create Security Group and open Tomcat ports or Required ports.
   + 8080 ..etc
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+

### Install Java JDK 1.8+ 

``` sh
# install Java JDK 1.8+ as a pre-requisit for tomcat to run.
sudo hostnamectl set-hostname tomcat
cd /opt 
sudo yum install git wget vim -y
sudo yum install java-1.8.0-openjdk-devel -y
# install wget unzip packages.
sudo yum install wget unzip -y
```
## Install Tomcat version 9.0.69
### Download and extract the tomcat server
``` sh
sudo wget  https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.zip 
sudo tar -xvf apache-tomcat-9.0.73.tar.gz
sudo rm -rf apache-tomcat-9.0.73.tar.gz
### rename tomcat for good naming convention
sudo mv apache-tomcat-9.0.73 tomcat9
### assign executable permissions to the tomcat home directory
sudo chmod 777 -R /opt/tomcat9
sudo chown ec2-user -R /opt/tomcat9
### start tomcat
sh /opt/tomcat9/bin/startup.sh
# create a soft link to start and stop tomcat
# This will enable us to manage tomcat as a service
sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat
starttomcat
sudo su - ec2-user
```


=========================================================================================
Use Below Tomcat for Installation

TOMCAT

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

   b. Configure Tomcat to be accessible from external source: Currently configured for localhost access (from server)
   - vi /opt/tomcat9/webapps/manager/META-INF/context.xml
   - Locate the portion with this:
       <Valve className="org.apache.catalina.valves.RemoteAddrValve"
          allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
   - Turn this into a comment by adding <!--    --> to look like this -
       <!--
          <Valve className="org.apache.catalina.valves.RemoteAddrValve"
          allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> 
       -->
   - Save and quit

   c. Create/Add users:
   - vi /opt/tomcat9/conf/tomcat-users.xml, add users as desired with specified roles
       <user username="landmark" password="admin123" roles="manager-gui,admin-gui,manager-script"/>
       <user username="simon" password="admin123" roles="admin-gui"/> 
   - Save and quit.
   - Log in users on web browser and carry out tasks

   d. Deploying Web Apps:
   i. On the Web Browser:
   - On the web browser, Log in to the ipAddress as manager-gui and upload your .war files
   - Verify by clicking on the uploaded application and/or ipAddress:portNumber/app 
   - On CLI and server, deployed apps are found in opt/tomcat9/webapps/ directory 
   ii. From the build app (maven):
   - Command- scp -i key.pem .warFileName ec2-user@ipAddress:/opt/tomcat9/webapps/
   - In the maven web app dir, create your tomcat server keypem - vi key.pem
   - Copy the key, paste, save and quit
   - Secure by changing permission: chmod 400 key.pem
   - scp -i key.pem target/app.war ec2-user@TomcatipAddress:/opt/tomcat9/webapps/
   - Verify the deployed web app is running
       curl -v localhost:8255/tesla
       curl -v TomcatipAddress:8255/tesla 
       On the webbrowser, check TomcatipAddress:port/tesla 

