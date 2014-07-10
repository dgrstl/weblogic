class weblogic::params {

  $oraHome = $::osfamily ? {
    default => '/opt/oracle',
  }

  $oraMdwHome = $::osfamily ? {
    default => "${oraHome}/middleware12c",
  }

  $oraDomain = $orawls::weblogic::version ? {
    '1213'  => 'Wls1213',
    default => 'undef',
  }

  $oraDomainRoot = $::osfamily ? {
    default => "${oraHome}/domains",
  }

  $oraLogs = $::osfamily ? {
    default => '/var/log/oracle',
  }

  $oraUser = $::osfamily ? {
    default => 'oracle',
  }

  $oraGroup = $::osfamily ? {
    default => 'dba',
  }
}
