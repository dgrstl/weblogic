class weblogic::ssh {
  require weblogic::os


  file { '/home/oracle/.ssh/':
    ensure => directory,
    owner  => 'oracle',
    group  => 'dba',
    mode   => '0700',
    alias  => 'oracle-ssh-dir',
  }

  file { '/home/oracle/.ssh/id_rsa.pub':
    ensure  => present,
    owner   => 'oracle',
    group   => 'dba',
    mode    => '0644',
    source  => 'puppet:///modules/weblogic/ssh/id_rsa.pub',
    require => File['oracle-ssh-dir'],
  }

  file { '/home/oracle/.ssh/id_rsa':
    ensure  => present,
    owner   => 'oracle',
    group   => 'dba',
    mode    => '0600',
    source  => 'puppet:///modules/weblogic/ssh/id_rsa',
    require => File['oracle-ssh-dir'],
  }

  file { '/home/oracle/.ssh/authorized_keys':
    ensure  => present,
    owner   => 'oracle',
    group   => 'dba',
    mode    => '0644',
    source  => 'puppet:///modules/weblogic/ssh/id_rsa.pub',
    require => File['oracle-ssh-dir'],
  }
}
