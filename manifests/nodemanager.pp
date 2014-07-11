class weblogic::nodemanager (

  $oraHome               = undef,
  $oraMdwHome            = undef,
  $oraDomain             = undef,
  $oraDomainRoot         = undef,
  $oraLogs               = undef,
  $oraUser               = undef,
  $oraGroup              = undef,
  $sourcePath            = undef,
  $downloadDir           = undef,
  $wlsHome               = undef,
  $oraVersion            = undef,
  $oraWlsDomainTemplate  = undef,
  $oraAdminServerName    = undef,
  $oraAdminServerAddress = undef,
  $oraAdminServerPort    = undef,
  $oraWlsUser            = undef,
  $oraWlsPassword        = undef,
  $oraNodeManagerAddress    = undef,
  $oraNodeManagerPort    = undef,
  $oraWlsDevMode         = undef,
  $oraLogOutput          = undef,
  $jdkHome               = undef,
  $wlsCustomTrust        = false,
  $wlsTrustKeystoreFile  = undef,
  $wlsTrustKeystorePassphrase = undef,

  ) {

  orawls::nodemanager {'wls12nodeManager':
    version             => $oraVersion,
    weblogic_home_dir   => $wlsHome,
    middleware_home_dir => $oraMdwHome,
    jdk_home_dir        => $jdkHome,
    nodemanager_address => $oraNodeManagerAddress,
    nodemanager_port    => $oraNodeManagerPort,
    domain_name         => $oraDomain,
    os_user             => $oraUser,
    os_group            => $oraGroup,
    log_dir             => $oraLogs,
    download_dir        => $downloadDir,
    log_output          => $oraLogOutput,
  }

  orautils::nodemanagerautostart {'autostart weblogic':
    version                 => $oraVersion,
    wlHome                  => $wlsHome,
    user                    => $oraUser,
    jsseEnabled             => false,
    customTrust             => $wlsCustomTrust,
    trustKeystoreFile       => $wlsTrustKeystoreFile,
    trustKeystorePassphrase => $wlsTrustKeystorePassphrase,
  }
}
