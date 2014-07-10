class weblogic::java (
    $version                    = undef,
    $fullVersion                = undef,
    $downloadDir                = undef,
    $cryptographyExtensionFile  = undef,
    $sourcePath                 = undef,
    $urandomJavaFix             = true,
    $rsakeySizeFix              = true,
    $alternativesPriority       = 18000,
    $x64                        = undef,
  ) inherits weblogic::params {

  $remove = [ 'java-1.7.0-openjdk.x86_64', 'java-1.6.0-openjdk.x86_64' ]

  package { $remove:
    ensure  => absent,
  }

  #contain jdk7

  jdk7::install7{ 'jdk1.7.0_51':
      version                   => $version,
      fullVersion               => $fullVersion,
      alternativesPriority      => $alternativesPriority,
      x64                       => $x64,
      downloadDir               => $downloadDir,
      urandomJavaFix            => $urandomJavaFix,
      rsakeySizeFix             => $rsakeySizeFix,
      cryptographyExtensionFile => $cryptographyExtensionFile,
      sourcePath                => $sourcePath,
  }
  # ->
  # file { $LOG_DIR:
  #   ensure  => directory,
  #   mode    => '0777',
  # }
  # ->
  # file { "$LOG_DIR/log.txt":
  #   ensure  => file,
  #   mode    => '0666'
  # }
  # ->
  # javaexec_debug {$javas: }
  # ->
  # exec { 'java_debug start provisioning':
  #   command => "${javas[0]} -version '+++ start provisioning +++'"
  # }
}

# log all java executions:
#define javaexec_debug() {
#  exec { "patch java to log all executions on ${title}":
#    command => "/bin/mv ${title} ${title}_ && /bin/cp /vagrant/puppet/files/java_debug ${title} && /bin/chmod +x ${title}",
#    unless  => "/usr/bin/test -f ${title}_",
#  }
#}
