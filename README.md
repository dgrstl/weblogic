#dgrstl-weblogic

A profile class based on https://github.com/biemond/biemond-orawls
optimized for linux and removing requirements for hiera

##Software Requirements
Used the following software (downloaded separately)
  All three files should be in a directory in set by the
  $sourcePath param

###Java
  - jdk-7u51-linux-x64.tar.gz   (`$jdkVersion` param)

###weblogic 12.1.3
  - fmw_12.1.3.0.0_wls.jar      (`$oraInstaller` param)
  - UnlimitedJCEPolicyJDK7.zip  (`$jdkCryptoExtFile` param)

##Usage
  Classify a node with weblogic::admin.

##Limitations
  This is has only been lightly testest on CentOS 65

Please log tickets and issues at our [Projects site](https://github.com/dgrstl/weblogic)
