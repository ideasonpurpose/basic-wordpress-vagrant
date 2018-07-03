# Basic WordPress Vagrant Environment

#### Version: 0.5.3

An easy to use, fast to spin up WordPress [Vagrant][] environment modeled after managed WordPress hosting platforms like WP Engine and Flywheel.

## Advantages

From a "cold boot" your WordPress Vagrant environment should be ready to go in about a minute, if not faster. Other WordPress Vagrant projects take much, much longer.

## Requirements

[Vagrant][] and [VirtualBox][] must be installed. The [vagrant-hostmanager][] plugin is highly recommended, but not required.

Complete [first-time setup instructions](#complete-one-time-setup-instructions) are below.

## Instructions

1.  Download the [zip archive](https://github.com/ideasonpurpose/basic-wordpress-vagrant/archive/master.zip) or clone this repo
2.  Unzip and rename the directory to something like `yoursite.test`
3.  For existing projects, clone or copy your site into a `site` directory. New projects will create `site`.
4.  Optionally copy a MySQL dumpfile into the project directory
5.  Install plugins: `vagrant plugin install vagrant-hostmanager` (Mac and Linux users should also install the `vagrant-bindfs` plugin)
6.  Run `vagrant up`

When the Vagrant environment is provisioned a fresh install of WordPress will be applied to the `site` directory. **Any changes to core files or default themes will be lost.** Those files should really never be changed anyway, and this behavior is deliberate and intentional.

To avoid being asked for a password on every `vagrant up` (when using the [vagrant-hostmanager][] plugin), [edit the sudoers file][visudo] and add the [ lines from this gist][sudoers].

#### WP Engine Specific Instructions

1.  Download the [zip archive](https://github.com/ideasonpurpose/basic-wordpress-vagrant/archive/master.zip) or clone this repo
2.  Unzip and rename the directory to `yoursite.dev`
3.  Download a backup snapshot from your [WP Engine Dashboard](https://my.wpengine.com).
4.  Decompress the zip archive and rename the resulting directory to `site`
5.  Copy `site` into `yoursite.dev`, replacing the existing `site` directory.
6.  Run `vagrant up`

#### Flywheel Specific Instructions

1.  Download the [zip archive](https://github.com/ideasonpurpose/basic-wordpress-vagrant/archive/master.zip) or clone this repo
2.  Unzip and rename the directory to `yoursite.dev`
3.  Download a backup snapshot from your [Flywheel Dashboard](https://app.getflywheel.com). Flywheel backup archives contains a `backup.sql` database dumpfile and a `files` directory.
4.  Rename `files` to `site`
5.  Copy `site` and `backup.sql` into `yoursite.dev`, replacing the existing `site` directory.
6.  Run `vagrant up`

## Other Uses

While this project's main goal is to provide a fast, standard WordPress development environment based on popular managed hosts, there are times where that just won't work. For sites installed in a subdirectory or using other custom file structure, there are options to help stage those as well.

The [`config.yml`][config] file includes `wp_dir` and `wp_content` settings which can be used to override the WordPress defaults.

## Complete, One-Time Setup Instructions

Below are the complete steps necessary to use the Basic WordPress Vagrant Environment on a new Mac. These steps should only need to be done once, but it's useful to review if something isn't working correctly.

1.  Download the Vagrant installer from [vagrantup.com][vagrant] and install Vagrant.
2.  Download the VirtualBox installer from [virtualbox.org][virtualbox] and install VirtualBox.
3.  Install the [Hostmanager][vagrant-hostmanager] and [Bind-fs](https://github.com/gael-ian/vagrant-bindfs) plugins by running this command in the terminal:  
    `vagrant plugin install vagrant-hostmanager vagrant-bind-fs`

That's everything, now just follow the [Instructions](#instructions) to spin up your WordPress environment.

## Upgrading

One of this project's goals is to promote [disposability](http://12factor.net/disposability): Developers should be able to spin up and tear down local development sites quickly and dependably. An ideal managed WordPress site is just a database dumpfile and whatever code exists in the `wp-content` directory. Everything outside of that should be replaceable. The only exception would be site-specific configurations in [`config.yml`][config].

## Additional Settings and Customizations

Many custom options can be set in [`config.yml`][config]:

- `wp_download` can be used to install specific WordPress versions.

- `install_plugins` toggles automatic installation of missing plugins

- `wp_dir` changes the install location of WordPress, use this to install WordPress into a subdirectory.

- `wp_content` remaps the `wp-content` directory. Useful for working on roots.io style installations.

- `enable_xdebug` toggles [xDebug][] display

- `table_prefix` maps directly to the WordPress Database Table prefix in `wp-config.php`

## Extras

- Missing WordPress plugins will be installed if they can be found in the [WordPress Plugin Directory](https://wordpress.org/plugins/).

- All settings for [Debugging in WordPress](https://codex.wordpress.org/Debugging_in_WordPress) are enabled.

- Save [`vagrant-hostmanager-nopasswd`][sudoers] to `/etc/sudoers.d/` for password-free, host-managed `vagrant up`.

- File permissions are handled by managed hosts and may differ between projects. To ignore permissions for sites managed with Git, run this in your local repo: `git config core.filemode false`

## White Screen of Death?

Log directly into `/wp-admin` and try to activate your theme again.

## Additional Notes

An extensive [.gitignore file][gitignore] will be added to the site directory if one doesn't already exist. This file excludes all WordPress core files from Git.

The Ansible provisioner will search for MySQL database dumpfiles in the top five levels of the project, ignoring WordPress core and common vendor directories. The top-most (first-found) database dumpfile will be imported.

A default theme can be set in `config.yml`. If no default is set, the Ansible provisioner will attempt to activate a theme whose name matches the `name` attribute in `site/package.json`. These settings help prevent white-screens when restoring a project which uses versioned theme directories.

Using Composer from `vagrant ssh` may require a GitHub OAuth token. More info: [API rate limit and OAuth tokens](https://github.com/composer/composer/blob/master/doc/articles/troubleshooting.md#api-rate-limit-and-oauth-tokens).

For direct MySQL access, `vagrant ssh`, then `mysql wordpress`.

The base box was generated from the [ideasonpurpose/basic-wordpress-box](https://github.com/ideasonpurpose/basic-wordpress-box) project.

Some [solutions for Chrome's annoying HSTS lockout][hsts]. Try typing `badidea` on the error page.

[Vagrant Hostmanager][vagrant-hostmanager] may silently fail to write to `etc/hosts` on Windows 10.

Microsoft Edge on Windows 10 will not load websites from local IP addresses. IE11, Chrome and Firefox all work correctly.

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
[config]: https://github.com/ideasonpurpose/basic-wordpress-vagrant/blob/master/config.yml
[windows]: https://github.com/ideasonpurpose/basic-wordpress-vagrant/issues/4
[sudoers]: https://gist.github.com/joemaller/41912f5d027a4adc7c14
[visudo]: http://stackoverflow.com/a/14101449
[xdebug]: https://xdebug.org/docs/
[hsts]: https://stackoverflow.com/questions/33268264/chromethe-website-uses-hsts-network-errors-this-page-will-probably-work-late
