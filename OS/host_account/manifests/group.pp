# == Class: account::group
#
# Definition of a Linux/Unix group
#
# === Authors
#
# IntPassion
#

define account::group 
(
    $ensure    = $account::params::default_ensure,         # ensure值为absent或者present
    $gid       = undef,                   # gid值为整数
) 
{
    $groupname = $title                 # 将title的值另存为变量groupname，保存组名称

    # 传入参数类型验证
    validate_re($ensure, [ '^absent$', '^present$' ], 
        'The $ensure parameter must be \'absent\' or \'present\'')

    # 判断gid是否指定，如果未指定，则将gid设置为组名
    if $gid != undef {
        validate_re($gid, '^\d+$')
        $_gid = $gid
    } else {
        $_gid = $groupname
    }
    
    ensure_resource('group', $groupname, {
        name   => $groupname,
        ensure => $ensure,
        gid    => $_gid,
    })
}
