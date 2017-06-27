# NOTE: change interface on machine
# NOTE: also change hosts file templates

ipaddr=$(ifconfig eth1 | awk '/inet addr/{split($2,a,":"); print a[2]}')

sudo mkdir /conf
cp -r /vagrant/gluster /conf/gluster

sudo sed -i -r /`hostname`/'s/[0-9\.]+/127.0.0.1/' /conf/gluster/hosts
sudo sed -i s/address/"$ipaddr"/ /conf/gluster/docker-compose.yml

cd /conf/gluster
sudo docker-compose up -d

docker exec gluster_gluster_1 mkdir /brick/gv0

if [ "$(hostname)" = "node3" ]; then
	docker exec gluster_gluster_1 gluster peer probe node1
	docker exec gluster_gluster_1 gluster peer probe node2

	docker exec gluster_gluster_1 gluster volume create gv0 replica 3 \
		node1:/brick/gv0 \
		node2:/brick/gv0 \
		node3:/brick/gv0

	docker exec gluster_gluster_1 gluster volume start gv0
	docker exec gluster_gluster_1 gluster volume set gv0 nfs.disable off
fi

# cd /conf/gluster
# sudo docker-compose down

# sudo rm -rf /conf
# sudo rm -rf /brick/gv0

# sudo rm -rf /etc/glusterfs
# sudo rm -rf /var/lib/glusterd
# sudo rm -rf /var/log/glusterfs