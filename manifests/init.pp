# == Class: vagrant
#
# Install vagrant using the vagrant packages from http://downloads.vagrantup.com/
#
# === Parameters
#
# [*git_hash*]
#   The git hash for the specific version of vagrant you want to install.  The
#   way to figure out what this hash is, go to downloads.vagrantup.com, select
#   the version you want to install, look at the URL and it will be of the form
#   http://files.vagrantup.com/packages/${git_hash}/the_package.rpm, and you
#   want the hash from that URL.  Example: '7ec0ee1d00a916f80b109a298bab08e391945243'
#
# [*version*]
#   The version of the package you want to install. Example: '1.3.5'
#
# === Examples
#
#  # Install version 1.3.5
#  include vagrant
#
#  # Install version 1.3.4
#  class { 'vagrant':
#    git_hash => '0ac2a87388419b989c3c0d0318cc97df3b0ed27d',
#    version  => '1.3.4'
#  }
#
class vagrant ($git_hash = 'a40522f5fabccb9ddabad03d836e120ff5d14093', $version = '1.3.5') {
  $base_url = "http://files.vagrantup.com/packages/${git_hash}"

  case $::operatingsystem {
    centos, redhat, fedora: {
      case $::architecture {
        x86_64, amd64: {
          $vagrant_url = "${base_url}/vagrant_${version}_x86_64.rpm"
          $vagrant_provider = 'rpm'
        }
        i386: {
          $vagrant_url = "${base_url}/vagrant_${version}_i686.rpm"
          $vagrant_provider = 'rpm'
        }
        default: {
          fail("Unrecognized architecture: ${::architecture}")
        }
      }
    }
    debian, ubuntu: {
      case $::architecture {
        x86_64, amd64: {
          $vagrant_url = "${base_url}/vagrant_${version}_x86_64.deb"
          $vagrant_provider = 'apt'
        }
        i386: {
          $vagrant_url = "${base_url}/vagrant_${version}_i686.deb"
          $vagrant_provider = 'apt'
        }
        default: {
          fail("Unrecognized architecture: ${::architecture}")
        }
      }
    }
    darwin: {
      $vagrant_url = "${base_url}/Vagrant-${version}.dmg"
      $vagrant_provider = 'pkgdmg'
    }
    windows: {
      $vagrant_url = "${base_url}/Vagrant_${version}.msi"
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
