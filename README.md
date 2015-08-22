# Basic WordPress vagrant box

A pre-configured WordPress [Vagrant](https://www.vagrantup.com) environment modeled after WP Engine's platform that's fast to spin up and easy to work with.

## Install and Build

1. Download the zipfile or clone this repo
2. Unzip and rename the directory to `yoursite.dev`
3. If you have a database dumpfile, rename it `mysql.sql` and copy it into the yoursite.dev directory
4. Add your WordPress project to the `site` directory (replace site with a clone)
4. run `vagrant up`

When the vagrant environment is provisioned a fresh install of WordPress will be applied to the site directory. **Any changes to core files or default themes will be lost.** Those files should be sacrosanct anyway and this behavior is very much deliberate. 

## Advantages
From a "cold boot" a Vagrant environment should be ready to go in about a minute. Other popular WordPress Vagrant projects take much, much longer. 


## Database

The Ansible provisioner will look for an SQL dumpfile in the following locations, stopping once it finds something. 

1. `project_root/site/wp-content/mysql.sql`
2. `project_root/site/mysql.sql`
3. `project_root/mysql.sql`


Don't commit your database dumpfils to Git. There's sensitive info in there. Database dumps and other content like uploads should be stored separately. 


### Open Issues
WP Engine installs a slightly out-of-date copy of the [Force Strong Passwords]() plugin to `mu-plugins`. I'm not sure what to do about this. Installing the plugin normally on top of the mu-plugins copy throws a fatal error if activated. For now, the plugin is still in mu-plugins since WP Engine will prevent deploying internally. 
