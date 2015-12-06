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
}

class vhost { 
	$php_fragment = "LoadModule php5_module	modules/libphp5.so\nAddHandler php5-script	.php\n\nDirectoryIndex index.html index.php\nAddType text/html	.php\nAddType application/x-httpd-php-source phps"
	
	apache::vhost { 'centos.dev':
		servername		=> 'centos.dev',
		port			=> '80',
		docroot			=> '/vagrant/site',
		docroot_owner	=> 'apache',
		docroot_group	=> 'apache',
		custom_fragment	=> $php_fragment,
	}
}

include vhost
include apache
include php
include composer
include mysql

