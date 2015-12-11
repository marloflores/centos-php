export ran_scripts=/.provisioning-stuff
if [ ! -d "$ran_scripts" ]; then
	mkdir "$ran_scripts"
	chown -R vagrant:vagrant "$ran_scripts"
fi

current_dir="/vagrant/shell"
source "$current_dir/firewall.sh"
source "$current_dir/packages.sh"
source "$current_dir/mcrypt.sh"

source "$current_dir/unpriviliged/bootstrap.sh"
exit 0