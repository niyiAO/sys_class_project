sudo apt-get -y update

sudo apt-get install -y xfsprogs
sudo mkfs.xfs /dev/vdb

sudo mkdir /app

echo -e '/dev/vdb\t/app\tauto' |sudo tee -a /etc/fstab
sudo mount -a
