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
# class {'libreoffice': 
#   majorver => '4',
#   minorver => '1',
#   incr => '3',
#   subincr => '2',
# }
class libreoffice ($majorver, $minorver, $incr, $subincr) {
  class {'libreoffice::install':
    majorver => $majorver,
    minorver => $minorver,
    incr => $incr,
    subincr => $subincr,
    baseurl => 'http://jee.invallee.it/dist',
  } ~> class {'libreoffice::service':}
}
