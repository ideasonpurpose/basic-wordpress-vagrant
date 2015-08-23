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

## Extras

* The [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin is highly recommended.  
`vagrant plugin install vagrant-hostsupdater`

* Instructions for [password-free Vagrant](https://gist.github.com/joemaller/41912f5d027a4adc7c14) (and how to [safely edit sudoers](http://stackoverflow.com/a/14101449))

* [WP Migrate DB](https://wordpress.org/plugins/wp-migrate-db/) is a useful WordPress plugin for rewriting urls in a dumpfile. Very helpful when moving a production DB to a development environment.

## Additional Notes

If you're using [WP Engine's .gitignore file](http://wpengine.com/git/), add the following so [Akismet](http://akismet.com) and [Hello Dolly](https://wordpress.org/plugins/hello-dolly/) aren't accidentally checked into our repository. Both are included in the default WordPress download. 

    # additional files from standard wp install
    /wp-content/plugins/akismet
    /wp-content/plugins/hello.php

