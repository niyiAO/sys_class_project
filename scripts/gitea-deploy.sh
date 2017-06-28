
ipaddr=$(ifconfig eth1 | awk '/inet addr/{split($2,a,":"); print a[2]}')

sudo apt-get install -y glusterfs-client
sudo mkdir /app

sed -r /g`hostname`/'s/[0-9\.]+/172.18.0.2/' /vagrant/gluster/hosts |sudo tee -a /etc/hosts
sudo mount -t glusterfs g`hostname`:/gv0 /app

sudo cp -r /vagrant/gitea /conf/gitea
sudo sed -i s/address/"$ipaddr"/ /conf/gitea/docker-compose.yml
cd /conf/gitea
docker-compose up -d