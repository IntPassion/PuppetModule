class host_baseline::others (
) inherits baseline::params
{
  file {
    rsyslog_conf:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    path   => "/etc/rsyslog.conf",
    source => "puppet:///modules/$module_name/rsyslog.conf",
    notify => Service['rsyslog'],
  }

  service {
    rsyslog:
    name   => 'rsyslog',
    ensure => 'running',
  }

  file {
    ipv6_config:
    ensure  => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    path    => '/etc/modprobe.d/ipv6.conf',
    content => 'options ipv6 disable=1',
  }

  exec {
    del_rhosts:
    command => "find / -name '.rhosts' -print",
    path => ["/usr/bin", "/usr/sbin", "/bin"],
  }

  exec {
    del_netrc:
    command => "find / -name '.netrc' -print",
    path => ["/usr/bin", "/usr/sbin", "/bin"],
  }

  file {
    host_equiv:
    ensure  => present,
    path    => '/etc/hosts.equiv',
    content => '',
  }

  class { 'kdump':
    enable => true,
    config_overrides => {
      'path' => '/var/crash',
      'core_collector' => 'makedumpfile -c -d 31',
      'default' => 'shell',
    }
  }

  $crashkernel = $::virtual ? {
    'vmware'   => '128M',
    'physical' => '768M',
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

class baseline::others::kdump_vmware {
  exec {
    kdump_vmware:
    command => "grep '^crashkernel' /etc/grub.conf || echo crashkernel=128M >> /etc/grub.conf",
    path => ["/usr/bin", "/usr/sbin", "/bin"],
  }
}

class baseline::others::kdump_physical {
  exec {
    kdump_physical:
    command => "grep '^crashkernel' /etc/grub.conf || echo crashkernel=768M >> /etc/grub.conf",
    path => ["/usr/bin", "/usr/sbin", "/bin"],
  }
}
