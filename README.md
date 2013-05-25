# Vagrant module for Puppet

This module installs vagrant 1.2.2 from http://downloads.vagrantup.com/.

## Description

This module uses $::operatingsystem and $::architecture to determine what package to install.

Currently supports:

* CentOS and Redhat (i386 and x86)
* Ubuntu and Debian (i386 and x86)
* Windows
* Darwin

## Usage

    include vagrant

