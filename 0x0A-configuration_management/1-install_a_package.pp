#!/usr/bin/puppet
# install flask version

package { 'python3':
  ensure   => 'latest',
  provider => 'apt',
}

package { 'python3-pip':
  ensure   => 'latest',
  require  => Package['python3'],
  provider => 'apt',
}

package { 'werkzeug':
  ensure   => '2.1.1',
  provider => 'pip3',
  require  => Package['python3-pip'],
}
package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  require  => Package['python3-pip'],
}
