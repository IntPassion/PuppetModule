class host_sysconfig (
  $sysconfig = {},

){
  #include baseline::kernel
  #include baseline::others

  # 配置系统system-auth, passw
  include host_sysconfig::system-auth

  # 配置系统基本参数
  Class {'host_sysconfig::sysconfig':

  }
  # 配置系统安全参数
  Class {'host_sysconfig::security':
    logindefs
  }
}
