# Basic WordPress Vagrant Environment

An easy to use, fast to spin up WordPress [Vagrant][] environment modeled after WP Engine's platform.

### Requirements

To use this environment, you will need [Vagrant][], [VirtualBox][] and [Ansible][] installed. (Ansible can be installed with [Homebrew][]: `brew install ansible`)

## Install and Build

1. Download the [zip archive](https://github.com/ideasonpurpose/basic-wordpress-vagrant/archive/master.zip) or clone this repo
2. Unzip and rename the directory to `yoursite.dev`
3. Add your WordPress project to the `site` directory (or replace site with a clone)
4. Optionally copy a MySQL dumpfile into the project directory
5. Run `vagrant up`

When the Vagrant environment is provisioned a fresh install of WordPress will be applied to the `site` directory. **Any changes to core files or default themes will be lost.** But those files should really never be changed anyway, this behavior is very much deliberate. 

## Advantages
From a "cold boot" your new Vagrant environment should be ready to go in under a minute. Other popular WordPress Vagrant projects take much, much longer. 

The base box was generated from the [ideasonpurpose/basic-wordpress-box](https://github.com/ideasonpurpose/basic-wordpress-box) project. 

## Extras

For best results, the following additions are highly recommended. 

* The [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin is highly recommended.  
`vagrant plugin install vagrant-hostsupdater`

* Instructions for [password-free Vagrant](https://gist.github.com/joemaller/41912f5d027a4adc7c14) (and how to [safely edit sudoers](http://stackoverflow.com/a/14101449))

* [WP Migrate DB](https://wordpress.org/plugins/wp-migrate-db/) is a useful WordPress plugin for rewriting urls in a dumpfile. Very helpful when moving a production DB to a development environment.

## Additional Notes

An updated copy of [WP Engine's .gitignore file][gitignore] will be added to the site directory if there isn't a file there already. This will exclude all WordPress core files from Git. 

## About

[![iop_logo](https://cloud.githubusercontent.com/assets/8320/9443542/944a8bce-4a4f-11e5-9d2f-54999b1687d5.png)][iop]  
This project is sponsored by and used in production at [Ideas On Purpose][iop].

[iop]: http://ideasonpurpose.com
[vagrant]: https://www.vagrantup.com
[virtualbox]: https://www.virtualbox.org
[ansible]: http://docs.ansible.com/ansible/intro_installation.html
[homebrew]: http://brew.sh
[gitignore]: https://gist.github.com/joemaller/4f7518e0d04a82a3ca16
