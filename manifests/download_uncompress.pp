# = Define: libreoffice::download_uncompress
#
# Downloads and possibly unzip a file from a specified url to a destination folder.
#
# == Parameters:
#
# $download_url::   URL from which to download.
#
# $dest_folder::    Destination folder.
#
# $creates::        Folder created after downloading and possibly unzipping, useful to make the resource type idempotent.
#
# $uncompress::     +true+ if the downloaded file is a .zip that has to be unzipped in +dest_folder+.
#                   Defaults to +false+.
#
# == Actions:
#
# Performs a wget from the specified url and possibly unzip the downloaded file into the destination folder.
#
# == Requires:
# none
#
# == Sample usage:
#
# libreoffice::download_uncompress {'dwnl_inst_libreoffice':
#   download_url  => "http://jee.invallee.it/dist/${dist}.tar.gz",
#   dest_folder   => '/tmp',
#   creates       => "/tmp/${inst_folder}",
#   uncompress    => 'tar.gz',
# }
define libreoffice::download_uncompress (
  $download_url,
  $dest_folder,
  $creates,
  $uncompress = false,
  $user = root,
  $group = root,
  
) {
  
    $cmd = $uncompress ? {
      'zip'     => "wget -P /tmp/ ${download_url} -O /tmp/dist.zip && unzip /tmp/dist.zip -d ${dest_folder}",
      'tar.gz'  => "wget -P /tmp/ ${download_url} -O /tmp/dist.tar.gz && tar xzf /tmp/dist.tar.gz -C ${dest_folder}",
      default   => "wget -P ${dest_folder} ${download_url}",
    }
    
	  exec {"download_uncompress_${download_url}-${dest_folder}":
	    command => "${cmd}",
	    creates => "${creates}",
	    user    => $user,
	    group   => $group,
	    logoutput => 'on_failure',
	  }
}