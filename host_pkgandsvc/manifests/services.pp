define host_pkgandsvc::services(
  $svclist = [],
  $type    = undef,
  $ensure  = undef,
  $enable  = undef,
) 
{
  validate_array($svclist)
  validate_re($type, [ '^start$', '^stop$' ],
    'The $ensure parameter must be \'start\' or \'stop\'')

  service {
    $svclist:
    ensure  => $ensure,
    enable  => $enable,
  }
}
