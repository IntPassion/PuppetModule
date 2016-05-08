class host_kernel::params {

  $kernel_path = '/etc/sysctl.conf'
  $kernel_common = [
    'net.ipv4.tcp_syncookies 2',
    'net.ipv4.tcp_max_syn_backlog 4096',
    'net.ipv4.tcp_fin_timeout 32',
    'net.ipv4.tcp_synack_retries 3',
  ]

  $limits_path = '/etc/security/limits.conf'
  $limits_common = [
    '* soft nofile 4096',
    '* hard nofile 65536',
  ]
}
