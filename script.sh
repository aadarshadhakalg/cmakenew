#! /bin/bash 

sudo apt install wget 
wget https://raw.githubusercontent.com/aadarshadhakalg/cmakenew/master/downloads/linux/cmakenew 
sudo mkdir /opt/cmakenew  
sudo mv cmakenew /opt/cmakenew/cmakenew 
sudo chmod +x /opt/cmakenew/cmakenew 
echo 'export PATH="/opt/cmakenew/:$PATH"' >> $HOME/.bashrc 
source $HOME/.bashrc



