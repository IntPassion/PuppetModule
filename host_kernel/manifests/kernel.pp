# == Define: kernel
#
define host_kernel::kernel (
  $key   = undef,
  $value = undef,
  $filepath = undef,
)
{
  # 校验输入参数类型
  validate_string($key)
  validate_string($value)
  validate_absolute_path($filepath)

  # 调用sysctl模块中value实现内核参数配置
  sysctl::value { "${key}":
    target => $filepath,
    value  => $value,
  }
}
