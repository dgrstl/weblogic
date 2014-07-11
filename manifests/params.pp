class weblogic::params {

  $oraHome = $::osfamily ? {
    default => '/opt/oracle',
  }

  $oraMdwHome = $::osfamily ? {
    default => "${oraHome}/middleware12c",
  }

  $wlsHome = $::osfamily ? {
    default => "${oraMdwHome}/wlserver",
  }

  $oraVersion = $::osfamily ? {
    default => '1213',
  }

  $oraDomain = $::osfamily ? {
    default => 'Wls1213',
  }

  $oraDomainRoot = $::osfamily ? {
    default => "${oraHome}/domains",
  }

  $oraLogs = $::osfamily ? {
    default => '/var/log/oracle12c',
  }

  $oraUser = $::osfamily ? {
    default => 'oracle',
  }

  $oraGroup = $::osfamily ? {
    default => 'dba',
  }

  $sourcePath = $::osfamily ? {
    default => '/vagrant/weblogic-software',
  }

  $downloadDir = $::osfamily ? {
    default => '/var/tmp/install',
  }

  $osHomeRoot = $::osfamily ? {
    default => '/home',
  }

  $oraWlsDomainTemplate = $::osfamily ? {
    default => 'standard',
  }

  $jdkHome = $::osfamily ? {
    default => '/usr/java/latest',
  }

  $oraAdminServerName = $::osfamily ? {
    default => 'AdminServer',
  }

  $oraAdminServerAddress = $::osfamily ? {
    default => 'centos65a',
  }

  $oraAdminServerPort = $::osfamily ? {
    default => '7001',
  }

  $oraWlsUser = $::osfamily ? {
    default => 'weblogic',
  }

  $oraWlsPassword = $::osfamily ? {
    default => 'weblogic1',
  }

  $oraNodeManagerPort = $::osfamily ? {
    default => '5556',
  }

  $oraWlsDevMode = $::osfamily ? {
    default => false,
  }

  $oraLogOutput = $::osfamily ? {
    default => false,
  }

  $wlsCustomTrust = $::osfamily ? {
    default => true,
  }

}
