class weblogic::groups
(
    $wlsAthProvider        = $weblogic::params::wlsAthProvider,
    $wlsRealm              = $weblogic::params::wlsRealm,
  ) inherits weblogic::params {
  require weblogic::users

  Wls_group {
    ensure                 => present,
    authenticationprovider => $wlsAthProvider,
    realm                  => $wlsRealm,
  }

  wls_group {'TestGroup':
    description => 'TestGroup',
    users       => ['testuser1','testuser2'],
  }

  wls_group {'SuperUsers':
    description => 'SuperUsers',
    users       => ['testuser1'],
  }
}
