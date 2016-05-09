class host_sysconfig::sysconfig(
  $clock = $host_sysconfig::parmas::clock,
  $i18n  = $host_sysconfig::parmas::i18n,
  $inittab = $host_sysconfig::parmas::inittab,
  $selinux = $host_sysconfig::parmas::selinux,
  $logrotate = $host_sysconfig::parmas::logrotate,
) inherits host_sysconfig::params
{
  validate_string($clock)
  validate_string($i18n)
  validate_string($inittab)
  validate_string($selinux)

  validate_bool(str2bool($control_alt_delete))

  shellvar { "ZONE":
    ensure => present,
    target => $clock_path,
    value  => $clock,
    quoted => "double",
  }


  shellvar { "LANG":
    ensure => present,
    target => $lang_path,
    value  =>  $lang,
    quoted => "double",
  }

  # 安全配置-修改默认运行级别
  augeas { "inittab" :
    context   => $inittab_path,
    changes   => [
      "set runlevels ${inittab}",
    ],
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
  augeas { $host_sysconfig::params::selinux_path :
    context   => "/files${selinux_path}",
    changes   => [
      "set SELINUX ${selinux}",
    ],
  }

  # 安全配置-修改日志转储时间
  augeas { $host_sysconfig::params::logrotate_path :
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
