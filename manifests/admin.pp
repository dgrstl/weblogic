class weblogic::admin (

  $osSwapSize            = $weblogic::params::swapSize,
  $sshPrivateKey         = $weblogic::params::sshPrivateKey,
  $sshPublicKey          = $weblogic::params::sshPublicKey,

  $sourcePath            = $weblogic::params::sourcePath,
  $downloadDir           = $weblogic::params::downloadDir,

  $jdkHome               = $weblogic::params::jdkHome,
  $jdkVersion            = $weblogic::params::jdkVersion,
  $jdkFullVersion        = $weblogic::params::jdkFullVersion,
  $jdkCryptoExtFile      = $weblogic::params::jdkCryptoExtFile,

  $oraHome               = $weblogic::params::oraHome,
  $oraMdwHome            = $weblogic::params::oraMdwHome,
  $oraLogs               = $weblogic::params::oraLogs,
  $oraUser               = $weblogic::params::oraUser,
  $oraGroup              = $weblogic::params::oraGroup,
  $oraLogOutput          = $weblogic::params::oraLogOutput,
  $oraInstaller          = $weblogic::params::oraInstaller,
  $oraTrustDir           = $weblogic::params::oraTrustDir,

  $wlsVersion            = $weblogic::params::wlsVersion,
  $wlsHome               = $weblogic::params::wlsHome,

  $wlsDomainsRoot        = $weblogic::params::wlsDomainsRoot,
  $wlsApplicationsRoot   = $weblogic::params::wlsApplicationsRoot,
  $wlsDomain             = $weblogic::params::wlsDomain,
  $wlsDomainTemplate     = $weblogic::params::wlsDomainTemplate,

  $wlsAdminServerName    = $weblogic::params::wlsAdminServerName,
  $wlsAdminServerAddress = $weblogic::params::wlsAdminServerAddress,
  $wlsAdminServerPort    = $weblogic::params::wlsAdminServerPort,
  $wlsUser               = $weblogic::params::wlsUser,
  $wlsPassword           = $weblogic::params::wlsPassword,
  $wlsServerType         = $weblogic::params::wlsServerType,
  $wlsTarget             = $weblogic::params::wlsTarget,
  $wlsAction             = $weblogic::params::wlsAction,
  $wlsServerName         = $weblogic::params::wlsServerName,
  $wlsUserConfigDir      = $weblogic::params::wlsUserConfigDir,

  $wlsNodeManagerAddress = $weblogic::params::wlsNodeManagerAddress,
  $wlsNodeManagerPort    = $weblogic::params::wlsNodeManagerPort,
  $wlsDevMode            = $weblogic::params::wlsDevMode,

  $wlsCustomTrust        = $weblogic::params::wlsCustomTrust,
  $wlsTrustKSFileSource  = $weblogic::params::wlsTrustKSFileSource,
  $wlsTrustKSFile        = $weblogic::params::wlsTrustKSFile,
  $wlsTrustKSPassphrase  = $weblogic::params::wlsTrustKSPassphrase,

  ) inherits weblogic::params {


  if $wlsCustomTrust == true {
    $wlsTrustKSPath = "${oraTrustDir}/${wlsTrustKSFile}"
  }

  class {'weblogic::os':
    oraUser              => $oraUser,
    oraGroup             => $oraGroup,
    oraLogs              => $oraLogs,
    osSwapSize           => $osSwapSize,
    sshPrivateKey        => $sshPrivateKey,
    sshPublicKey         => $sshPublicKey,
    oraTrustDir          => $oraTrustDir,
    wlsCustomTrust       => $wlsCustomTrust,
    wlsTrustKSFileSource => $wlsTrustKSFileSource,
    wlsTrustKSFile       => $wlsTrustKSFile,
  } contain 'weblogic::os'

  class {'weblogic::java':
    jdkVersion                   => $jdkVersion,
    jdkFullVersion               => $jdkFullVersion,
    downloadDir                  => $downloadDir,
    jdkCryptographyExtensionFile => $jdkCryptoExtFile,
    sourcePath                   => $sourcePath,
  } contain 'weblogic::java'

  class {'orautils':
    osOracleHomeParam       => $oraHome,
    oraInventoryParam       => "${oraHome}/oraInventory",
    osDomainTypeParam       => $wlsDomainTemplate,
    osLogFolderParam        => $oraLogs,
    osDownloadFolderParam   => $downloadDir,
    osMdwHomeParam          => $oraMdwHome,
    osWlHomeParam           => $wlsHome,
    osDomainParam           => $wlsDomain,
    osDomainPathParam       => "${wlsDomainsRoot}/${wlsDomain}",
    nodeMgrPathParam        => "${wlsDomainsRoot}/${wlsDomain}/bin",
    nodeMgrAddressParam     => $wlsNodeManagerAddress,
    nodeMgrPortParam        => $wlsNodeManagerPort,
    wlsUserParam            => $wlsUser,
    wlsPasswordParam        => $wlsPassword,
    wlsAdminServerParam     => $wlsAdminServerName,
    customTrust             => $wlsCustomTrust,
    trustKeystoreFile       => $wlsTrustKSPath,
    trustKeystorePassphrase => $wlsTrustKSPassphrase,
    require                 => Class[weblogic::os],
  } contain 'orautils'

  class {'orawls::weblogic':
    version              => $wlsVersion,
    filename             => $oraInstaller,
    jdk_home_dir         => $jdkHome,
    oracle_base_home_dir => $oraHome,
    middleware_home_dir  => $oraMdwHome,
    wls_domains_dir      => $wlsDomainsRoot,
    wls_apps_dir         => $wlsApplicationsRoot,
    os_user              => $oraUser,
    os_group             => $oraGroup,
    download_dir         => $downloadDir,
    source               => $sourcePath,
    log_output           => $oraLogOutput,
    require              => Class[weblogic::java],
  } contain 'orawls::weblogic'

  #include fmw
  #include opatch

  class {'weblogic::domain':
    wlsVersion            => $wlsVersion,
    wlsHome               => $wlsHome,
    oraMdwHome            => $oraMdwHome,
    jdkHome               => $jdkHome,
    wlsDomainsRoot        => $wlsDomainsRoot,
    wlsApplicationsRoot   => $wlsApplicationsRoot,
    wlsDomainTemplate     => $wlsDomainTemplate,
    wlsDomain             => $wlsDomain,
    wlsDevMode            => $wlsDevMode,
    wlsAdminServerName    => $wlsAdminServerName,
    wlsAdminServerAddress => $wlsAdminServerAddress,
    wlsAdminServerPort    => $wlsAdminServerPort,
    wlsNodeManagerAddress => $wlsNodeManagerAddress,
    wlsNodeManagerPort    => $wlsNodeManagerPort,
    wlsUser               => $wlsUser,
    wlsPassword           => $wlsPassword,
    oraUser               => $oraUser,
    oraGroup              => $oraGroup,
    downloadDir           => $downloadDir,
    oraLogs               => $oraLogs,
    oraLogOutput          => $oraLogOutput,
    wlsCustomTrust        => $wlsCustomTrust,
    wlsTrustKSFile        => $wlsTrustKSPath,
    wlsTrustKSPassphrase  => $wlsTrustKSPassphrase,
    require               => Class[orawls::weblogic],
  } contain 'weblogic::domain'

  class {'weblogic::nodemanager':
    wlsVersion            => $wlsVersion,
    wlsHome               => $wlsHome,
    oraMdwHome            => $oraMdwHome,
    jdkHome               => $jdkHome,
    wlsNodeManagerPort    => $wlsNodeManagerPort,
    wlsNodeManagerAddress => $wlsNodeManagerAddress,
    oraTrustDir           => $oraTrustDir,
    wlsCustomTrust        => $wlsCustomTrust,
    wlsTrustKSFile        => $wlsTrustKSPath,
    wlsTrustKSPassphrase  => $wlsTrustKSPassphrase,
    wlsDomainsRoot        => $wlsDomainsRoot,
    wlsDomain             => $wlsDomain,
    oraUser               => $oraUser,
    oraGroup              => $oraGroup,
    downloadDir           => $downloadDir,
    oraLogs               => $oraLogs,
    oraLogOutput          => $oraLogOutput,
  } contain 'weblogic::nodemanager'

  class {'weblogic::startWls':
    oraMdwHome            => $oraMdwHome,
    wlsHome               => $wlsHome,
    jdkHome               => $jdkHome,
    wlsDomainsRoot        => $wlsDomainsRoot,
    wlsDomain             => $wlsDomain,
    wlsServerType         => $wlsServerType,
    wlsTarget             => $wlsTarget,
    wlsServerName         => $wlsServerName,
    wlsAdminServerAddress => $wlsAdminServerAddress,
    wlsAdminServerPort    => $wlsAdminServerPort,
    wlsNodeManagerPort    => $wlsNodeManagerPort,
    wlsAction             => $wlsAction,
    wlsUser               => $wlsUser,
    wlsPassword           => $wlsPassword,
    wlsCustomTrust        => $wlsCustomTrust,
    wlsTrustKSFile        => $wlsTrustKSFile,
    wlstrustKSPassphrase  => $wlsTrustKSPassphrase,
    oraUser               => $oraUser,
    oraGroup              => $oraGroup,
    downloadDir           => $downloadDir,
    oraLogOutput          => $oraLogOutput,
  } contain 'weblogic::startWls'

  class {'weblogic::storeuserconfig':
    wlsDomain             => $wlsDomain,
    wlsHome               => $wlsHome,
    jdkHome               => $jdkHome,
    wlsAdminServerAddress => $wlsAdminServerAddress,
    wlsAdminServerPort    => $wlsAdminServerPort,
    wlsUserConfigDir      => $wlsUserConfigDir,
    wlsUser               => $wlsUser,
    wlsPassword           => $wlsPassword,
    oraUser               => $oraUser,
    oraGroup              => $oraGroup,
    downloadDir           => $downloadDir,
    oraLogOutput          => $oraLogOutput,
    require               => Class['weblogic::startWls'],
  } contain 'weblogic::storeuserconfig'

  #include nodemanager, startwls, userconfig
  #include users
  #include groups
  #include machines
  #include managed_servers
  #include managed_servers_channels
  #include datasources
  #include clusters
  #include virtual_hosts
  #include workmanager_constraints
  #include workmanagers
  #include file_persistence
  #include jms_servers
  #include jms_saf_agents
  #include jms_modules
  #include jms_module_subdeployments
  #include jms_module_quotas
  #include jms_module_cfs
  #include jms_module_queues_objects
  #include jms_module_topics_objects
  #include foreign_server_objects
  #include foreign_server_entries_objects
  #include saf_remote_context_objects
  #include saf_error_handlers
  #include saf_imported_destination
  #include saf_imported_destination_objects
  #include pack_domain
}
