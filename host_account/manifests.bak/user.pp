# == Class: account::group
#
# Definition of a Linux/Unix user
#
# === Authors
#
# IntPassion
#

define account::user
(
    $ensure           = $account::params::default_ensure,
    $uid              = undef,
    $gid              = undef,
    $gname            = undef,
    $groups           = [],
    $comment          = undef,
    $shell            = $account::params::loginshell,
    $password         = $account::params::default_password,
    $home             = $account::params::home,
    $home_permissions = $account::params::perm_homedir,
    $umask            = $account::params::umask,
    $profile          = [],
) 
{

    # 输入参数类型判断
    validate_re($ensure, [ '^absent$', '^present$' ], 'The $ensure parameter must be \'absent\' or \'present\'')
    validate_integer($uid)
    validate_integer($gid)
    validate_string($gname)
    validate_array($groups)
    validate_string($comment)
    validate_absolute_path($shell)
    validate_string($password)
    validate_absolute_path($home)
    #validate_array($profile)

    #根据变量title获取用户名
    $username = $title
    case $ensure {
        # 删除用户
        absent: {
            user { $username:
                ensure => absent,
                #uid    => $uid,
                #gid    => $gid,
                groups => $groups,
            }
        }
    
        # 创建用户
        present: {
            #判断用户目录是否存在，如果非undef，则创建目录
   	    $dirtree_home = dirtree($home) 
	    ensure_resource('file', $dirtree_home, {'ensure' => 'directory'})

            user { $username:
                ensure   => present,
                uid      => $uid,
                gid      => $gid,
                groups   => $groups,
                shell    => $shell,
                comment  => $comment,
                home     => $home,
                password => $password,
            }
    
          #创建用户环境变量与umask掩码
          #if $export or $umask {
          #  file { "${home}/.bash_profile":
          #    ensure  => 'file',
          #    owner   => $username,
          #    group   => $gid,
          #    mode    => $HOME_FILE_PERM,
          #    content => template('account/bash_profile.erb'),
          #  }
          #}
        }
    }
}
