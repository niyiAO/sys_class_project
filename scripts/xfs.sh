sudo apt-get -y update

sudo apt-get install -y xfsprogs
sudo mkfs.xfs /dev/vdb

echo -e '/dev/vdb\t/var/lib/docker\tauto' |sudo tee -a /etc/fstab
sudo mount -a