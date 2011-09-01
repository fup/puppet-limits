# Class: 
#
# Description
#
# Parameters:
#   
# Actions:
#
# Requires:
#
# Sample Usage:
#

class limits {
  include limits::params
 
  File {
    owner => 'root',
    group => 'root',
    mode  => '0600',
  }
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  file { "/tmp/${limits::params::ls_tmp_dir}": 
    ensure  => 'directory',
  }
  file { "/tmp/${limits::params::ls_tmp_dir}/fragment":
    ensure  => 'directory',
    purge   => 'true',
    recurse => 'true',
    notify  => Exec['rebuild-limits.conf'],
  }
  file { "/tmp/${limits::params::ls_tmp_dir}/fragment/00_header":
    ensure => 'file',
    source => 'puppet:///modules/limits/header',
  }
  exec { 'rebuild-limits.conf':
    command     => "cat * > /tmp/${limits::params::ls_tmp_dir}/${limits::params::ls_output_file}",
    cwd         => "/tmp/${limits::params::ls_tmp_dir}/fragment",
    refreshonly => true,
  }
  file { "/etc/security/limits.d/${limits::params::ls_output_file}":
    ensure  => 'file',
    mode    => '0644',
    source  => "/tmp/${limits::params::ls_tmp_dir}/${limits::params::ls_output_file}",
    require => Exec['rebuild-limits.conf'],
  }
}
