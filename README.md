# Basic WordPress vagrant box

A very fast to spin up Vagrant environment for WordPress development. Tries to match WP Engine's platform as much as possible.

Clone this repo. `vagrant up`



### Database

Don't commit your database dumpfils to Git. There's sensitive info in there. Database dumps and other content like uploads should be stored separately. 

WP Engine's snapshots include a site's dumpfiles here: `[site_root]/wp-content/mysql.sql`

On `vagrant up`, the Ansible provisioner will look for an SQL dumpfile starting from wp-content and working it's way up to the project directory, stopping once it finds something. Basically this:

1. `project_root/site/wp-content/*.sql`
2. `project_root/site/*.sql`
3. `project_root/*.sql`