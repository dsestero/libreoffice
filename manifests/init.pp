# = Class: libreoffice
#
# Installs and set up a service for libreoffice listening on port 8100.
#
# == Parameters:
#
# $libreoffice_vers:: Full three number LibreOffice version.
#
# $libreoffice_incr:: LibreOffice incremental version. This is the suffix to the full version found in the main directory when unpacking the distribution.
#
# == Actions:
#
# Declares all other classes in the jboss module needed for installing LibreOffice. 
# Currently, these consists of libreoffice::install, and libreoffice::service.
#
# == Requires:
# none
#
# == Sample usage:
#
#  class {'libreoffice': libreoffice_vers => '4.1.3', libreoffice_incr => '.2',}
class libreoffice ($libreoffice_vers, $libreoffice_incr) {
  class {'libreoffice::install':
    libreoffice_vers => $libreoffice_vers,
    libreoffice_incr => $libreoffice_incr,
  } ~> class {'libreoffice::service':}
}
