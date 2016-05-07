class host_pkgandsvc (
  $pkglist   = [],
  $startlist = [],
  $stoplist  = [],
){

  include baseline::sysconfig
  #include baseline::kernel
  include baseline::security
  include baseline::packages
  include baseline::service
  include baseline::others
}
