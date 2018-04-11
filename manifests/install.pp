# @api private
# Installs LibreOffice.
# It is intended to be called by libreoffice::libreoffice.
#
# @param majorver [Integer] major LibreOffice version.
#
# @param minorver [Integer] minor LibreOffice version.
#
# @param incr [Integer] incremental LibreOffice version.
#
# @param subincr [Integer] sub-incremental LibreOffice incremental version.
#             This is the suffix to the full version found in the main directory
#             when unpacking the distribution.
#
# == Actions:
#
# Download the distribution of the main installer under <tt>/tmp</tt>,
# and installs all <tt>.deb</tt>.
class libreoffice::install ($majorver, $minorver, $incr, $subincr) {
  $version = "${majorver}.${minorver}.${incr}"
  $dist = "LibreOffice_${version}_Linux_x86-64_deb"
  $inst_folder = "LibreOffice_${version}.${subincr}_Linux_x86-64_deb"

  download_uncompress { 'dwnl_inst_libreoffice':
    distribution_name => "${dist}.tar.gz",
    dest_folder       => '/tmp',
    creates           => "/opt/libreoffice${majorver}.${minorver}",
    uncompress        => 'tar.gz',
  }

  exec { 'install_libreoffice':
    command   => "dpkg -i *.deb",
    cwd       => "/tmp/${inst_folder}/DEBS",
    creates   => "/opt/libreoffice${majorver}.${minorver}",
    require   => Download_uncompress['dwnl_inst_libreoffice'],
    logoutput => 'on_failure',
  }
}