# == Define: limit
#
define host_kernel::limit (
  $domain = undef,
  $type   = undef,
  $item   = undef,
  $value  = undef,
) {
  #validate_string($limits)
  #validate_absolute_path($filepath)

  #fail($value)
  include limits
  limits::limit { "${type} ${item}":
    domain => $domain,
    type   => $type,
    item   => $item,
    value  => $value,
  }
}
