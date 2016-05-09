class host_pkgandsvc (
  $pkglist   = [],
  $startlist = [],
  $stoplist  = [],
) inherits host_pkgandsvc::params
{
  # 校验输出参数类型
  validate_array($pkglist)
  validate_array($startlist)
  validate_array($stoplist)

  # 将默认参数与输入的参数合并
  if size($pkglist) != 0 {
    $packages_total = concat($pkglist, $packageslist)
  }
  else {
    $packages_total = $packageslist
  }

  if size($startlist) != 0 {
    $svclist_start = concat($startlist, $servicelist_start)
  }
  else {
    $svclist_start = $servicelist_start
  }

  if size($stoplist) != 0 {
    $svclist_stop = concat($stoplist, $servicelist_stop)
  }
  else {
    $svclist_stop = $servicelist_stop
  }

  # 声明package和service类
  host_pkgandsvc::packages { 'install_pkg':
    pkglist => $packages_total,
  } ->
  host_pkgandsvc::services { 'startservice':
    svclist => $svctlist_start,
    type    => 'start',
    ensure  => running,
    enable  => true,
    #require => packages['install_pkg'],
  } -> 
  host_pkgandsvc::services { 'stopservice':
    svclist => $svclist_stop,
    type    => 'stop',
    ensure  => stopped,
    enable  => false,
    #require => packages['install_pkg'],
  }

  include host_pkgandsvc::packages::openssl
}
