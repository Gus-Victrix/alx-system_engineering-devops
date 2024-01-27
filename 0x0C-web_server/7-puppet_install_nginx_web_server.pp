#!/usr/bin/puppet
# Using pp to do all previous tasks

# Installing the puppet stdlib module for access to file_line
exec { 'install_stdlib':
  command => '/usr/bin/puppet module install puppetlabs-stdlib',
  unless  => '/usr/bin/puppet module list | grep -q stdlib',
}

# Updating apt cache
exec { 'apt-update':
  command     => '/usr/bin/apt-get update',
  refreshonly => true,
}

# Installing nginx
package { 'nginx':
  ensure  => installed,
  require => Exec['apt-update'],
  provider => 'apt',
}

# Creating index.html
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
}

# Creating 404.html
file { '/var/www/html/404.html':
  ensure  => file,
  content => 'Ceci n\'est pas une page',
}

# Modifying default nginx config
exec { 'modifying_default':
 command => '/usr/bin/sed -i \'s/root \/var\/www\/html;/root \/var\/www\/html;\n\trewrite ^\/redirect_me https:\/\/youtube.com permanent;\n\terror_page 404 \/404.html;/\' /etc/nginx/sites-available/default',
 require => Package['nginx'],
}

# Letting nginx through firewall
exec { 'ufw-nginx':
  command => '/usr/sbin/ufw allow \'Nginx HTTP\'',
  unless  => '/usr/sbin/ufw status | grep \'Nginx HTTP\'',
}

# Restarting firewall
exec { 'ufw-restart':
  command     => '/usr/sbin/ufw restart',
  refreshonly => true,
}

# Making sure nginx is running
service { 'nginx_service':
  ensure  => running,
  require => Package['nginx'],
}
