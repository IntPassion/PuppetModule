define baseline::profile( 
  $filetype = undef, 
  $export   = {}, 
  $umask    = '027',
  $tmout    = '1200',
){
  case $filetype {
    '/etc/profile': {
      file { '/etc/profile':
        ensure => file,
        owner  => 'root',
        group  => 'root',
        mode   => '644',
        content => template('baseline/profile.erb'),
      }
    }
    '/root/.bash_profile': {
      file { '/root/.bash_profile':
        ensure => file,
        owner  => 'root',
        group  => 'root',
        mode   => '600',
        path   => "/root/.bash_profile",
        content => template('baseline/bash_profile.erb'),
      }
    }
  }
}
