class weblogic::storeuserconfig (
  $wlsDomain             = undef,
  $wlsHome               = undef,
  $jdkHome               = undef,
  $wlsAdminServerAddress = undef,
  $wlsAdminServerPort    = undef,
  $wlsUserConfigDir      = undef,
  $wlsUser               = undef,
  $wlsPassword           = undef,
  $oraUser               = undef,
  $oraGroup              = undef,
  $downloadDir           = undef,
  $oraLogOutput          = undef,
  ) {

  orawls::storeuserconfig{'WLSStoreconfig':
    domain_name         => $wlsDomain,
    weblogic_home_dir   => $wlsHome,
    jdk_home_dir        => $jdkHome,
    adminserver_address => $wlsAdminServerAddress,
    adminserver_port    => $wlsAdminServerPort,
    user_config_dir     => $wlsUserConfigDir,
    weblogic_user       => $wlsUser,
    weblogic_password   => $wlsPassword,
    os_user             => $oraUser,
    os_group            => $oraGroup,
    download_dir        => $downloadDir,
    log_output          => $oraLogOutput,
  }
}
