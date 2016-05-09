# == Class: host_kernel init class
#

class host_kernel (
  $kernellist = [],
  $limitlist  = [],
)
{
  # 校验输入参数格式
  validate_array($limitlist)
  validate_array($kernellist)

  # 定义kernels类
  Class { 'host_kernel::kernels':
    kernels => $kernellist,
  }

  # 定义limits类
  Class { 'host_kernel::limits':
    limits => $limitlist,
  }
}
