class weblogic::params {

  $oraInstallSource = $::osfamily ? {
    default => '/vagrant/oracle',
  }

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

  $oraTrustDir = $::osfamily ? {
    default => "${oraHome}/trust",
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
    default => "${oraMdwHome}/user_projects/domains",
  }

  $wlsApplicationsRoot = $::osfamily ? {
    default => "${oraMdwHome}/user_projects/applications",
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
    default => "${oraInstallSource}/software",
  }

  $downloadDir = $::osfamily ? {
    default => "${oraInstallSource}/tmp/install",
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

  $jdkURandomFix = $::osfamily ? {
    default => true,
  }

  $jdkRsaKeySizeFix = $::osfamily ? {
    default => true,
  }

  $jdkAlternativesPriority = $::osfamily ? {
    default => 18000,
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
    default => false,
  }

  $wlsTrustKSFile = $::osfamily ? {
    default => 'truststore.jks',
  }

  $wlsTrustKSFileSource = $::osfamily ? {
    default => "${oraInstallSource}/keystores/${wlsTrustKSFile}",
  }

  $wlsTrustKSPassphrase = $::osfamily ? {
    default => 'welcome',
  }

  $oraInstaller = $::osfamily ? {
    default => 'fmw_12.1.3.0.0_wls.jar',
  }

  $wlsServerType = $::osfamily ? {
    default => 'admin',
  }

  $wlsTarget = $::osfamily ? {
    default => 'server',
  }

  $wlsAction = $::osfamily ? {
    default => 'start',
  }

  $wlsServerName = $::osfamily ? {
    default => 'AdminServer',
  }

  $wlsUserConfigDir = $::osfamily ? {
    default => '/home/oracle',
  }

  $wlsAthProvider = $::osfamily ? {
    default => 'DefaultAuthenticator',
  }

  $wlsRealm = $::osfamily ? {
    default => 'myrealm',
  }

}
