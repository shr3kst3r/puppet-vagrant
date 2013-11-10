# Vagrant module for Puppet

This module installs vagrant 1.3.5 from http://downloads.vagrantup.com/.

## Description

This module uses $::operatingsystem and $::architecture to determine what package to install.

NOTE: For versions other then 1.3.5 you need both the git hash and the version number for the vagrant download.  The way to figure out what this hash is, go to downloads.vagrantup.com, select the version you want to install, look at the URL and it will be of the form http://files.vagrantup.com/packages/${git_hash}/the_package.rpm, and you want the hash from that URL.  See the last example below.

Currently supports:

* CentOS and Redhat (i386 and x86)
* Ubuntu and Debian (i386 and x86)
* Windows
* Darwin

## Usage

Install 1.3.5

    include vagrant

Install 1.3.4

    class { 'vagrant':
       git_hash => '0ac2a87388419b989c3c0d0318cc97df3b0ed27d',
       version  => '1.3.4'
    }
