class weblogic::managed_servers
(
    $oraLogs               = $weblogic::params::oraLogs,
    $wlsServerPort         = $weblogic::params::wlsServerPort,
    $wlsSSLServerPort      = $weblogic::params::wlsSSLServerPort,
  ) inherits weblogic::params {
  require orawls::weblogic, weblogic::domain, weblogic::nodemanager,
    weblogic::startwls

  Wls_server {
    ensure                         => present,
    listenport                     => $wlsServerPort,
    log_file_min_size              => '2000',
    log_filecount                  => '10',
    log_number_of_files_limited    => '1',
    log_rotate_logon_startup       => '1',
    log_rotationtype               => 'bySize',
    sslenabled                     => '0',
    #sslhostnameverificationignored => '1',
    #ssllistenport                  => $wlsSSLServerPort,
  }

  wls_server { 'default/centos65b':
      jsseenabled                    => '0',
      listenaddress                  => 'centos65b',
      arguments                      => "-XX:PermSize=256m -XX:MaxPermSize=256m -Xms752m -Xmx752m -Dweblogic.Stdout=${oraLogs}/wlsServer2.out -Dweblogic.Stderr=${oraLogs}/wlsServer2_err.out",
      logfilename                    => "${oraLogs}/wlsServer2.log",
      machine                        => 'centos65b',
  }
}
