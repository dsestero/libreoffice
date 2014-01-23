# = Class: libreoffice::config
#
# Configure LibreOffice.
# It is intended to be called by libreoffice::libreoffice.
#
# == Parameters:
#
# $language:: Language of the locale that will be installed among the supported locales on the server and will be set for the +LANG+
# system variable.
#
# $country::  Country of the locale that will be installed among the supported locales on the server and will be set for the +LANG+
# system variable.
#
# == Actions:
#
# Download the distribution of the main installer from the base url provided under <tt>/tmp</tt>,
# and installs all <tt>.deb</tt>.
#
class libreoffice::config ($language, $country) {
  
  package { "language-pack-${language}": ensure => present, }

  file { '/etc/default/locale':
    ensure  => present,
    content => "LANG=\"${language}_${country}.UTF-8\"\n",
  }

  exec { "add_supported_locale_${language}_${country}":
    command => "echo '${language}_${country}.UTF-8 UTF-8' >> /var/lib/locales/supported.d/local && dpkg-reconfigure locales",
    unless  => "grep ${language}_${country} /var/lib/locales/supported.d/local",
    require => Package["language-pack-${language}"],
  }

  file { '/opt/libreoffice':
    ensure => link,
    target => '/opt/libreoffice4.1',
  }

  # Init script
  file { '/etc/init.d/libreofficed':
    source => "puppet:///modules/${module_name}/libreofficed",
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 0755,
  }

  file { '/opt/soffice.bin':
    source => "puppet:///modules/${module_name}/soffice.bin",
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 0755,
  }
}