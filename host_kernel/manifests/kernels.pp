# == Class: kernels
#
class host_kernel::kernels (
  $kernels = [],
) inherits host_kernel::params
{
  validate_array($kernels)

  # 将通用参数数组与输入的参数数组合并
  if size($kernels) != 0 {
    $kernels_total = concat($kernels, $kernel_common)
  }
  else {
    $kernels_total = $kernel_common
  }

  $kernels_total.each |$kernelvalue| {
    $each_value = split($kernelvalue, '[ ]')
    validate_array($each_value)

    $key = $each_value[0]
    $value  = $each_value[1]

    host_kernel::kernel { "$key":
      key   => $key,
      value => $value,
      filepath => $kernel_path,
    }
  }

}
