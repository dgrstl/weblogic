class weblogic::domain (

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

  ) {

  orawls::domain {'wls12domain':
    version             => $oraVersion,
    weblogic_home_dir   => $wlsHome,
    middleware_home_dir => $oraMdwHome,
    jdk_home_dir        => $jdkHome,
    domain_template     => $oraWlsDomainTemplate,
    domain_name         => $oraDomain,
    development_mode    => $oraWlsDevMode,
    adminserver_name    => $oraAdminServerName,
    adminserver_address => $oraAdminServerAddress,
    adminserver_port    => $oraAdminServerPort,
    nodemanager_address => $oraNodeManagerAddress,
    nodemanager_port    => $oraNodeManagerPort,
    #java_arguments     => { "ADM"                  => "...", "OSB" => "...", "SOA" => "...", "BAM" => "..."},
    weblogic_user       => $oraWlsUser,
    weblogic_password   => $oraWlsPassword,
    os_user             => $oraUser,
    os_group            => $oraGroup,
    log_dir             => $oraLogs,
    download_dir        => $downloadDir,
    log_output          => $oraLogOutput,
  }

  wls_setting { 'default':
    user              => $oraUser,
    weblogic_home_dir => $wlsHome,
    connect_url       => "t3://${oraAdminServerAddress}:${oraAdminServerPort}",
    weblogic_user     => $oraWlsUser,
    weblogic_password => $oraWlsPassword,
  }
}
