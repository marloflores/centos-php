class { 'php':
}

class { 'apache':
	default_vhost	=> false,
}

class vhost { 
	apache::vhost { 'centos.dev':
		servername	=> 'centos.dev',
		port		=> '80',
		docroot		=> '/vagrant/site',
#		require		=> Class['apache'],	
	}
}

include vhost
include apache
include php

