#!/usr/bin/puppet
#This manifest creates a file named school in /tmp

file { '/tmp/school':
    ensure  => 'present',
    mode    => '0744',
    content => 'I love Puppet',
    owner   => 'www-data',
    group   => 'www-data',
}
