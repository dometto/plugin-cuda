#!/bin/bash
  
apt update
apt-get install linux-headers-$(uname -r)
mkdir /opt/Nvidia-Downloads
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin -O /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.1.1/local_installers/cuda-repo-ubuntu1804-11-1-local_11.1.1-455.32.00-1_amd64.deb -P /opt/Nvidia-Downloads
dpkg -i /opt/Nvidia-Downloads/cuda-repo-ubuntu1804-11-1-local_11.1.1-455.32.00-1_amd64.deb
apt-key add /var/cuda-repo-ubuntu1804-11-1-local/7fa2af80.pub
apt-get update
apt-get -y install cuda
echo "export PATH=/usr/local/cuda-11.1/bin${PATH:+:${PATH}}" > /etc/profile.d/cuda.sh
chmod +x /etc/profile.d/cuda.sh
/usr/bin/nvidia-persistenced --verbose
crontab -l | { cat; echo "@reboot /usr/bin/nvidia-persistenced --verbose"; } | crontab -
