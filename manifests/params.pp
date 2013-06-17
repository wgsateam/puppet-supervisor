class supervisor::params {
  case $::operatingsystem {
    'ubuntu','debian': {
      $conf_file      = '/etc/supervisor/supervisord.conf'
      $conf_dir       = '/etc/supervisor/conf.d'
      $system_service = 'supervisor'
      $package        = 'supervisor'
    }
    'centos','fedora','redhat': {
      $conf_file      = '/etc/supervisord.conf'
      $conf_dir       = '/etc/supervisord.d'
      $system_service = 'supervisord'
      $package        = 'supervisor3'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }

  ### miguno: DIRTY HACK to allow us to run supervisord 3.x on RHEL/CentOS 6
  package { "supervisor3":
    ensure   => latest,
    source   => "https://s3.amazonaws.com/cdn.michael-noll.com/rpms/supervisor-3.0b2.el6.x86_64.rpm",
    provider => rpm,
    require  => Package["python-setuptools"],
  }

  package { "python-setuptools":
    ensure   => latest,
  }

}
