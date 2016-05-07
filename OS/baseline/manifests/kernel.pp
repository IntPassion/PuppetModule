class baseline::sysconfig (
  $kernel = {},
) {
  file {
    sysctl:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => 'u=rw',
    name => "/etc/sysctl.conf",
    content => template('baseline/sysctl.erb'),
  }


}
