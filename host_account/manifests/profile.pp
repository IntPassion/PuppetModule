# == Class: account::profile
#
# Configurate Linux/Unix home profile
#
# === Authors
#
# IntPassion
#

define account::profile (
    $home     = undef,
    $umask    = undef,
    $ps1      = undef,
    $export   = [],
    $ensure   = $account::params::default_ensure,
    $owner    = undef,
    $group    = undef,
    $mode     = $account::params::perm_homefile,
)
{
    validate_absolute_path($home)
    validate_re($ensure, '^(present|absent)$')
    validate_re($umask, '^\d+$')
    validate_re($mode, '^\d+$')
    validate_array($export)

    if $owner == undef or $group == undef or $home == undef {
        fail("profile文件用户名及组名、home目录不能为空")
    } else {
        validate_string($owner, $group)
    }
    
    # 设置用户环境变量
    ensure_resource('file', "${home}/.bash_profile", {
        ensure  => 'file',
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        content => template('account/bash_profile.erb'),
    })
}
