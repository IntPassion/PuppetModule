class host_baseline::service(
) inherits baseline::params
{
  service {
    $servicelist_start:
    ensure  => running,
    enable  => true,
    require => Class["baseline::packages"],
  }

  service {
    $servicelist_stop:
    ensure  => stopped,
    enable  => false,
    require => Class["baseline::packages"],
  }
}
