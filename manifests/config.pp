# @api private
# Configures LibreOffice.
# It is intended to be called by libreoffice::libreoffice.
#
# @param majorver [Integer] major LibreOffice version.
#
# @param minorver [Integer] minor LibreOffice version.
#
# @param language [String] language of the locale to be used by the LibreOffice service.
#
# @param country [String] country of the locale to be used by the LibreOffice service.
#
# == Actions:
#
# Download the distribution of the main installer from the base url provided under <tt>/tmp</tt>,
# and installs all <tt>.deb</tt>.
class libreoffice::config ($majorver, $minorver, $language, $country) {
  file { '/opt/libreoffice':
    ensure => link,
    target => "/opt/libreoffice${majorver}.${minorver}",
  }

  file {
    default:
      ensure => present,
      owner  => root,
      group  => root,
      ;
    '/etc/init.d/libreofficed':
      source => "puppet:///modules/${module_name}/libreofficed",
      mode   => '0755',
      ;
    '/opt/soffice.bin':
      source => "puppet:///modules/${module_name}/soffice.bin",
      mode   => '0755',
      ;
    '/etc/default/soffice.bin':
      content => template("${module_name}/soffice.bin.erb"),
      mode    => '0644',
      ;
  }
}