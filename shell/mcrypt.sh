if [ -f "$ran_scripts/mcrypt" ]; then
	return 0
fi
# install man
echo "Installing php-mcrypt..."
yes | yum install epel-release
yum install php-mcrypt -y
echo "Packages php-mcrypt installed"

touch "$ran_scripts/mcrypt"