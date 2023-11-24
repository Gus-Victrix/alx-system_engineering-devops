#This manifest creates a file named school in /tmp


file { '/tmp/school':
    ensure      => 'file',
    owner   => 'www-data',
    group   => 'www-data',
  path       => '/tmp/school',
mode    => '0755'
    content => 'I love Puppet',
}
