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
package { 'nginx-extras':
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

# Preventing hash bucket memory problems
file_line { 'hash_bucket':
  ensure => 'present',
  path   => '/etc/nginx/nginx.conf',
  line   => 'server_names_hash_bucket_size 64;',
  require => Exec['install_stdlib'],
}

# Creating redirect
file_line { 'redirect':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me https://youtube.com permanent;',
  require => Exec['install_stdlib'],
}

# Creating custom 404
file_line {'404':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen [::]:80 default_server',
  line   => 'error_page 404 /404.html;',
  require => Exec['install_stdlib'],
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
  require     => Exec['ufw-nginx'],
}

# Making sure nginx is running
service { 'nginx':
  ensure  => running,
  require => Package['nginx-extras'],
}
