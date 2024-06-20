class supervisor::params {
  case $::operatingsystem {
    'ubuntu','debian': {
      $conf_file        = '/etc/supervisor/supervisord.conf'
      $conf_dir_default = '/etc/supervisor/conf.d'
      $system_service   = 'supervisor'
      $package          = 'supervisor'
    }
    'centos','fedora','redhat','Amazon', 'OracleLinux': {
      $conf_file        = '/etc/supervisord.conf'
      $conf_dir_default = '/etc/supervisord.d'
      $system_service   = 'supervisord'
      $package          = 'supervisor'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
  $conf_dir = lookup('supervisor::params::conf_dir', String, 'first', $conf_dir_default)
}
