class host_kernel (
  $kernellist = {},
  $limitlist  = {},
) 
{
  validate_array($limitlist)
  validate_array($kernellist)

  Class { 'host_kernel::kernels':
    kernels => $kernellist,
  }

  Class { 'host_kernel::limits':
    limits => $limitlist,
  }
}
