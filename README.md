# Basic WordPress Vagrant Environment

An easy to use, fast to spin up WordPress [Vagrant][] environment modeled after managed WordPress hosting platforms like WP Engine and Flywheel.


## Requirements

[Vagrant][] and [VirtualBox][] must be installed. Mac users should also install Ansible with [Homebrew][]: `brew install ansible`. The [vagrant-hostmanager][] plugin is highly recommended, but not required.  *(Windows support is still in progress)*

Complete [first-time setup instructions](#complete-one-time-setup-instructions) are below.

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


## Complete, One-Time Setup Instructions

Below are the complete steps necessary to use the Basic WordPress Vagrant Environment on a new computer. These steps should only need to be done once, but it's useful to review if something isn't working correctly. 

1. Download the Vagrant installer from [vagrantup.com][vagrant] and install Vagrant.
2. Download the VirtualBox installer from [virtualbox.org][virtualbox] and install VirtualBox.
3. In the terminal, run `brew update`. If Homebrew is not installed, the one-line installation command is at the top of [Homebrew's website][homebrew].
4. Still in the terminal, run `brew install ansible` to install [Ansible][].
5. Finally, install the [Vagrant Host Manager plugin][vagrant-hostmanager] by running this command in the terminal:  
   `vagrant plugin install vagrant-hostmanager`

That's everything, now just follow the [Instructions](#instructions) to spin up your WordPress environment.


## Extras

* Missing plugins will be installed if they can be found in the [WordPress Plugin Directory](https://wordpress.org/plugins/).

* Specific versions of WordPress can be installed by editing [`ansible/vars/wordpress.yml`](https://github.com/ideasonpurpose/basic-wordpress-vagrant/blob/master/ansible/vars/wordpress.yml)

* Instructions for [password-free Vagrant](https://gist.github.com/joemaller/41912f5d027a4adc7c14) and how to [safely edit sudoers](http://stackoverflow.com/a/14101449).

* File permissions are handled by managed hosts and may differ between projects. To ignore permissions for sites managed with Git, run this in your local repo: `git config core.filemode false`

* [WP Migrate DB](https://wordpress.org/plugins/wp-migrate-db/) is a useful WordPress plugin for rewriting urls in a dumpfile. Very helpful when moving a production DB to a development environment. (Alternative suggestions are welcomed)

## Additional Notes

A [.gitignore file][gitignore] will be added to the site directory if one doesn't already exist. This file excludes all WordPress core files from Git.

The Ansible provisioner will search for MySQL dumpfiles in the top five levels of the project, ignoring WordPress core and common vendor directories. The top-most (first-found) dumpfile will be imported.

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
[vagrant-hostmanager]: https://github.com/smdahlen/vagrant-hostmanager
