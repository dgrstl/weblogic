class weblogic::admin (

  $oraHome               = $weblogic::params::oraHome,
  $oraMdwHome            = $weblogic::params::oraMdwHome,
  $oraDomain             = $weblogic::params::oraDomain,
  $oraDomainRoot         = $weblogic::params::oraDomainRoot,
  $oraLogs               = $weblogic::params::oraLogs,
  $oraUser               = $weblogic::params::oraUser,
  $oraGroup              = $weblogic::params::oraGroup,
  $sourcePath            = $weblogic::params::sourcePath,
  $downloadDir           = $weblogic::params::downloadDir,
  $wlsHome               = $weblogic::params::wlsHome,
  $oraVersion            = $weblogic::params::oraVersion,
  $oraWlsDomainTemplate  = $weblogic::params::oraWlsDomainTemplate,
  $oraAdminServerName    = $weblogic::params::oraAdminServerName,
  $oraAdminServerAddress = $weblogic::params::oraAdminServerAddress,
  $oraAdminServerPort    = $weblogic::params::oraAdminServerPort,
  $oraWlsUser            = $weblogic::params::oraWlsUser,
  $oraWlsPassword        = $weblogic::params::oraWlsPassword,
  $oraNodeManagerPort    = $weblogic::params::oraNodeManagerPort,
  $oraWlsDevMode         = $weblogic::params::oraWlsDevMode,
  $oraLogOutput          = $weblogic::params::oraLogOutput,
  $jdkHome               = $weblogic::params::jdkHome,
  $wlsCustomTrust        = $weblogic::params::wlsCustomTrust,
  $wlsTrustKeystoreFile  = $weblogic::params::wlsTrustKeystoreFile,
  $wlsTrustKeystorePassphrase = $weblogic::params::wlsTrustKeystorePassphrase

  ) inherits weblogic::params {

  class {'weblogic::os':
    oraUser       => $oraUser,
    oraGroup      => $oraGroup,
    oraLogs       => $oraLogs,
    osSwapSize    => 1024,
    sshPrivateKey => 'puppet:///modules/weblogic/ssh/id_rsa',
    sshPublicKey  => 'puppet:///modules/weblogic/ssh/id_rsa.pub',
  } contain 'weblogic::os'

  $is64bit = $::hardwaremodel ? {
    x86_64  => true,
    default => false,
  }

  class {'weblogic::java':
    version                   => '7u51',
    fullVersion               => 'jdk1.7.0_51',
    downloadDir               => $downloadDir,
    cryptographyExtensionFile => 'UnlimitedJCEPolicyJDK7.zip',
    sourcePath                => $sourcePath,
    x64                       => $is64bit,
    require                   => Class[Weblogic::Os],
  } contain 'weblogic::java'

  # this seem like a duplication of the jdk7::install urandomJavaFix option
  #contain orawls::urandomfix

  class {'orautils':
    osOracleHomeParam       => $oraHome,
    oraInventoryParam       => "${oraHome}/oraInventory",
    osLogFolderParam        => $oraLogs,
    osDomainTypeParam       => 'web', # ??
    osDownloadFolderParam   => "${oraHome}/install", # ??
    osDomainParam           => $oraDomain,
    osMdwHomeParam          => $oraMdwHome,
    osDomainPathParam       => "${oraDomainRoot}/${oraDomain}",
    nodeMgrPathParam        => "${oraDomainRoot}/${oraDomain}/bin",
    nodeMgrAddressParam     => $oraAdminServerName,
    wlsUserParam            => $oraWlsUser,
    wlsPasswordParam        => $oraWlsPassword,
    wlsAdminServerParam     => $oraAdminServerName,
    customTrust             => $wlsCustomTrust,
    trustKeystoreFile       => $wlsTrustKeystoreFile,
    trustKeystorePassphrase => $wlsTrustKeystorePassphrase,
    require                 => Class[orawls::weblogic],
  } contain 'orautils'

  class {'orawls::weblogic':
    version              => $oraVersion,
    filename             => 'fmw_12.1.3.0.0_wls.jar',
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
    oraVersion            => $oraVersion,
    wlsHome               => $wlsHome,
    oraMdwHome            => $oraMdwHome,
    jdkHome               => $jdkHome,
    oraWlsDomainTemplate  => $oraWlsDomainTemplate,
    oraDomain             => $oraDomain,
    oraWlsDevMode         => $oraWlsDevMode,
    oraAdminServerName    => $oraAdminServerName,
    oraAdminServerAddress => $oraAdminServerAddress,
    oraAdminServerPort    => $oraAdminServerPort,
    oraNodeManagerAddress => $oraAdminServerAddress,
    oraNodeManagerPort    => $oraNodeManagerPort,
    #java_arguments       => { "ADM"                  => "...", "OSB" => "...", "SOA" => "...", "BAM" => "..."},
    oraWlsUser            => $oraWlsUser,
    oraWlsPassword        => $oraWlsPassword,
    oraUser               => $oraUser,
    oraGroup              => $oraGroup,
    oraLogs               => $oraLogs,
    downloadDir           => $downloadDir,
    oraLogOutput          => $oraLogOutput,
    require               => Class[orawls::weblogic],
  } contain 'weblogic::domain'

  class {'weblogic::nodemanager':
    oraVersion                 => $oraVersion,
    wlsHome                    => $wlsHome,
    oraMdwHome                 => $oraMdwHome,
    jdkHome                    => $jdkHome,
    oraAdminServerAddress      => $oraAdminServerAddress,
    oraNodeManagerPort         => $oraNodeManagerPort,
    oraDomain                  => $oraDomain,
    oraUser                    => $oraUser,
    oraGroup                   => $oraGroup,
    oraLogs                    => $oraLogs,
    downloadDir                => $downloadDir,
    oraLogOutput               => $oraLogOutput,
    wlsCustomTrust             => $wlsCustomTrust,
    wlsTrustKeystoreFile       => $wlsTrustKeystoreFile,
    wlsTrustKeystorePassphrase => $wlsTrustKeystorePassphrase,
    require                    => Class[weblogic::domain],
  } contain 'weblogic::nodemanager'

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
