# == Class: limits
#
# == Notice ==
# limit参数配置的路径统一在params中记录，不提供用户输入。
# 同时，limits::limit模块中默认使用/etc/security/limits.conf文件，也不支持自定义文件

class host_kernel::limits (
  $limits = [],
) inherits host_kernel::params
{
  # 校验输出参数的类型
  validate_array($limits)

  # 将默认参数与输入的参数合并
  if size($limits) != 0 {
    $limits_total = concat($limits, $limits_common)
  }
  else {
    $limits_total = $limits_common
  }

  # 遍历合并后的limit数组，定义limit类型
  $limits_total.each |$limitvalue| {
    # 将值按照空格分割为数组
    $each_value = split($limitvalue, '[ ]')
    validate_array($each_value)
    # 数组值赋值给变量
    $domain = $each_value[0]
    $type   = $each_value[1]
    $item   = $each_value[2]
    $value  = $each_value[3]
    # 声明limit类型
    host_kernel::limit { "CLASS-${type}-${item}":
      domain => $domain,
      type   => $type,
      item   => $item,
      value  => $value
    }
  }

}
