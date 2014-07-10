class weblogic::admin {
  include weblogic::os
  include weblogic::ssh
  include weblogic::java, orawls::urandomfix
  include orautils

  class {'orawls::weblogic':
    version               => 1213,
    filename              => 'fmw_12.1.3.0.0_wls.jar',
    jdk_home_dir          => '/usr/java/latest',
    oracle_base_home_dir  => '/opt/oracle',
    middleware_home_dir   => '/opt/oracle/middleware12c',
    os_user               => 'oracle',
    os_group              => 'dba',
    download_dir          => '/var/tmp/install',
    source                => '/vagrant/weblogic-software',
    log_output            => true,
  }


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

  Class[weblogic::java] -> Class[orawls::weblogic]
}  
