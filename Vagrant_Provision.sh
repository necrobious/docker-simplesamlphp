#!/bin/bash

apt-get update -y
apt-get install -y docker.io
ln -sf /usr/bin/docker.io /usr/local/bin/docker
sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io

sudo docker build -t necrobious/simplesamlphp /vagrant/.
sudo docker run -d -p 58080:80 -p 58443:443 necrobious/simplesamlphp
