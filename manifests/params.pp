class supervisor::params {
  case $::operatingsystem {
    'ubuntu','debian': {
      $conf_file      = '/etc/supervisor/supervisord.conf'
      $conf_dir       = '/etc/supervisor/conf.d'
      $system_service = 'supervisor'
      $package        = 'supervisor'
    }
    'centos','fedora','redhat','Amazon', 'OracleLinux': {
      $conf_file      = '/etc/supervisord.conf'
      $conf_dir       = '/etc/supervisord.d'
      $system_service = 'supervisord'
      $package        = 'supervisor'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
  $conf_dir_extra = lookup('supervisor::params::conf_dir', String, 'first', '')
  if $conf_dir_extra.empty() {
    $conf_dir_str = regsubst("${conf_dir}/*.conf", '//', '/')
  } else {
    $conf_dir_str = regsubst("${conf_dir}/*.conf ${conf_dir_extra}/*.conf", '//', '/')
  }
}
