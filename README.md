# Basic WordPress Vagrant Environment

A pre-configured WordPress [Vagrant](https://www.vagrantup.com) environment modeled after WP Engine's platform that's fast to spin up and easy to work with.

## Install and Build

1. Download the [zip archive](https://github.com/ideasonpurpose/basic-wordpress-vagrant/archive/master.zip) or clone this repo
2. Unzip and rename the directory to `yoursite.dev`
3. If you have a database dumpfile, rename it `mysql.sql` and copy it into the yoursite.dev directory
4. Add your WordPress project to the `site` directory (replace site with a clone)
4. run `vagrant up`

When the Vagrant environment is provisioned a fresh install of WordPress will be applied to the `site` directory. **Any changes to core files or default themes will be lost.** Those files should be sacrosanct anyway and this behavior is very much deliberate. 

## Advantages
From a "cold boot" a Vagrant environment should be ready to go in about a minute. Other popular WordPress Vagrant projects take much, much longer. 

The base box was generated from the  [ideasonpurpose/basic-wordpress-box](https://github.com/ideasonpurpose/basic-wordpress-box) project. 