# = Class: libreoffice
#
# Installs and set up a service for libreoffice listening on port 8100.
#
# == Parameters:
#
# $majorver:: Major LibreOffice version.
#
# $minorver:: Minor LibreOffice version.
#
# $incr::     Incremental LibreOffice version.
#
# $subincr::  Sub-incremental LibreOffice incremental version.
#             This is the suffix to the full version found in the main directory when unpacking the distribution.
#
# $language:: Language of the locale to be used by the LibreOffice service.
#
# $country::  Country of the locale to be used by the LibreOffice service.
#
# == Actions:
#
# Declares all other classes in the libreoffice module needed for installing LibreOffice.
#
# == Requires:
# none
#
# == Sample usage:
#
# class {'libreoffice':
#   majorver => '4',
#   minorver => '1',
#   incr     => '3',
#   subincr  => '2',
#   locale   => 'it_IT',
#}
class libreoffice ($majorver, $minorver, $incr, $subincr, $language, $country) {
  class { 'libreoffice::install':
    majorver => $majorver,
    minorver => $minorver,
    incr     => $incr,
    subincr  => $subincr,
  } -> class { 'libreoffice::config':
    language => $language,
    country  => $country,
  } ~> class { 'libreoffice::service':
  }
}