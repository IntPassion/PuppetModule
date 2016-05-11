class host_sysconfig (
  $sysconfig    = {},
  $logindefs    = [],
  $sshdconfig   = [],
  $auditdconfig = [],
  $syslog       = [],
){
  # 校验输入参数类型
  validate_hash($sysconfig)
  validate_array($logindefs)
  validate_array($sshdconfig)
  validate_array($auditdconfig)
  validate_array($syslog)
  
  #include baseline::kernel
  #include baseline::others

  # 配置系统system-auth, passw
  include host_sysconfig::system_auth

  # 配置系统基本参数
  Class {'host_sysconfig::sysconfig':
    clock     => $sysconfig['clock'],
    i18n      => $sysconfig['i18n'],
    inittab   => $sysconfig['inittab'],
    selinux   => $sysconfig['selinux'],
    logrotate => $sysconfig['logrotate'],
  }
  # 配置系统安全参数
  Class {'host_sysconfig::security':
    logindefs    => $logindefs,
    sshdconfig   => $sshdconfig,
    auditdconfig => $auditdconfig,
    syslog       => $syslog,
  }
}
