exec { 'locale':
    command     => '/bin/localectl set-locale LANG=ja_JP.UTF-8',
    unless      => '/usr/bin/test \! -f /etc/locale.conf || /bin/grep "^LANG=\"ja_JP.UTF-8\"" /etc/locale.conf',
}
file { '/etc/localtime':
    ensure      => file,
    source      => '/usr/share/zoneinfo/Asia/Tokyo',
}
exec { 'selinux':
    command     => '/usr/sbin/setenforce 0; /bin/sed -i -e "s|^SELINUX=.*$|SELINUX=disabled|" /etc/selinux/config',
    unless      => '/usr/bin/test \! -f /etc/selinux/config || grep "SELINUX=disabled" /etc/selinux/config',
}
service { 'firewalld':
    enable      => false,
    ensure      => stopped,
}
