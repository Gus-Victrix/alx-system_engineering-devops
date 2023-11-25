# install_flask.pp

package { 'python3-pip':
  ensure => installed,
}

package { 'Werkzeug':
  ensure   => '2.0.2',  # Adjust the version as needed
  provider => 'pip3',
  require  => Package['python3-pip'],
}

package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  require  => Package['Werkzeug'],
}
