#!/bin/bash
CUDA_VERSION="10.2"
CUDA_DEB_FILE="cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb"

apt update
apt-get install linux-headers-$(uname -r)
mkdir /opt/Nvidia-Downloads
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin -O /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/${CUDA_DEB_FILE} -P /opt/Nvidia-Downloads
dpkg -i /opt/Nvidia-Downloads/${CUDA_DEB_FILE}
apt-key add /var/cuda-repo-10-2-local-10.2.89-440.33.01/7fa2af80.pub
apt-get update
apt-get -y install cuda
echo "export PATH=/usr/local/cuda-10.2/bin${PATH:+:${PATH}}" > /etc/profile.d/cuda.sh
chmod +x /etc/profile.d/cuda.sh
/usr/bin/nvidia-persistenced --verbose
crontab -l | { cat; echo "@reboot /usr/bin/nvidia-persistenced --verbose"; } | crontab -
