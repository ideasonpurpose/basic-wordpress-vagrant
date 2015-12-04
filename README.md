# Basic WordPress Vagrant Environment

An easy to use, fast to spin up WordPress [Vagrant][] environment modeled after managed WordPress hosting platforms like WP Engine and Flywheel.


## Requirements

[Vagrant][] and [VirtualBox][] must be installed. On Macs, also install Ansible with [Homebrew][]: `brew install ansible` *(Windows support is almost working)*

The [vagrant-hostmanager](https://github.com/smdahlen/vagrant-hostmanager) plugin is highly recommended, but not required.  
Installation is easy: `vagrant plugin install vagrant-hostmanager`

## Advantages
From a "cold boot" your new Vagrant environment should be ready to go in about a minute, if not faster. Other popular WordPress Vagrant projects take much, much longer. 


## Instructions

1. Download the [zip archive](https://github.com/ideasonpurpose/basic-wordpress-vagrant/archive/master.zip) or clone this repo
2. Unzip and rename the directory to `yoursite.dev`
3. Add your WordPress project to the `site` directory (or replace site with a clone)
4. Optionally copy a MySQL dumpfile into the project directory
5. Run `vagrant up`

When the Vagrant environment is provisioned a fresh install of WordPress will be applied to the `site` directory. **Any changes to core files or default themes will be lost.** But those files should really never be changed anyway, this behavior is very much deliberate. 

#### WP Engine Specific Instructions
1. Download the [zip archive](https://github.com/ideasonpurpose/basic-wordpress-vagrant/archive/master.zip) or clone this repo
2. Unzip and rename the directory to `yoursite.dev`
3. Download a backup snapshot from your [WP Engine Dashboard](https://my.wpengine.com).
4. Decompress the zip archive and rename the resulting directory to `site`
5. Copy `site` into `yoursite.dev`, replacing the existing `site` directory.
6. Run `vagrant up`


#### Flywheel Specific Instructions

1. Download the [zip archive](https://github.com/ideasonpurpose/basic-wordpress-vagrant/archive/master.zip) or clone this repo
2. Unzip and rename the directory to `yoursite.dev`
3. Download a backup snapshot from your [Flywheel Dashboard](https://app.getflywheel.com). Flywheel backup archives contains a `backup.sql` database dumpfile and a `files` directory.
4. Rename `files` to `site`
5. Copy `site` and `backup.sql` into `yoursite.dev`, replacing the existing `site` directory.
6. Run `vagrant up`

## Extras

* Missing plugins will be installed if they can be found in the [WordPress Plugin Directory](https://wordpress.org/plugins/).

* Specific versions of WordPress can be installed by editing [`ansible/vars/wordpress.yml`](https://github.com/ideasonpurpose/basic-wordpress-vagrant/blob/master/ansible/vars/wordpress.yml)

* Instructions for [password-free Vagrant](https://gist.github.com/joemaller/41912f5d027a4adc7c14) and how to [safely edit sudoers](http://stackoverflow.com/a/14101449).

* [WP Migrate DB](https://wordpress.org/plugins/wp-migrate-db/) is a useful WordPress plugin for rewriting urls in a dumpfile. Very helpful when moving a production DB to a development environment. (Alternative suggestions are welcomed)

## Additional Notes

A [.gitignore file][gitignore] will be added to the site directory if one doesn't already exist. This file excludes all WordPress core files from Git.

The base box was generated from the [ideasonpurpose/basic-wordpress-box](https://github.com/ideasonpurpose/basic-wordpress-box) project. 



## About

[![iop_logo](https://cloud.githubusercontent.com/assets/8320/9443542/944a8bce-4a4f-11e5-9d2f-54999b1687d5.png)][iop]  
This project is sponsored by and used in production at [Ideas On Purpose][iop].

[iop]: http://ideasonpurpose.com
[vagrant]: https://www.vagrantup.com
[virtualbox]: https://www.virtualbox.org
[ansible]: http://docs.ansible.com/ansible/intro_installation.html
[homebrew]: http://brew.sh
[gitignore]: https://gist.github.com/joemaller/4f7518e0d04a82a3ca16
