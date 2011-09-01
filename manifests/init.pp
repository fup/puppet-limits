# Class: limits
#
# Description
#  This class is designed to manage values for limits.conf by creating a file-fragment
#  pattern and assembling into a product that can be used by the system.
#
# Parameters:
#   This class takes no parameters. 
#
# Actions:
#   Configures defined limits.conf entries using the file fragment [http://projects.puppetlabs.com/projects/puppet/wiki/Generating_a_config_file_from_fragments]
#
# Requires:
#   - This module has no requirements.
#
# Sample Usage:
#   This class is controlled using a custom definition limits::set. See that module for usage information. 
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