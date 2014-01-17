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
# $baseurl::  Base url from which to download the distribution.
#
# $language:: Language of the locale that will be installed among the supported locales on the server and will be set for the +LANG+ system variable.
#
# $country::  Country of the locale that will be installed among the supported locales on the server and will be set for the +LANG+ system variable.
#
# == Actions:
#
# Declares all other classes in the libreoffice module needed for installing LibreOffice and sets up the desired server locale. 
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
# }
class libreoffice ($majorver, $minorver, $incr, $subincr, $baseurl = 'http://jee.invallee.it/dist', $language, $country) {
  class {'libreoffice::install':
    majorver => $majorver,
    minorver => $minorver,
    incr => $incr,
    subincr => $subincr,
    baseurl => $baseurl,
  }  -> class {'libreoffice::config': language => $language, country => $country} ~> class {'libreoffice::service':}
}
