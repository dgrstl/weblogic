class weblogic::java {
  require weblogic::os

  $remove = [ 'java-1.7.0-openjdk.x86_64', 'java-1.6.0-openjdk.x86_64' ]

  package { $remove:
    ensure  => absent,
  }

  include jdk7

  jdk7::install7{ 'jdk1.7.0_51':
      version                   => '7u51' , 
      fullVersion               => 'jdk1.7.0_51',
      alternativesPriority      => 18000, 
      x64                       => true,
      downloadDir               => '/var/tmp/install',
      urandomJavaFix            => true,
      rsakeySizeFix             => true,
      cryptographyExtensionFile => 'UnlimitedJCEPolicyJDK7.zip',
      sourcePath                => '/vagrant/weblogic-software',
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
define javaexec_debug() {
  exec { "patch java to log all executions on $title":
    command => "/bin/mv ${title} ${title}_ && /bin/cp /vagrant/puppet/files/java_debug ${title} && /bin/chmod +x ${title}", 
    unless  => "/usr/bin/test -f ${title}_",
  }
}
