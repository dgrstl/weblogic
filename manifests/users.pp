class weblogic::users
(
    $wlsAthProvider        = $weblogic::params::wlsAthProvider,
    $wlsRealm              = $weblogic::params::wlsRealm,
    $wlsPassword           = $weblogic::params::wlsPassword,
  ) {
  require orawls::weblogic, weblogic::domain, weblogic::nodemanager,
    weblogic::startwls

  Wls_user {
    ensure                 => present,
    authenticationprovider => $wlsAthProvider,
    realm                  => $wlsRealm,
    password               => $wlsPassword,
  }

  wls_user {'test1':
    description            => 'test1 user',
  }

  wls_user {'test2':
    description            => 'test2 user',
  }
}
