#!/usr/bin/puppet

#This manifest creates a file named school in /tmp

file { '/tmp/school':
    mode    => '0744',
    content => "I love Puppet\n",
    owner   => 'www-data',
    group   => 'www-data',
}
