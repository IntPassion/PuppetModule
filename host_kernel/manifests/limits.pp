# == Class: limits
#
class host_kernel::limits (
  $limits = [],
) inherits host_kernel::params
{
  validate_array($limits)

  # 将通用参数数组与输入的参数数组合并
  if size($limits) != 0 {
    $limits_total = concat($limits, $limits_common)
  }
  else {
    $limits_total = $limits_common
  }

  $limits_total.each |$limitvalue| {
    $each_value = split($limitvalue, '[ ]')
    validate_array($each_value)

    $domain = $each_value[0]
    $type   = $each_value[1]
    $item   = $each_value[2]
    $value  = $each_value[3]

    host_kernel::limit { "CLASS-${type}-${item}":
      domain => $domain,
      type   => $type,
      item   => $item,
      value  => $value
    }
  }

}
