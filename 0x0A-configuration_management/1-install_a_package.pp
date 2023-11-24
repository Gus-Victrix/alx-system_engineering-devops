# install_flask.pp

exec { 'install_flask':
  command => 'pip3 install Flask==2.1.0',
  path    => '/usr/local/bin:/usr/bin:/bin',
  creates => '/usr/local/bin/flask',  # Adjust the path based on your system
  require => Package['python3-pip'],  # Ensure pip3 is installed first
}
