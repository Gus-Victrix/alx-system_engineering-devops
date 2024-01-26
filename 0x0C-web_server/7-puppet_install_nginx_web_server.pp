#!/usr/bin/puppet
# Using pp to do all previous tasks

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
fileline { 'nginx':
  ensure => 'present',
  path   => '/etc/nginx/nginx.conf',
  line   => 'server_names_hash_bucket_size 64;',
}

# Creating redirect
fileline { 'redirect':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me https://youtube.com permanent;',
}

# Creating custom 404
fileline {'404':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'error_page 404 /404.html;',
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
  require => Package['nginx'],
}
