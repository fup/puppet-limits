# Defintion: limits::set 
#
# Description
#   Used to create a new limit setting on a system. This is part of the file-fragment pattern.
#   NOTE: Due to an overlap in namespace, the 'namevar' for this defintiion cannot be used 
#   as a unique identifier. Please reference 'Sample Usage' for more information.
# Parameters:
#   $domain - The domain the limit scope covers. See limits.conf(5) for more info.
#   $type - The type of limit that is being set. See limits.conf(5) for more info.
#   $item - What item this limit is being applied to. See limits.conf(5) for more info.
#   $value - The value of the limit. See limits.conf(5) for more info.
# Actions:
#   This definition creates a File Fragment that will be assembled by Class limits. 
# Requires:
#   - Class: limits
# Sample Usage:
#   limits::set {'global-hard':
#     domain => '*',
#     type   => 'hard',
#     item   => 'all',
#     value  => '0',
#   }
#   limits::set {'global-soft':
#     domain => '*',
#     type   => 'soft',
#     item   => 'all',
#     value  => '0',
#   }
define limits::set (
  $domain,
  $type, 
  $item,
  $value
) {
  include limits

  file { "/tmp/${limits::params::ls_tmp_dir}/fragment/${name}":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => "${domain}\t${type}\t${item}\t${value}\n",
    notify  => Exec['rebuild-limits.conf'],
  }
}
