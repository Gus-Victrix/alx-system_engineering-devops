# This manifest creates a file named school in /tmp owned by www-data
file { '/tmp/school':
    ensure  => 'present',
    content => 'I love Puppet',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755'
}