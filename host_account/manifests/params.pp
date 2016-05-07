# == Class: account::params
#
# Puppet account management
# 
# 配置account公共参数
#
# === Authors
#
# IntPassion
#

class account::params
{
    $default_ensure   = 'present'
    $default_password = '$1$3225ebb0$cvbeQUDLe8xn1hKY0sqMq0'    #默认密码为admin123
    
    case $::osfamily {
        'RedHat': {
            $home           = '/home/'
            $perm_homedir   = '0700'
            $perm_homefile  = '0600'
            $loginshell     = '/bin/bash'
            $umask          = '027'
            $root_uid       = 0
            $root_gid       = 0
    }

    default : {
        fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
