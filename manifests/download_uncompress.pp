# = Define: libreoffice::download_uncompress
#
# Downloads and possibly unzip a file from a specified url to a destination folder.
#
# == Parameters:
#
# $download_url::   URL from which to download.
#
# $dest_folder::    Destination folder where to unzip (or possibly only download) the distribution.
#
# $creates::        Folder created after downloading and possibly unzipping, useful to make the resource type idempotent.
#
# $uncompress::     Specify the type of compression used by the distribution or if no uncompression is needed.
#                   Possible values are <tt>zip</tt>, <tt>tar.gz</tt>. Any other value is interpreted as no uncompression needed.
#                   Defaults to +false+.
#
# $user::           user to be used when performing the download and the eventual uncompression.
#                   Defaults to +root+.
#
# $group::          group to be used when performing the download and the eventual uncompression.
#                   Defaults to +root+.
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