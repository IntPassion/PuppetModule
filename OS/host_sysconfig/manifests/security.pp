class host_baseline::security(
) inherits baseline::params
{

  file {
    system-auth-ac:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    path   => "/etc/pam.d/system-auth-ac",
    source => "puppet:///modules/$module_name/system-auth"
  }

  file {
    system-auth:
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0777',
    path    => '/etc/pam.d/system-auth',
    target  => "/etc/pam.d/system-auth-ac",
    require => File["system-auth-ac"],
  }

  file {
    password-auth-ac:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    path   => "/etc/pam.d/password-auth-ac",
    source => "puppet:///modules/$module_name/system-auth"
  }

  file {
    password-auth:
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0777',
    path    => '/etc/pam.d/password-auth',
    target  => "/etc/pam.d/password-auth-ac",
    require => File["password-auth-ac"],
  }

  file {
    login_defs:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    path   => "/etc/login.defs",
    source => "puppet:///modules/$module_name/login.defs"
  }

  file {
    logrotate:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    path   => "/etc/logrotate.conf",
    source => "puppet:///modules/$module_name/logrotate.conf"
  }

  file {
    sshd_config:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    path => "/etc/ssh/sshd_config",
    source => "puppet:///modules/$module_name/sshd_config",
  }

  file {
    inittab:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    name => "/etc/inittab",
    source => "puppet:///modules/$module_name/inittab"
  }

  file {
    control-alt-delete:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    name => "/etc/init/control-alt-delete.conf",
    source => "puppet:///modules/$module_name/control-alt-delete.conf"
  }

  file {
    limits_conf:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    name => "/etc/security/limits.conf",
    source => "puppet:///modules/$module_name/limits.conf"
  }

  file {
    selinux_config:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    name => "/etc/selinux/config",
    source => "puppet:///modules/$module_name/config"
  }

  file {
    auditd:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    path   => "/etc/audit/auditd.conf",
    source => "puppet:///modules/$module_name/auditd.conf",
  }

  file {
    audit_rules:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    path => "/etc/audit/audit.rules",
    source => "puppet:///modules/$module_name/audit.rules",
  }

  file {
    syslog:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    path => "/etc/audisp/plugins.d/syslog.conf",
    source => "puppet:///modules/$module_name/syslog.conf",
  }


  file {
    cron_allow:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    path => "/etc/cron.allow",
    content => "root",
  }

  file {
    at_allow:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    path => "/etc/at.allow",
    content => 'root',
  }

  file {
    cron_deny:
    path => "/etc/cron.deny",
    ensure => "absent",
  }

  file {
    at_deny:
    path => "/etc/at.deny",
    ensure => "absent",
  }

  user {
    $nologin_users:
    shell => '/sbin/nologin',
  }
}
