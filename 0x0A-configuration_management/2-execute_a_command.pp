#!/usr/bin/puppet
# Executes a kill command on process killmenow

exec { 'pkill killmenow':
    command => '/usr/bin/pkill killmenow',
}
