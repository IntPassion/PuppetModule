# == Define: limit
#
define host_kernel::limit (
  $limits = []
) {
  validate_array($limits)

  $limits_common = [
    '* soft nofile 4096',
    '* hard nofile 65536',
  ]

  if size($limits) == 0 {
    $limits_total = $limits_common
  }
  else {
    $limits_total = concat($limits, $limits_common)
  }

  $filepath = $::osfamily ? {
    'RedHat' => '/etc/security/limits.conf',
    default  => '',
  }

  if $filepath == '' {
    fail("The Type[kernel] is not supported
          on an ${::osfamily} based system.")
  }

  $limits_total.each |$value| {
    if ! defined( File_line["${value}"] ) {
      file_line { "${value}":
        path => $filepath,
        line => "${value}",
      }
    }
  }

}
