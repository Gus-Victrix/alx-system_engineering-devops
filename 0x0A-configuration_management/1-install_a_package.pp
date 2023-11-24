# In the 'python' class
$python_pkg = $operatingsystem ? {
  ubuntu => 'python3',
  default => 'python3',  # Defaulting to python3 for non-specified systems
}

package { $python_pkg:
  ensure => installed,
}

# In the 'python3-pip' class
$python_pip_pkg = $operatingsystem ? {
  ubuntu => 'python3-pip',
  default => 'python3-pip',  # Defaulting to python3-pip for non-specified systems
}

package { $python_pip_pkg:
  ensure  => installed,
  require => Package[$python_pkg],
}

# In the 'flask' class
$flask_version = '2.1.0'

exec { "install_flask_${flask_version}":
  command => "/usr/bin/pip3 install Flask==${flask_version}",
  creates => '/usr/local/bin/flask',  # Adjust the path based on your system
  require => Package[$python_pip_pkg],
}
