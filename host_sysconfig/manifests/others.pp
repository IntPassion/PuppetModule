class host_sysconfig::others (
  $logserver = undef,
) inherits host_sysconfig::params
{
  if $logserver {
    validate_ip_address($logserver)
    $logserver_ip = $logserver
  }

  file {
    rsyslog_conf:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    path    => "/etc/rsyslog.conf",
    content => template('host_sysconfig/rsyslog.erb')
    notify  => Service['rsyslog'],
  }

  service {
    rsyslog:
    name   => 'rsyslog',
    ensure => 'running',
  }

  # 其他-禁用ipv6
  file {
    ipv6_config:
    ensure  => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    path    => '/etc/modprobe.d/ipv6.conf',
    content => 'options ipv6 disable=1',
  }

  # 检查rhosts信任关系文件. 删除rhosts、netrc文件并清空hosts.equiv文件
  exec {
    del_rhosts:
    command => "find / -name '.rhosts' -exec rm -rf {} \;",
    path => ["/usr/bin", "/usr/sbin", "/bin"],
  }

  exec {
    del_netrc:
    command => "find / -name '.netrc' -exec rm -rf {} \;",
    path => ["/usr/bin", "/usr/sbin", "/bin"],
  }

  file {
    host_equiv:
    ensure  => present,
    path    => '/etc/hosts.equiv',
    content => '',
  }

  # 其他-配置kdump
  class { 'kdump':
    enable => true,
    config_overrides => $kdump_config,
  }

  kernel_parameter { 'crashkernel':
    ensure => present,
    value  => $crashkernel,
    bootmode => 'default',
    target => '/etc/grub.conf',
  }
  kernel_parameter { 'transparent_hugepage':
    ensure => present,
    value  => 'never',
    bootmode => 'default',
    target => '/etc/grub.conf',
  }

  # 其他-修改并注释rhsmd中的内容
  file {
    rhsmd:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
    path   => "/etc/cron.daily/rhsmd",
    source => "puppet:///modules/$module_name/rhsmd",
  }
}
