exec { 'locale':
    command     => '/bin/sed -i -e "s/^LANG=.*$/LANG=\"ja_JP.UTF-8\"/" /etc/sysconfig/i18n',
    unless      => '/usr/bin/test \! -f /etc/sysconfig/i18n || /bin/grep "^LANG=\"ja_JP.UTF-8\"" /etc/sysconfig/i18n',
}
file { '/etc/localtime':
    ensure      => file,
    source      => '/usr/share/zoneinfo/Asia/Tokyo',
}
exec { 'selinux':
    command     => '/usr/sbin/setenforce 0; /bin/sed -i -e "s|^SELINUX=.*$|SELINUX=disabled|" /etc/selinux/config',
    unless      => '/usr/bin/test \! -f /etc/selinux/config || /bin/grep "SELINUX=disabled" /etc/selinux/config',
}
exec { 'grub':
    command     => '/bin/sed -i -e "s|quiet.*$|quiet enforcing=0|" /etc/grub.conf',
    unless      => '/usr/bin/test \! -f /etc/grub.conf || /bin/grep "quiet enforcing=0" /etc/grub.conf',
}
service { 'iptables':
    enable      => false,
    ensure      => stopped,
}
