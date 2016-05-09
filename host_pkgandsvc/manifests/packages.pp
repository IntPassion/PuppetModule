define host_pkgandsvc::packages(
  $pkglist = [],
)
{
  validate_array($pkglist)

  package {
    $pkglist:
    ensure => installed,
    allow_virtual => false,
    #require => Class["baseline::yum_http"],
    before => Class["host_pkgandsvc::packages::openssl"],
  }

}

class host_pkgandsvc::packages::openssl
{
  file { openssl:
    path   => '/tmp/openssl/',
    ensure => directory,
    source => "puppet:///modules/host_pkgandsvc/openssl/rhel6.7/",
    recurse => true,
    before => Package["openssl-static-1.0.1e-42.el6.x86_64"],
  }

  package { "openssl-static-1.0.1e-42.el6.x86_64":
    ensure => present,
    provider => rpm,
    allow_virtual => false,
    source => "/tmp/openssl/openssl-static-1.0.1e-42.el6.x86_64.rpm",
  }
}
