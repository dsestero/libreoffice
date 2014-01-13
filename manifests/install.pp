# = Class: libreoffice::install
#
# Installs LibreOffice-4.1.1.
# It is intended to be called by libreoffice::libreoffice.
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
# == Actions:
#
# Download the distribution of the main installer from the base url provided under <tt>/tmp</tt>, 
# and installs all <tt>.deb</tt>.
#
# == Sample usage:
#
#  class {'libreoffice::install': libreoffice_vers => '4.1.3', libreoffice_incr => '.2',}
class libreoffice::install ($majorver, $minorver, $incr, $subincr, $baseurl) {
  
  $version = "${majorver}.${minorver}.${incr}"
  $dist = "LibreOffice_${version}_Linux_x86-64_deb"
  $inst_folder = "LibreOffice_${version}.${subincr}_Linux_x86-64_deb"
    
   common::download_uncompress {'dwnl_inst_libreoffice':
    download_url  => "${baseurl}/${dist}.tar.gz",
    dest_folder   => '/tmp',
    creates       => "/tmp/${inst_folder}",
    uncompress    => 'tar.gz',
  }
  
  exec {'install_libreoffice':
    command => "dpkg -i *.deb",
    cwd     => "/tmp/${inst_folder}/DEBS",
    creates => "/opt/libreoffice${majorver}.${minorver}",
    require => Common::Download_uncompress['dwnl_inst_libreoffice'],
    logoutput => 'on_failure',
  }
  
  file {'/opt/libreoffice':
    ensure  => link,
    target  => '/opt/libreoffice4.1',
  }
  
  # Init script
  file {'/etc/init.d/soffice.bin':
    source  => "puppet:///modules/${module_name}/soffice.bin.init",
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0755,
  }

  file {'/opt/soffice.bin':
    source  => "puppet:///modules/${module_name}/soffice.bin",
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0755,
  }
}