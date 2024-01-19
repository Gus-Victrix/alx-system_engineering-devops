#!/usr/bin/puppet
# install_flask.pp

package { 'python3-pip':
  ensure   => installed,
  provider => apt,
  update   => true,
}

package { 'Werkzeug':
  ensure   => '2.0.2',  # Adjust the version as needed
  provider => 'pip3',
  require  => Package['python3-pip'],
  update   => true,
}

package { 'Jinja2':
  ensure   => '3.0.1',
  provider => 'pip3',
  require  => Package['Werkzeug'],
  update   => true,
}

package { 'itsdangerous':
  ensure   => '2.0.1',
  provider => 'pip3',
  require  => Package['Werkzeug'],
  update   => true,
}

package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  require  => Package['Werkzeug'],
  update   => true,
}
