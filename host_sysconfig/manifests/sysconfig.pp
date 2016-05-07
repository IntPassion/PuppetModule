class host_baseline::sysconfig
{


  file {
    clock:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => 'u=rw,go=r',
    path   => "/etc/sysconfig/clock",
    source => "puppet:///modules/$module_name/clock"
  }

  file {
    i18n:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => 'u=rw,go=r',
    path   => "/etc/sysconfig/i18n",
    source => "puppet:///modules/$module_name/i18n"
  }

}
