class host_baseline (
){
  # initialize the variable
  $profile_export = {
    "HISTFILE" => '$HOME/.sh_history',
    "HISTSIZE" => '1024',
    "PS1"      => '`hostname`@DL\'$PWD\'$',
    "HISTTIMEFORMAT" => '"%Y-%m-%d %H:%M:%S "',
  }

  $bashprofile_export = {
    "PS1" => '`hostname`@DL\'$PWD\'$',
  }

  # do the profile setting
  baseline::profile {
    '/etc/profile':
    filetype => '/etc/profile',
    export => $profile_export,
    tmout  => '1200',
  }

  baseline::profile {
    '/root/.bash_profile':
    filetype => '/root/.bash_profile',
    export => $bashprofile_export,
    umask  => '027',
  }

  include baseline::sysconfig
  #include baseline::kernel
  include baseline::security
  include baseline::packages
  include baseline::service
  include baseline::others
}
