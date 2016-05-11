class host_sysconfig::security(
  $logindefs = [],
  $sshdconfig = [],
  $auditdconfig = [],
  $syslog = [],
) inherits host_sysconfig::params
{

  # 安全配置-口令过期检查
  if size($logindefs) == 0 {
    $logindefs_total = $logindefs_common
  }
  else {
    $logindefs_total = concat($logindefs_common, $logindefs)
  }

  $logindefs_total.each |$logindef| {
    $key = split($logindef, '[ ]')[0]
    $value = split($logindef, '[ ]')[1]

    augeas { "${host_sysconfig::params::login_path}@$key" :
      context   => "/files${host_sysconfig::params::login_path}",
      changes   => [
        "set ${key} $value",
      ],
    }
  }

  # 安全配置-ssh配置文件
  if size($sshdconfig) == 0 {
    $sshdconfig_total = $sshdconfig_common
  }
  else {
    $sshdconfig_total = concat($sshdconfig_common, $sshdconfig)
  }

  $sshdconfig_total.each |$sshdconfig| {
    $key = split($sshdconfig, '[ ]')[0]
    $value = split($sshdconfig, '[ ]')[1]
    augeas { $key:
      context   => "/files${host_sysconfig::params::sshdconfig_path}",
      changes   => [
        "set $key $value",
      ],
    }
  }


  # 安全配置-auditd日志配置
  if size($auditdconfig) == 0 {
    $auditdconfig_total = $auditdconfig_common
  }
  else {
    $auditdconfig_total = concat($auditdconfig_common, $auditdconfig)
  }

  $auditdconfig_total.each |$auditdconfig| {
    $key = split($auditdconfig, '[=]')[0]
    $value = split($auditdconfig, '[=]')[1]

    augeas { $key:
      context   => "/files${host_sysconfig::params::auditdconfig_path}",
      changes   => [
        "set $key $value",
      ],
    }
  }

  # 安全配置-syslog日志配置
  if size($syslog) == 0 {
    $syslog_total = $syslog_common
  }
  else {
    $syslog_total = concat($syslog_common, $syslog)
  }

  $syslog_total.each |$eachsyslog| {
    $key = split($eachsyslog, '[=]')[0]
    $value = split($eachsyslog, '[=]')[1]

    augeas { $key:
      context   => "/files${host_sysconfig::params::syslog_path}",
      changes   => [
        "set $key $value",
      ],
    }
  }

  # 安全配置-内核模块的装载于卸载
  file {
    audit_rules:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    path => "/etc/audit/audit.rules",
    source => "puppet:///modules/$module_name/audit.rules",
  }
}
