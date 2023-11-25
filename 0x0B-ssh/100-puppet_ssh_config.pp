# Setting up config files for ssh

file_line { 'AddingPrivateKey' :
    path => '/etc/ssh/ssh_config',
    line => '

