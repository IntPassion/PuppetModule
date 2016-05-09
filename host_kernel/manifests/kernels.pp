# == Class: kernels
#
# == Notice ==
# kernel参数配置的路径统一在params中记录，不提供用户输入
class host_kernel::kernels (
  $kernels = [],
) inherits host_kernel::params
{
  # 校验输入参数类型
  validate_array($kernels)

  # 将默认参数与输入的参数合并
  if size($kernels) != 0 {
    $kernels_total = concat($kernels, $kernel_common)
  }
  else {
    $kernels_total = $kernel_common
  }

  # 遍历合并后的kernel数组，定义kernel类型
  $kernels_total.each |$kernelvalue| {
    # 将值按照空格分割为数组
    $each_value = split($kernelvalue, '[ ]')
    validate_array($each_value)
    # 数组值赋值给变量
    $key = $each_value[0]
    $value  = $each_value[1]
    # 声明kernel类型
    # 文件路径采用params中保存的默认路径
    host_kernel::kernel { "$key":
      key   => $key,
      value => $value,
      filepath => $kernel_path,
    }
  }

}
