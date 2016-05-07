# == Define: kernel
#
define host_kernel::kernel (
  $kernels = {},
)
{
  validate_hash($kernel)

  $kernel_common = {
    'net.ipv4.tcp_syncookies'      => '1',
    'net.ipv4.tcp_max_syn_backlog' => '4096',
    'net.ipv4.tcp_fin_timeout'     => '30',
    'net.ipv4.tcp_synack_retries'  => '3',
  }

  if size($kernel) != 0 {
    $kernel_total = merge($kernels, $kernel_common)
  }
  else {
    $kernel_total = $kernel_common
  }

  $filepath = $::osfamily ? {
    'RedHat' => '/etc/sysctl.conf',
    default  => '',
  }

  if $filepath == '' {
    fail("The Type[kernel] is not supported
          on an ${::osfamily} based system.")
  }

  $kernel_total.each |$key, $value| {
    if ! defined( File_line["${key}"] ) {
      file_line { "${key}":
        path => $filepath,
        line => "${key} = ${value}",
      }
    }
  }
}
