class host_sysconfig::system_auth
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

}
