# == Define: limit
#
define host_kernel::limit (
  $domain = undef,
  $type   = undef,
  $item   = undef,
  $value  = undef,
) {
  # 校验输出参数类型
  validate_string($domain)
  validate_string($type)
  validate_string($item)
  validate_string($value)

  # 输入的参数不可空，否则报错退出
  if ! $domain or ! $type or ! $item or ! $value {
    fail("Input params [domain|type|item|value] can not be none.")
  }
  # 声明limit类型
  include limits
  limits::limit { "${type}@${item}":
    domain => $domain,
    type   => $type,
    item   => $item,
    value  => $value,
  }
}
