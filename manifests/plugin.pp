# == Type: vagrant::plugin
#
# Install vagrant plugins (https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Plugins)
#
# === Parameters
#
# [*plugin*]
#   The name of the plugin (namevar).
#
# [*version*]
#   Specific version of the plugin you want to install. Defaults to the current plugin version.
#
# [*pre_release*]
#   Allow to install prerelease versions of this plugin.
#
# [*source*]
#   Use a custom RubyGems repository.
#
# [*entry_point*]
#   The name of the entry point file for loading the plugin.
#
# [*ensure*]
#   What to do with the plugin. Possible values: "present", "installed", "absent" or "uninstalled"
#
# === Examples
#
#  # Install current version
#  vagrant::plugin { 'vagrant-hostmanager': }
#
#  # Install specific version
#  vagrant::plugin { 'vagrant-hostmanager':
#    version => 0.8.0
#  }
#
#  # Install a pre-release version
#  vagrant::plugin { 'vagrant-hostmanager':
#    pre_release => true
#  }
#
define vagrant::plugin (
  $plugin      = $title,
  $version     = undef,
  $pre_release = false,
  $source      = undef,
  $entry_point = undef,
  $ensure      = present
) {

  include vagrant

  $grep = $::operatingsystem ? {
    windows => 'findstr',
    default => 'grep'
  }
  $check = "vagrant plugin list | ${grep} \"^${plugin} \""

  case $ensure {
    present, installed: {
      exec { "vagrant plugin install ${plugin}":
        unless => $check,
        path   => $::path
      }
    }
    absent, uninstalled: {
      exec { "vagrant plugin uninstall ${plugin}":
        onlyif => $check,
        path   => $::path
      }
    }
    default: { fail("Unrecognized value for ensure: ${ensure}") }
  }

}
