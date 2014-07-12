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

  $wlsNodeManagerAddress = $weblogic::params::wlsNodeManagerAddress,
  $wlsNodeManagerPort    = $weblogic::params::wlsNodeManagerPort,
  $wlsDevMode            = $weblogic::params::wlsDevMode,

  $wlsCustomTrust        = $weblogic::params::wlsCustomTrust,
  $wlsTrustKSFile        = $weblogic::params::wlsTrustKSFile,
  $wlsTrustKSPassphrase  = $weblogic::params::wlsTrustKSPassphrase,

  ) inherits weblogic::params {

  class {'weblogic::os':
    oraUser       => $oraUser,
    oraGroup      => $oraGroup,
    oraLogs       => $oraLogs,
    osSwapSize    => $osSwapSize,
    sshPrivateKey => $sshPrivateKey,
    sshPublicKey  => $sshPublicKey,
  } contain 'weblogic::os'

  $is64bit = $::hardwaremodel ? {
    x86_64  => true,
    default => false,
  }

  class {'weblogic::java':
    version                   => $jdkVersion,
    fullVersion               => $jdkFullVersion,
    downloadDir               => $downloadDir,
    cryptographyExtensionFile => $jdkCryptoExtFile,
    sourcePath                => $sourcePath,
    x64                       => $is64bit,
    require                   => Class[Weblogic::Os],
  } contain 'weblogic::java'

  class {'orautils':
    osOracleHomeParam       => $oraHome,
    oraInventoryParam       => "${oraHome}/oraInventory",
    osLogFolderParam        => $oraLogs,
    osDomainTypeParam       => $wlsDomainTemplate,
    osDownloadFolderParam   => $downloadDir,
    osDomainParam           => $wlsDomain,
    osMdwHomeParam          => $oraMdwHome,
    osDomainPathParam       => "${wlsDomainsRoot}/${wlsDomain}",
    nodeMgrPathParam        => "${wlsDomainsRoot}/${wlsDomain}/bin",
    nodeMgrAddressParam     => $wlsAdminServerName,
    wlsUserParam            => $wlsUser,
    wlsPasswordParam        => $wlsPassword,
    wlsAdminServerParam     => $wlsAdminServerName,
    customTrust             => $wlsCustomTrust,
    trustKeystoreFile       => $wlsTrustKSFile,
    trustKeystorePassphrase => $wlsTrustKSPassphrase,
    require                 => Class[orawls::weblogic],
  } contain 'orautils'

  class {'orawls::weblogic':
    version              => $wlsVersion,
    filename             => $oraInstaller,
    jdk_home_dir         => $jdkHome,
    oracle_base_home_dir => $oraHome,
    middleware_home_dir  => $oraMdwHome,
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
    wlsTrustKSFile        => $wlsTrustKSFile,
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
    wlsCustomTrust        => $wlsCustomTrust,
    wlsTrustKSFile        => $wlsTrustKSFile,
    wlsTrustKSPassphrase  => $wlsTrustKSPassphrase,
    wlsDomainsRoot        => $wlsDomainsRoot,
    wlsDomain             => $wlsDomain,
    oraUser               => $oraUser,
    oraGroup              => $oraGroup,
    downloadDir           => $downloadDir,
    oraLogs               => $oraLogs,
    oraLogOutput          => $oraLogOutput,
    require               => Class[weblogic::domain],
  } contain 'weblogic::nodemanager'

  #class {'weblogic::startWls':
  #oraMdwHome            => $oraMdwHome,
  #  wlsHome               => $wlsHome,
  #  jdkHome               => $jdkHome,
  #  wlsDomainsRoot         => $wlsDomainsRoot,
  #  wlsDomain             => $wlsDomain,
  #  wlsDevMode         => $wlsDevMode,
  #  wlsAdminServerName    => $wlsAdminServerName,
  #  wlsAdminServerAddress => $wlsAdminServerAddress,
  #  wlsAdminServerPort    => $wlsAdminServerPort,
  #  wlsNodeManagerAddress => $wlsAdminServerAddress,
  #  wlsNodeManagerPort    => $wlsNodeManagerPort,
  #  wlsUser            => $wlsUser,
  #  wlsPassword        => $wlsPassword,
  #  oraUser               => $oraUser,
  #  oraGroup              => $oraGroup,
  #  oraLogs               => $oraLogs,
  #  downloadDir           => $downloadDir,
  #  oraLogOutput          => $oraLogOutput,
  #  require               => Class[orawls::weblogic],
  #} contain 'weblogic::domain'
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
