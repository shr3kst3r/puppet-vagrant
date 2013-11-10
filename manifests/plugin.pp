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
# [*prerelease*]
#   Allow to install prerelease versions of this plugin.
#
# [*source*]
#   Use a custom RubyGems repository.
#
# [*entry_point*]
#   The name of the entry point file for loading the plugin.
#
# [*home*]
#   The home directory of the user to install the plugin for.
#
# [*ensure*]
#   What to do with the plugin. Possible values: "present", "installed", "absent" or "uninstalled"
#
# === Examples
#
#  # Install current version
#  vagrant::plugin { 'vagrant-hostmanager':
#    home => '/home/myuser'
#  }
#
#  # Install specific version
#  vagrant::plugin { 'vagrant-hostmanager':
#    home    => '/home/myuser',
#    version => 0.8.0
#  }
#
#  # Install a pre-release version
#  vagrant::plugin { 'vagrant-hostmanager':
#    home       => '/home/myuser',
#    prerelease => true
#  }
#
define vagrant::plugin (
  $home,
  $plugin      = $title,
  $version     = undef,
  $prerelease  = false,
  $source      = undef,
  $entry_point = undef,
  $ensure      = present
) {

  include vagrant

  Exec { path => $::path, environment => [ "HOME=${home}" ] }

  $grep = $::operatingsystem ? {
    windows => 'findstr',
    default => 'grep'
  }
  $check = "vagrant plugin list | ${grep} \"^${plugin} \""

  $option_version = $version ? {
    undef   => '',
    default => " --plugin-version \"${version}\""
  }
  $option_prerelease = $prerelease ? {
    true    => ' --plugin-prerelease',
    default => ''
  }
  $option_source = $source ? {
    undef   => '',
    default => " --plugin-source \"${source}\""
  }
  $option_entry_point = $entry_point ? {
    undef   => '',
    default => " --entry-point \"${entry_point}\""
  }
  $options = "${option_version}${option_prerelease}${option_source}${option_entry_point}"

  case $ensure {
    present, installed: {
      exec { "vagrant plugin install ${plugin} ${options}":
        unless => $check,
      }
    }
    absent, uninstalled: {
      exec { "vagrant plugin uninstall ${plugin}":
        onlyif => $check,
      }
    }
    default: { fail("Unrecognized value for ensure: ${ensure}") }
  }

}
