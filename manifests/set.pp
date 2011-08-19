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
