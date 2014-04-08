# = Class: libreoffice::config
#
# Configure LibreOffice.
# It is intended to be called by libreoffice::libreoffice.
#
# == Parameters:
# none
#
# == Actions:
#
# Download the distribution of the main installer from the base url provided under <tt>/tmp</tt>,
# and installs all <tt>.deb</tt>.
#
class libreoffice::config {
  file { '/opt/libreoffice':
    ensure => link,
    target => '/opt/libreoffice4.1',
  }

  # Init script
  file { '/etc/init.d/libreofficed':
    ensure => present,
    source => "puppet:///modules/${module_name}/libreofficed",
    owner  => root,
    group  => root,
    mode   => 0755,
  }

  file { '/opt/soffice.bin':
    ensure => present,
    source => "puppet:///modules/${module_name}/soffice.bin",
    owner  => root,
    group  => root,
    mode   => 0755,
  }
}