class weblogic::startWls (

    $oraMdwHome            = $oraMdwHome,
    $wlsHome               = $wlsHome,
    $jdkHome               = $jdkHome,
    $wlsDomainsRoot        = $wlsDomainsRoot,
    $wlsDomain             = $wlsDomain,
    $wlsServerType         = $wlsServerType,
    $wlsTarget             = $wlsTarget, # Server|Cluster
    $wlsServerName         = $wlsServerName,
    $wlsAdminServerAddress = $wlsAdminServerAddress,
    $wlsAdminServerPort    = $wlsAdminServerPort,
    $wlsNodeManagerPort    = $wlsNodeManagerPort,
    $wlsAction             = $wlsAction, #start|stop
    $wlsUser               = $wlsUser,
    $wlsPassword           = $wlsPassword,
    $wlsCustomTrust        = $wlsCustomTrust,
    $wlsTrustKSFile        = $wlsTrustKSFile,
    $wlstrustKSPassphrase  = $wlsTrustKSPassphrase,
    $oraUser               = $oraUser,
    $oraGroup              = $oraGroup,
    $downloadDir           = $downloadDir,
    $oraLogOutput          = $oraLogOutput, # true|false
  ) {

  require orawls::weblogic, weblogic::domain, weblogic::nodemanager

  orawls::control {'startWlsServer':
    middleware_home_dir       => $oraMdwHome,
    weblogic_home_dir         => $wlsHome,
    jdk_home_dir              => $jdkHome,
    wls_domains_dir           => $wlsDomainsRoot,
    domain_name               => $wlsDomain,
    server_type               => $wlsServerType,
    target                    => $wlsTarget, # Server|Cluster
    server                    => $wlsServerName,
    adminserver_address       => $wlsAdminServerAddress,
    adminserver_port          => $wlsAdminServerPort,
    nodemanager_port          => $wlsNodeManagerPort,
    action                    => $wlsAction, #start|stop
    weblogic_user             => $wlsUser,
    weblogic_password         => $wlsPassword,
    jsse_enabled              => false,
    custom_trust              => $wlsCustomTrust,
    trust_keystore_file       => $wlsTrustKSFile,
    trust_keystore_passphrase => $wlsTrustKSPassphrase,
    os_user                   => $oraUser,
    os_group                  => $oraGroup,
    download_dir              => $downloadDir,
    log_output                => $oraLogOutput, # true|false
  }
}
