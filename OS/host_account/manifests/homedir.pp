# == Class: account::homedir
#
# Create Linux/Unix home directory
#
# === Authors
#
# IntPassion
#

define account::homedir (
    $user    = undef,
    $group   = undef,
    $mode    = $account::params::perm_homedir,
    $ensure  = $account::params::default_ensure,
)
{
    validate_re($ensure, '^(present|absent)$')
    validate_absolute_path($name)
    
    $home = $name

    if $ensure == 'absent' {
        warning("请登陆客户机终端手动删除!")
    } else {
        $homepath = dirtree($home)
        ensure_resource('file', $homepath, {'ensure' => 'directory'})
    }
}