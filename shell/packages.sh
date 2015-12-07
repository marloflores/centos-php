# This script should only run on first vagrant up
if [ -f "$ran_scripts/packages" ]; then
	return 0
fi
# install man
echo "Installing man..."
yum install man -y
echo "Package man installed"

touch "$ran_scripts/packages"