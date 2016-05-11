class host_sysconfig::sysconfig(
  $clock = $host_sysconfig::params::clock_common,
  $i18n  = $host_sysconfig::params::i18n_common,
  $inittab = $host_sysconfig::params::inittab_common,
  $selinux = $host_sysconfig::params::selinux_common,
  $logrotate = $host_sysconfig::params::logrotate_common,
) inherits host_sysconfig::params
{
  #$selinux = $host_sysconfig::parmas::selinux,
  validate_string($clock)
  validate_string($i18n)
  validate_string($inittab)
  validate_string($selinux)

  shellvar { "ZONE":
    ensure => present,
    #target => $clock_path,
    target => "/etc/sysconfig/clock",
    value  => $clock,
    quoted => "double",
  }

  shellvar { "LANG":
    ensure => present,
    target => $i18n_path,
    value  =>  $i18n,
    quoted => "double",
  }

  # 安全配置-修改默认运行级别
  file {
    inittab:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    path    => "/etc/inittab",
    content => template('host_sysconfig/inittab.erb')
  }

  # 安全配置-禁用control+alt+delete重启
  file { 'control-alt-delete':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    name   => "/etc/init/control-alt-delete.conf",
    source => "puppet:///modules/$module_name/control-alt-delete.conf"
  }

  # 安全配置-禁用SELINUX
  augeas { $selinux_path :
    context   => "/files${selinux_path}",
    changes   => [
      "set SELINUX ${selinux}",
    ],
  }

  # 安全配置-修改日志转储时间
  augeas { $logrotate_path :
    context   => "/files${logrotate_path}",
    changes   => [
      "set rotate ${logrotate}",
    ],
  }

  # 安全配置-cron和at允许列表
  file { cron_allow:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    path => "/etc/cron.allow",
    content => "root",
  }

  file { at_allow:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    path => "/etc/at.allow",
    content => 'root',
  }

  file { cron_deny:
    path => "/etc/cron.deny",
    ensure => "absent",
  }

  file { at_deny:
    path => "/etc/at.deny",
    ensure => "absent",
  }
}
