# This script installs flask from pip3

package { 'python3':
	ensure  => installed,
}

package { 'pip3':
	ensure => installed,
	require => Package['python3'],
}

package { 'Flask':
    ensure   => '2.1.0',
    provider => 'pip3',
	require  => Package['pip3'],
}

