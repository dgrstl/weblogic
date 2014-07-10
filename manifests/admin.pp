class weblogic::admin (

  $oraHome       = $weblogic::params::oraHome,
  $oraMdwHome    = $weblogic::params::oraMdwHome,
  $oraDomain     = $weblogic::params::oraDomain,
  $oraDomainRoot = $weblogic::params::oraDomain,
  $oraLogs       = $weblogic::params::oraLogs,
  $oraUser       = $weblogic::params::oraUser,
  $oraGroup      = $weblogic::params::oraGroup,
  $sourcePath    = $weblogic::params::sourcePath,
  $downloadDir   = $weblogic::params::downloadDir,

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
    nodeMgrAddressParam     => 'centos65a',
    wlsPasswordParam        => 'weblogic1',
    wlsAdminServerParam     => 'AdminServer',
    customTrust             => true,
    trustKeystoreFile       => 'puppet:///modules/weblogic/oracle/truststore.jks',
    trustKeystorePassphrase => 'welcome',
    require                 => Class[orawls::weblogic],
  } contain 'orautils'

  class {'orawls::weblogic':
    version              => '1213',
    filename             => 'fmw_12.1.3.0.0_wls.jar',
    jdk_home_dir         => '/usr/java/latest',
    oracle_base_home_dir => $oraHome,
    middleware_home_dir  => $oraMdwHome,
    os_user              => $oraUser,
    os_group             => $oraGroup,
    download_dir         => $downloadDir,
    source               => $sourcePath,
    log_output           => true,
    require              => Class[weblogic::java],
  } contain 'orawls::weblogic'

  #include fmw
  #include opatch
  #include domains
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
