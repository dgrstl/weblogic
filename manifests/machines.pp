class weblogic::machines
(
    $wlsNodeManagerPort    = $weblogic::params::wlsNodeManagerPort
  ) inherits weblogic::params {

  require orawls::weblogic, weblogic::domain, weblogic::nodemanager,
    weblogic::startwls

  Wls_machine {
    ensure      => present,
    listenport  => $wlsNodeManagerPort,
    machinetype => 'UnixMachine',
    nmtype      => 'SSL',
  }

  wls_machine {'centos65b':
    listenaddress => 'centos65b',
  }
}
