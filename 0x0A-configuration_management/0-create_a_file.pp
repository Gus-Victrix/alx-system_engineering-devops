#!/usr/bin/puppet

#This manifest creates a file named school in /tmp

file { '/tmp/school':
    mode    => '0755'
    content => 'I love Puppet',
    owner   => 'www-data',
    group   => 'www-data',
}
