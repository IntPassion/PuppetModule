class host_pkgandsvc::params {

  case $::osfamily {
    'RedHat': {
      case $::operatingsystemrelease {
        '6.7': {
          $packageslist = [
            "compat-libstdc++-296-2.96-144.el6.i686",
            "compat-libstdc++-33-3.2.3-69.el6.i686",
            "compat-libstdc++-33-3.2.3-69.el6.x86_64",
            "elfutils-libelf-devel-0.161-3.el6.i686",
            "elfutils-libelf-devel-0.161-3.el6.x86_64",
            "libgomp-4.4.7-16.el6.i686",
            "libgomp-4.4.7-16.el6.x86_64",
            "libgcc-4.4.7-16.el6.i686",
            "libgcc-4.4.7-16.el6.x86_64",
            "libstdc++-4.4.7-16.el6.i686",
            "libstdc++-4.4.7-16.el6.x86_64",
            "libstdc++-devel-4.4.7-16.el6.i686",
            "libstdc++-devel-4.4.7-16.el6.x86_64",
            "libstdc++-docs-4.4.7-16.el6.x86_64",
            "gcc-c++-4.4.7-16.el6.x86_64",
            "glibc-headers-2.12-1.166.el6.x86_64",
            "glibc-devel-2.12-1.166.el6.i686",
            "glibc-devel-2.12-1.166.el6.x86_64",
            "libaio-0.3.107-10.el6.i686",
            "libaio-devel-0.3.107-10.el6.i686",
            "libaio-devel-0.3.107-10.el6.x86_64",
            "sysstat-9.0.4-27.el6.x86_64",
            "kernel-headers-2.6.32-573.el6.x86_64",
            "binutils-2.20.51.0.2-5.43.el6.x86_64",
            "binutils-devel-2.20.51.0.2-5.43.el6.i686",
            "binutils-devel-2.20.51.0.2-5.43.el6.x86_64",
            "elfutils-libelf-0.161-3.el6.i686",
            "elfutils-libelf-0.161-3.el6.x86_64",
            "compat-glibc-2.5-46.2.x86_64",
            "compat-glibc-headers-2.5-46.2.x86_64",
            "glibc-2.12-1.166.el6.i686",
            "glibc-2.12-1.166.el6.x86_64",
            "glibc-common-2.12-1.166.el6.x86_64",
            "glibc-utils-2.12-1.166.el6.x86_64",
            "make-3.81-20.el6.x86_64",
            "unixODBC-2.2.14-14.el6.i686",
            "unixODBC-2.2.14-14.el6.x86_64",
            "unixODBC-devel-2.2.14-14.el6.i686",
            "unixODBC-devel-2.2.14-14.el6.x86_64",
            "gdb-7.2-83.el6.x86_64",
            "gdb-gdbserver-7.2-83.el6.x86_64",
            "gpm-1.20.6-12.el6.x86_64",
            "gpm-libs-1.20.6-12.el6.i686",
            "gpm-libs-1.20.6-12.el6.x86_64",
            "lm_sensors-3.1.1-17.el6.x86_64",
            "lm_sensors-devel-3.1.1-17.el6.i686",
            "lm_sensors-devel-3.1.1-17.el6.x86_64",
            "lm_sensors-libs-3.1.1-17.el6.i686",
            "lm_sensors-libs-3.1.1-17.el6.x86_64",
            "xinetd-2.3.14-39.el6_4.x86_64",
            "expect-5.44.1.15-5.el6_4.x86_64",
            "telnet-0.17-48.el6.x86_64",
            "mcelog-109-4.0fc9f70.el6.x86_64",
            "bash-4.1.2-33.el6.x86_64",
            "module-init-tools-3.9-25.el6.x86_64",
          ]

          $servicelist_start = [
            "abrt-ccpp", "abrtd", "acpid", "atd", "auditd", "certmonger",
            "crond", "haldaemon", "irqbalance", "lvm2-monitor",
            "mdmonitor", "messagebus", "network", "nfslock","smartd", "sshd",
            "sysstat", "udev-post", "xinetd", "lm_sensors",
            "gpm",
          ]

          $servicelist_stop = [
            "avahi-daemon", "autofs", "cpuspeed", "cups", "ip6tables",
            "iptables", "netconsole", "netfs", "nfs", "ntpd", "ntpdate",
            "oddjobd", "portreserve", "postfix", "psacct", "quota-nld",
            "rdisc", "restorecond", "rhnsd", "rhsmcertd", "rngd", "rpcbind",
            "rpcgssd", "rpcidmapd", "rpcsvcgssd", "saslauthd", "sssd", "ypbind",
          ]
        }

        '6.3': {
          $packageslist = [
            "compat-libstdc++-296-2.96-144.el6.i686",
            "compat-libstdc++-33-3.2.3-69.el6.i686",
            "compat-libstdc++-33-3.2.3-69.el6.x86_64",
            "elfutils-libelf-devel-0.152-1.el6.i686",
            "elfutils-libelf-devel-0.152-1.el6.x86_64",
            "elfutils-libelf-0.152-1.el6.i686",
            "elfutils-libelf-0.152-1.el6.x86_64",
            "libgomp-4.4.6-4.el6.i686",
            "libgomp-4.4.6-4.el6.x86_64",
            "libgcc-4.4.6-4.el6.i686",
            "libgcc-4.4.6-4.el6.x86_64",
            "libstdc++-4.4.6-4.el6.i686",
            "libstdc++-4.4.6-4.el6.x86_64",
            "libstdc++-devel-4.4.6-4.el6.i686",
            "libstdc++-devel-4.4.6-4.el6.x86_64",
            "libstdc++-docs-4.4.6-4.el6.x86_64",
            "gcc-c++-4.4.6-4.el6.x86_64",
            "libaio-0.3.107-10.el6.i686",
            "libaio-0.3.107-10.el6.x86_64",
            "libaio-devel-0.3.107-10.el6.i686",
            "libaio-devel-0.3.107-10.el6.x86_64",
            "sysstat-9.0.4-20.el6.x86_64",
            "kernel-headers-2.6.32-279.el6.x86_64",
            "binutils-2.20.51.0.2-5.34.el6.x86_64",
            "binutils-devel-2.20.51.0.2-5.34.el6.i686",
            "binutils-devel-2.20.51.0.2-5.34.el6.x86_64",
            "compat-glibc-2.5-46.2.x86_64",
            "compat-glibc-headers-2.5-46.2.x86_64",
            "glibc-2.12-1.80.el6.i686",
            "glibc-2.12-1.80.el6.x86_64",
            "glibc-common-2.12-1.80.el6.x86_64",
            "glibc-devel-2.12-1.80.el6.i686",
            "glibc-devel-2.12-1.80.el6.x86_64",
            "glibc-headers-2.12-1.80.el6.x86_64",
            "glibc-utils-2.12-1.80.el6.x86_64",
            "make-3.81-20.el6.x86_64",
            "unixODBC-2.2.14-11.el6.i686",
            "unixODBC-2.2.14-11.el6.x86_64",
            "unixODBC-devel-2.2.14-11.el6.i686",
            "unixODBC-devel-2.2.14-11.el6.x86_64",
            "gdb-7.2-56.el6.x86_64",
            "gdb-gdbserver-7.2-56.el6.x86_64",
            "gpm-1.20.6-12.el6.x86_64",
            "gpm-libs-1.20.6-12.el6.i686",
            "gpm-libs-1.20.6-12.el6.x86_64",
            "lm_sensors-3.1.1-10.el6.x86_64",
            "lm_sensors-devel-3.1.1-10.el6.i686",
            "lm_sensors-devel-3.1.1-10.el6.x86_64",
            "lm_sensors-libs-3.1.1-10.el6.i686",
            "lm_sensors-libs-3.1.1-10.el6.x86_64",
            "xinetd-2.3.14-34.el6.x86_64",
            "expect-5.44.1.15-4.el6.x86_64",
          ]

          $servicelist_start = [
            "abrt-ccpp", "abrtd", "acpid", "atd", "auditd", "certmonger",
            "crond", "haldaemon", "irqbalance", "lvm2-monitor",
            "mdmonitor", "messagebus", "network", "nfslock", "smartd",
            "sshd", "sysstat", "udev-post", "xinetd", "lm_sensors",
            "gpm",
          ]

          $servicelist_stop = [
            "avahi-daemon", "autofs", "cpuspeed", "cups", "ip6tables",
            "iptables", "netconsole", "netfs", "nfs", "ntpd", "ntpdate",
            "oddjobd", "portreserve", "postfix", "psacct", "quota-nld",
            "rdisc", "restorecond", "rhnsd", "rhsmcertd", "rngd", "rpcbind",
            "rpcgssd", "rpcidmapd", "rpcsvcgssd", "saslauthd", "sssd", "ypbind",
          ]
        }
      }

    }

    default : {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
