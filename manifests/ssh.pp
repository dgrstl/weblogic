class weblogic::ssh (
    $oraUser       = 'oracle',
    $oraGroup      = 'dba',
    $oraUserHome   = '/home/oracle',
    $sshPrivateKey = undef,
    $sshPublicKey  = undef,
  ) {

  File {
    ensure => file,
    mode   => 0644,
    owner  => $oraUser,
    group  => $oraGroup,
  }

  file { "${oraUserHome}/.ssh/":
    ensure => directory,
    mode   => '0700',
    alias  => 'oracle-ssh-dir',
  }

  file { "${oraUserHome}/.ssh/id_rsa.pub":
    source  => $sshPublicKey,
    require => File['oracle-ssh-dir'],
  }

  file { "${oraUserHome}/.ssh/id_rsa":
    ensure  => file,
    mode    => '0600',
    source  => $sshPrivateKey,
    require => File['oracle-ssh-dir'],
  }

  file { "${oraUserHome}/.ssh/authorized_keys":
    source  => $sshPublicKey,
    require => File['oracle-ssh-dir'],
  }
}
