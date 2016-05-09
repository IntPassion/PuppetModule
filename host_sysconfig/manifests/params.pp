class host_sysconfig::params {

  $nologin_users = ['bin','daemon','adm','lp','sync','shutdown','halt','mail','uucp',
                    'operator','games','gopher','ftp','nobody','dbus','vcsa','rpc',
                    'abrt','hadlaemon','ntp','saslauth','postfix','avahi','rpcuser',
                    'nfsnobody','sshd','tcpdump','oprofile','hpsmh']


  case $::osfamily {
    'RedHat': {
      $clock = "Asia/Shanghai"
      $clock_path = "/etc/sysconfig/clock"

      $i18n = 'en_US.UTF-8'
      $i18n_path = '/etc/sysconfig/i18n'

      $inittab = '3'
      $inittab_path = "/etc/inittab"

      $logindefs_common = ['PASS_MAX_DAYS 90',
                'PASS_WARN_AGE 10',
                'PASS_MIN_LEN 12',
              ]
      $login_path = '/etc/login.defs'

      $logrotate = '12'
      $logrotate_path = '/etc/logrotate.conf'

      $selinux = 'disabled'
      $selinux_path   = '/etc/selinux/config'

      $sshdconfig_common = [
        'Protocol 2',
        'LogLevel INFO',
        'X11Forwarding no',
        'MaxAuthTries 6 ',
        'IgnoreRhosts yes',
        'HostbasedAuthentication no',
        'PermitEmptyPasswords no',
        'PermitUserEnvironment no',
      ]
      $sshdconfig_path = '/etc/ssh/sshd_config'

      $auditdconfig_common = [
        'space_left_action=SYSLOG',
        'max_log_file_action=ROTATE',
        'max_log_file=100',
        'num_logs=5',
      ]
      $auditdconfig_path = '/etc/audit/auditd.conf'

      $syslog_common = [
        'active=yes',
        'args=LOG_DEBUG LOG_LOCAL1',
      ]
      $syslog_path = '/etc/audisp/plugins.d/syslog.conf'
    }

    default : {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
