class weblogic::params {

  $osSwapSize = $::osfamily ? {
    default => '512',
  }

  $sshPrivateKey = $::osfamily ? {
    default => 'puppet:///modules/weblogic/ssh/id_rsa',
  }

  $sshPublicKey = $::osfamily ? {
    default => 'puppet:///modules/weblogic/ssh/id_rsa.pub',
  }

  $oraHome = $::osfamily ? {
    default => '/opt/oracle',
  }

  $oraMdwHome = $::osfamily ? {
    default => "${oraHome}/middleware12c",
  }

  $wlsHome = $::osfamily ? {
    default => "${oraMdwHome}/wlserver",
  }

  $wlsVersion = $::osfamily ? {
    default => '1213',
  }

  $wlsDomain = $::osfamily ? {
    default => 'Wls1213',
  }

  $wlsDomainsRoot = $::osfamily ? {
    default => "${oraHome}/domains",
  }

  $wlsApplicationsRoot = $::osfamily ? {
    default => "${oraHome}/applications",
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
    default => '/vagrant/tmp/install',
  }

  $osHomeRoot = $::osfamily ? {
    default => '/home',
  }

  $wlsDomainTemplate = $::osfamily ? {
    default => 'standard',
  }

  $jdkHome = $::osfamily ? {
    default => '/usr/java/latest',
  }

  $jdkVersion = $::osfamily ? {
    default => '7u51',
  }

  $jdkFullVersion = $::osfamily ? {
    default => 'jdk1.7.0_51',
  }

  $jdkCryptoExtFile = $::osfamily ? {
    default => 'UnlimitedJCEPolicyJDK7.zip',
  }

  $wlsAdminServerName = $::osfamily ? {
    default => 'AdminServer',
  }

  $wlsAdminServerAddress = $::osfamily ? {
    default => 'centos65a',
  }

  $wlsAdminServerPort = $::osfamily ? {
    default => '7001',
  }

  $wlsUser = $::osfamily ? {
    default => 'weblogic',
  }

  $wlsPassword = $::osfamily ? {
    default => 'weblogic1',
  }

  $wlsNodeManagerAddress = $::osfamily ? {
    default => 'centos65a',
  }

  $wlsNodeManagerPort = $::osfamily ? {
    default => '5556',
  }

  $wlsDevMode = $::osfamily ? {
    default => false,
  }

  $oraLogOutput = $::osfamily ? {
    default => false,
  }

  $wlsCustomTrust = $::osfamily ? {
    default => true,
  }

  $wlsTrustKSFile = $::osfamily ? {
    default => 'puppet:///modules/weblogic/oracle/truststore.jks',
  }

  $wlsTrustKSPassphrase = $::osfamily ? {
    default => 'welcome',
  }

  $oraInstaller = $::osfamily ? {
    default => 'fmw_12.1.3.0.0_wls.jar',
  }

}
