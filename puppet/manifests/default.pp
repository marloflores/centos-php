class project::php {
    class { 'php': }
}

::php::module { "mysql": }

class { 'composer':
  command_name => 'composer',
  target_dir   => '/usr/local/bin',
  user => 'root',
}



class mysql {

    class { '::mysql::server':
        root_password => "123",
        remove_default_accounts => true,
        override_options => {
            mysqld => {
                "bind_address"  => "0.0.0.0",
            }
        },
        databases => {
          'vagrant' => {
            ensure  => 'present',
            charset => 'utf8',
          },
        },
        users => {
          'vagrant@%' => {
            ensure          => 'present',
            password_hash   => mysql_password("vagrant"),
          },
        },
        grants => {
          'vagrant@%/vagrant.*' => {
            ensure     => 'present',
            options    => ['GRANT'],
            privileges => ['ALL'],
            table      => 'vagrant.*',
            user       => 'vagrant@%',
          },
        }
    }
}

class { 'apache':
	default_vhost	=> false,
  user => 'vagrant',
  group => 'vagrant',
}

class vhost { 
	$php_fragment = "\tLoadModule php5_module	modules/libphp5.so\n\tAddHandler php5-script	.php\n\n\tDirectoryIndex index.html index.php\n\tAddType text/html	.php\n\tAddType application/x-httpd-php-source phps\n\n\tSetEnv APP_ENV dev"
	
	apache::vhost { 'centos.dev':
		servername		=> 'centos.dev',
		port			=> '80',
		docroot			=> '/vagrant/site/public',
		docroot_owner	=> 'vagrant',
		docroot_group	=> 'vagrant',

		custom_fragment	=> $php_fragment,
	}
}

include vhost
include apache
include php
include composer
include mysql

