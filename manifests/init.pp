# This module installs and set up a service for libreoffice listening on port 8100.
#
# This class declares all other classes in the libreoffice module needed for installing LibreOffice.
#
# @param majorver [Integer] major LibreOffice version.
#
# @param minorver [Integer] minor LibreOffice version.
#
# @param incr [Integer] incremental LibreOffice version.
#
# @param subincr [Integer] sub-incremental LibreOffice incremental version.
#   This is the suffix to the full version found in the main directory when unpacking the distribution.
#
# @param language [String] language of the locale to be used by the LibreOffice service.
#
# @param country [String] country of the locale to be used by the LibreOffice service.
#
# @example Declaring in manifest
#   class {'libreoffice':
#     majorver => '5',
#     minorver => '4',
#     incr     => '6',
#     subincr  => '2',
#     locale   => 'it_IT',
#   }
#
# @author Dario Sestero
class libreoffice ($majorver, $minorver, $incr, $subincr, $language, $country) {
  class { 'libreoffice::install':
    majorver => $majorver,
    minorver => $minorver,
    incr     => $incr,
    subincr  => $subincr,
  } -> class { 'libreoffice::config':
    majorver => $majorver,
    minorver => $minorver,
    language => $language,
    country  => $country,
  } ~> class { 'libreoffice::service':
  }
}