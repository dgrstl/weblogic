class weblogic::java (
    $jdkVersion                   = $weblogic::params::jdkVersion,
    $jdkFullVersion               = $weblogic::params::jdkVersion,
    $downloadDir                  = $weblogic::params::downloadDir,
    $jdkCryptographyExtensionFile = $weblogic::params::jkdCryptoExtFile,
    $sourcePath                   = $weblogic::params::sourcePath,
    $jdkURandomJavaFix            = $weblogic::params::jdkURandomJavaFix,
    $jdkRsakeySizeFix             = $weblogic::params::jdkRsaKeySizeFix,
    $jdkAlternativesPriority      = $weblogic::params::jdkAlternativesPriority,
  ) inherits weblogic::params {

  require weblogic::os

  $is64bit = $::hardwaremodel ? {
    x86_64  => true,
    default => false,
  }

  $remove = [ 'java-1.7.0-openjdk.x86_64', 'java-1.6.0-openjdk.x86_64' ]

  package { $remove:
    ensure  => absent,
  }

  jdk7::install7{ $jdkFullVersion :
      version                   => $jdkVersion,
      fullVersion               => $jdkFullVersion,
      alternativesPriority      => $jdkAlternativesPriority,
      x64                       => $is64bit,
      downloadDir               => $downloadDir,
      urandomJavaFix            => $jdkUrandomJavaFix,
      rsakeySizeFix             => $jdkRsakeySizeFix,
      cryptographyExtensionFile => $jdkCryptographyExtensionFile,
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
