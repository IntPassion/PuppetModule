# == Class: account
#
# Puppet account management
#
# === Authors
#
# IntPassion
#

class account(
    $users    = {},
    $groups   = {},
) inherits account::params
{
    validate_hash($users)
    validate_hash($groups)
  
    create_resources(account::group, $groups)
    create_resources(account::user, $users)
}
