# Install vagrant
class vagrant {
  case $::operatingsystem {
    centos, redhat: {
      case $::architecture {
        x86_64: {
          $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_x86_64.rpm'
          $vagrant_provider = 'rpm'
        }
        i386: {
          $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_i686.rpm'
          $vagrant_provider = 'rpm'
        }
        default: {
          fail("Unrecognized architecture: ${::architecture}")
        }
      }
    }
    debian, ubuntu: {
      case $::architecture {
        x86_64: {
          $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_x86_64.deb'
          $vagrant_provider = 'apt'
        }
        i386: {
          $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_i686.deb'
          $vagrant_provider = 'apt'
        }
        default: {
          fail("Unrecognized architecture: ${::architecture}")
        }
      }
    }
    darwin: {
      $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/Vagrant-1.2.2.dmg'
      $vagrant_provider = 'pkgdmg'
    }
    windows: {
      $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/Vagrant_1.2.2.msi'
      $vagrant_provider = 'msi'
    }
    default: {
      fail("Unrecognized operating system: ${::operatingsystem}")
    }
  }

  package { 'vagrant':
    ensure   => installed,
    source   => $vagrant_url,
    provider => $vagrant_provider
  }
}
