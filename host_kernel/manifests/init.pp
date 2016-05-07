class host_kernel (
  $kerneldict = {},
  $limitdict  = {},
)
{
  validate_hash($kerneldict)
  validate_hash($limitdict)

  create_resources( host_kernel::kernel, $kerneldict)
  create_resources( host_kernel::limit, $limitdict)
}
