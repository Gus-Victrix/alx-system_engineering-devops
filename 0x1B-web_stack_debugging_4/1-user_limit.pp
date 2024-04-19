# Possible to login with the holberton user and open a file without any error message.

# Hard file increase
exec { 'hard-file-increase':
  command => 'sed -i "/holberton hard/s/5/50000/" /etc/security/limits.conf',
  path    => '/usr/local/bin/:/bin/'
}

# Soft file increase
exec { 'soft-file-increase':
  command => 'sed -i "/holberton soft/s/4/50000/" /etc/security/limits.conf',
  path    => '/usr/local/bin/:/bin/'
}
