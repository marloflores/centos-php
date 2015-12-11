# Install stuff in composer.json
# This script should only run on first vagrant up
if [ -f "$ran_scripts/composer" ]; then
	return 0
fi

cd /vagrant/site/

/usr/local/bin/composer clear-cache
/usr/local/bin/composer install --prefer-dist

touch $ran_scripts/composer