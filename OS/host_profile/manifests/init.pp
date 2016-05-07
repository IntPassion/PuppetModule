class host_profile (
  $profilelist = {}
)
{
  validate_hash($profilelist)
  create_resources( host_profile::profile, $profilelist)
}
