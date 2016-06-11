# Prepare the machine
apt-get -y update
apt-get install -y curl

# Installing Node
curl -sL https://deb.nodesource.com/setup | sudo bash -
apt-get install -y nodejs-legacy
apt-get install -y nodejs
apt-get install -y npm

# Install Java
#apt-get install default-jdk
apt-get install oracle-java8-installer

# Install pip to manage Python
sudo apt install python-pip


