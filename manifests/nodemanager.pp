class weblogic::nodemanager (

    $wlsVersion            = undef,
    $oraMdwHome            = undef,
    $wlsHome               = undef,
    $wlsNodeManagerPort    = undef,
    $wlsNodeManagerAddress = undef,
    $oraTrustDir           = undef,
    $wlsCustomTrust        = undef,
    $wlsTrustKSSource      = undef,
    $wlsTrustKSFile        = undef,
    $wlsTrustKSPassphrase  = undef,
    $wlsDomainsRoot        = undef,
    $wlsDomain             = undef,
    $jdkHome               = undef,
    $oraUser               = undef,
    $oraGroup              = undef,
    $downloadDir           = undef,
    $oraLogs               = undef,
    $oraLogOutput          = undef,

  ) {

  require orawls::weblogic, weblogic::domain

  orawls::nodemanager {'wls12nodeManager':
    version                   => $wlsVersion,
    middleware_home_dir       => $oraMdwHome,
    weblogic_home_dir         => $wlsHome,
    nodemanager_port          => $wlsNodeManagerPort,
    nodemanager_address       => $wlsNodeManagerAddress,
    custom_trust              => $wlsCustomTrust,
    trust_keystore_file       => $wlsTrustKSFile,
    trust_keystore_passphrase => $wlsTrustKSPassphrase,
    wls_domains_dir           => $wlsDomainsRoot,
    domain_name               => $wlsDomain,
    jdk_home_dir              => $jdkHome,
    os_user                   => $oraUser,
    os_group                  => $oraGroup,
    download_dir              => $downloadDir,
    log_dir                   => $oraLogs,
    log_output                => $oraLogOutput,
  }

  orautils::nodemanagerautostart {'autostart weblogic':
    version                 => $wlsVersion,
    wlHome                  => $wlsHome,
    user                    => $oraUser,
    domain                  => $wlsDomain,
    logDir                  => $oraLogs,
    customTrust             => $wlsCustomTrust,
    trustKeystoreFile       => $wlsTrustKSFile,
    trustKeystorePassphrase => $wlsTrustKSPassphrase,
  }
}
