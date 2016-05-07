# Definition of a Linux/Unix group

define account::group 
(
    $ensure    = $account::params::default_ensure,         # ensure值为absent或者present
    $gid       = undef,                   # gid值为整数
) 
{

    # 传入参数类型验证
    #info('[account::group] -> 开始验证传入变量 ensure|gid 类型.')
    validate_re($ensure, [ '^absent$', '^present$' ], 
        'The $ensure parameter must be \'absent\' or \'present\'')
    validate_integer($gid)

    #info('[account::group] -> 变量类型验证通过.')
    $groupname = $title                 # 将title的值另存为变量groupname，保存组名称

    #info('[account::group] -> 创建用户组 $groupname')
    ensure_resource('group', $groupname, {
        name   => $groupname,
        ensure => $ensure,
        gid    => $gid,
    })
}
