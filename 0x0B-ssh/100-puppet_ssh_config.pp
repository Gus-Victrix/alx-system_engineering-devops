# This file ensures certain characteristics of the ssh_config file
# Removing password login
file_line { 'RefusingPasswordLogin' :
ensure => present,
line   => 'PasswordAuthentication no',
match  => '^#?\s*PasswordAuthentication\s+(yes|no)',
path   => '/etc/ssh/ssh_config',
}

# Dealing with adding private key
file_line { 'AddingPrivateKey' :
ensure => present,
line   => 'IdentityFile ~/.ssh/school',
match  => '^#?\s*IdentityFile\s+~/.ssh/school',
path   => '/etc/ssh/ssh_config',
}
