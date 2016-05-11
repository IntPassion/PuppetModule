# == Define: kernel
#
define host_kernel::kernel (
  $key   = undef,
  $value = undef,
  $filepath = undef,
)
{
  validate_string($key)
  validate_string($value)
  validate_absolute_path($filepath)

  sysctl::value { "${key}":
    target => $filepath,
    value  => $value,
  }
}
