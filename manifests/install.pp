# = Class: libreoffice::install
#
# Installs LibreOffice-4.1.1.
# It is intended to be called by libreoffice::libreoffice.
#
# == Parameters:
#
# $libreoffice_vers:: Full three number LibreOffice version.
#
# $libreoffice_incr:: LibreOffice incremental version. This is the suffix to the full version found in the main directory when unpacking the distribution.
#
# == Actions:
#
# Download the distribution of the main installer from the source under <tt>/opt</tt>, 
# and installs all <tt>.deb</tt>.
#
# == Sample usage:
#
#  class {'libreoffice::install': libreoffice_vers => '4.1.3', libreoffice_incr => '.2',}
class libreoffice::install ($libreoffice_vers, $libreoffice_incr) {

  $libreoffice_dist = "LibreOffice_${libreoffice_vers}_Linux_x86-64_deb"
  $libreoffice_inst_folder = "LibreOffice_${libreoffice_vers}${libreoffice_incr}_Linux_x86-64_deb"
    
  Exec {
    logoutput => 'on_failure',
  }

  exec {'download_libreoffice':
    command => "wget -P /tmp/ http://download.documentfoundation.org/libreoffice/stable/${libreoffice_vers}/deb/x86_64/${libreoffice_dist}.tar.gz",
    creates => "/tmp/${libreoffice_dist}.tar.gz",
  }
  
  exec {'uncompress_libreoffice':
    command => "tar xzf /tmp/${libreoffice_dist}.tar.gz -C /tmp",
    creates => "/tmp/${libreoffice_inst_folder}",
    require => Exec['download_libreoffice'],
  }
  
  exec {'install_libreoffice':
    command => "dpkg -i *.deb",
    cwd     => "/tmp/${libreoffice_inst_folder}/DEBS",
    creates => '/opt/libreoffice4.1',
    require => Exec['uncompress_libreoffice'],
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