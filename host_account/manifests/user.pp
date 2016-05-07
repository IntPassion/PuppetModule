# == Class: account::user
#
# Definition of a Linux/Unix user
#
# === Authors
#
# IntPassion
#
/*
    gid: 用户组ID； gname：用户组名称
    注意：这两个参数是成对出现的，是为了单独建立组时使用的。两个参数同时为undef，或同时有值。如果两个参数值为undef，则此时创建与用户名相同的组
 */
define account::user
(
    $ensure           = $account::params::default_ensure,
    $uid              = undef,
    $gid              = undef,
    $gname            = undef,                                  # gname默认与用户名相同
    $groups           = [],
    $comment          = $name,                                  # comment默认使用用户名
    $shell            = $account::params::loginshell,
    $password         = $account::params::default_password,
    $home             = $account::params::home,
    $home_permissions = $account::params::perm_homedir,
    $umask            = $account::params::umask,
    $export           = [],
    $ps1              = undef,
) 
{
    $username = $title               # 将title的值另存为变量username，保存用户名称

    # 传入参数类型验证
    validate_re($ensure, [ '^absent$', '^present$' ], 'The $ensure parameter must be \'absent\' or \'present\'')

    if $uid != undef {
        validate_re($uid, '^\d+$')
        $_uid = $uid
    } else {
        $_uid = $account::params::root_uid
    }

    if $gid != undef and $gname != undef {
        validate_re($gid, '^\d+$')
        $_gid = $gname
    } elsif $gid == undef and $gname == undef {
        $_gid = $username
    } else {
        $_gid = $account::params::root_gid
    }

    validate_re($umask, '^\d+$')
    validate_absolute_path($shell, $home)
    validate_string($gname, $commnet, $password, $ps1)
    validate_array($groups, $export)

    if $gid == undef {
        group { $_gid: 
            name   => $_gid,
            ensure => present,
        }        
    }

    ensure_resource ('user', $username, {
        name     => $username,
        ensure   => present,
        uid      => $_uid,
        gid      => $_gid,      # 这里的gid值为组名或者用户名
        groups   => $groups,
        shell    => $shell,
        comment  => $comment,
        home     => $home,
        password => $password,
        require  => Group[$_gid],
    })
    
    # 确认用户主目录存在
    account::homedir { $home:
        mode    => $home_permissions,
        ensure  => $ensure,
        before  => [ User[$username] ],
    }

    # 创建用户profile文件
    account::profile { "${home}/.bash_profile": 
        home   => $home,
        umask  => $umask,
        ps1    => $ps1,
        export => $export,
        owner  => $username,
        group  => $_gid,
        #require =>  Class[account::homedir],
    }
}
