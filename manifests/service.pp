# = Class: libreoffice::service
#
# Sets up a service for an headless LibreOffice.
# It is intended to be called by libreoffice::libreoffice.
class libreoffice::service {

  service { 'soffice.bin':
    ensure     => running,
    hasstatus  => false,
    hasrestart => false,
    enable     => true,
  }

}