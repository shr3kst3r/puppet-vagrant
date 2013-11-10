# Vagrant module for Puppet

This module installs vagrant 1.2.7 from http://downloads.vagrantup.com/.

## Description

This module uses $::operatingsystem and $::architecture to determine what package to install.

NOTE: For versions other then 1.2.7 you need both the git hash and the version number for the vagrant download.  The way to figure out what this hash is, go to downloads.vagrantup.com, select the version you want to install, look at the URL and it will be of the form http://files.vagrantup.com/packages/${git_hash}/the_package.rpm, and you want the hash from that URL.  See the last example below.

Currently supports:

* CentOS and Redhat (i386 and x86)
* Ubuntu and Debian (i386 and x86)
* Windows
* Darwin

## Usage

Install 1.2.7

    include vagrant

Install 1.2.2

    class { 'vagrant':
       git_hash => '7e400d00a3c5a0fdf2809c8b5001a035415a607b',
       version  => '1.2.2'
    }

Install plugin

    vagrant::plugin { 'vagrant-hostmanager':
       home => '/home/myuser'
    }

Install plugin in specific version

    vagrant::plugin { 'vagrant-hostmanager':
       home    => '/home/myuser',
       version => 0.8.0
    }

Install a pre-release plugin

    vagrant::plugin { 'vagrant-hostmanager':
       home       => '/home/myuser',
       prerelease => true
    }
