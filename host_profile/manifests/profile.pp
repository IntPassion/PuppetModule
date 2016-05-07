define host_profile::profile (
  $filepath   = undef,
  $exportdict = {},
  $location   = undef,
  $umask      = undef,
  $tmout      = undef,
)
{
  # 变量filepath、location为必输入项，不可为空
  if ! $location { fail("Variable \$location can not be undef") }
  if ! $filepath { fail("Variable \$filepath can not be undef") }

  # 判断输入的参数是否符合规则
  validate_absolute_path($filepath)
  validate_hash($exportdict)
  validate_string($location)

  $etc_profile = {
    "HISTFILE"       => '$HOME/.sh_history',
    "HISTSIZE"       => '1024',
    "HISTTIMEFORMAT" => '"%Y-%m-%d %H:%M:%S "',
  }

  if $filepath == '/etc/profile'{
    # 配置/etc/profile
    $etc_profile.each |$key, $value| {
      if ! defined( File_line["${filepath}@${key}"] ) {
        file_line { "${filepath}@${key}":
          path => $filepath,
          line => "export ${key}=${value}",
        }
      }
    }
  }

  $exportdict.each |$key, $value| {
    if ! defined( File_line["${filepath}@${key}"] ) {
      file_line { "${filepath}@${key}":
        path => $filepath,
        line => "export ${key}=${value}",
      }
    }
  }

  $ps1value = $filepath ? {
    '/root/.bash_profile' => "export PS1=`hostname`@${location}\'\$PWD\'#",
    default               => "export PS1=`hostname`@${location}\'\$PWD\'$",
  }

  # 将ps1变量配置到文件中
  file_line { "${filepath}@PS1":
    path => $filepath,
    line => $ps1value,
  }

  # 如果输入了umask变量，则将该变量配置到文件中
  if $umask {
    validate_string($umask)
    file_line { "${filepath}@umask":
      path => $filepath,
      line => "umask $umask",
    }
  }

  # 如果输入了tmout变量，则将该变量配置到文件中
  if $tmout {
    validate_string($tmout)
    file_line { "${filepath}@TMOUT":
      path => $filepath,
      line => "TMOUT=${tmout}",
    }
  }
}
