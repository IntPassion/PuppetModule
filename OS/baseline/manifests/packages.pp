class baseline::packages(
) inherits baseline::params 
{

  package {
    $packageslist:
    ensure => installed,
    allow_virtual => false,
    #require => Class["baseline::yum_http"],
    before => Class["baseline::packages::openssl"],
  }

  include baseline::packages::openssl
}

class baseline::packages::openssl
{
  file { openssl:
    path   => '/tmp/openssl/',
    ensure => directory,
    source => "puppet:///modules/baseline/openssl/rhel6.7/",
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
