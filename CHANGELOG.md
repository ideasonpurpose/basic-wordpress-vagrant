# basic-wordpress-vagrant changelog

## 0.6.0

- Write logs to /vagrant/logs for easier debugging
- Update Ansible syntax
- Check that the site folder exists on clean-slate instantiations
- Remove placeholder `site` directory
- Auto-install Vagrant plugins
- Bump box version to 1.6.0

## 0.5.0

- Ansible is no longer required, all provisioning now happens on the VM (and it's faster!)
- Recommended plugins now include [hostmanager]() and [bindfs](). Windows users may also want to install [auto_network](https://github.com/oscar-stack/vagrant-auto_network)
- Fully supported on Windows! [#4](https://github.com/ideasonpurpose/basic-wordpress-vagrant/issues/4)
- Switch to .test from .dev (thanks [Google](https://ma.ttias.be/chrome-force-dev-domains-https-via-preloaded-hsts/)) [#60](https://github.com/ideasonpurpose/basic-wordpress-vagrant/issues/60)
- The `config.yml` file is optional, check `config-example.yml` for example settings [#54](https://github.com/ideasonpurpose/basic-wordpress-vagrant/issues/54)
- Localize wp-cli config for alternate install locations [#58](https://github.com/ideasonpurpose/basic-wordpress-vagrant/issues/58)
- Don't generate self-signed certs unless `use_ssl` is true
- Fix for cert generation errors when the [vagrant-hostmanager plugin](https://github.com/devopsgroup-io/vagrant-hostmanager) is not installed. [#56](https://github.com/ideasonpurpose/basic-wordpress-vagrant/issues/56)
- Smarter server address reporting in `vagrant up`
- Simplified Vagrantfile reporting with `post_message`

## 0.4.0

- SSL support via self-signed certificates
- Default theme loading (fewer white screens)
- Fix for some WP Salts containing templating strings which broke the provisioner
- Performance tweaks
- [basic-wordpress-box](https://github.com/ideasonpurpose/basic-wordpress-box) updated to v1.3.0

## 0.3.0

- Updated [basic-wordpress-box](https://github.com/ideasonpurpose/basic-wordpress-box) to v1.0.0, now running on PHP 7.0 and WP-CLI 0.25
- Symlink Kint lib from the base box instead of downloading
- Symlink XHProf display files from base box
- Config option to disable xDebug
- Documentation improvements

## 0.2.0

- Added the [Kint PHP debugging helper](http://raveren.github.io/kint/)
- Compatibility with Vagrant 1.8.6, Virtual Box 5.1.x and Ansible 2.2
- Better [versioning with npm](https://github.com/joemaller/version-everything-with-npm)

## 0.1.0

- Configuration overrides moved into top-level `config.yml` file.
- Subdirectory installations and custom naming structures are now supported
- WordPress downloads are naively cached, refreshing hourly.
- All WordPress debugging settings now enabled by default
- Fresh [WordPress salts](https://api.wordpress.org/secret-key/1.1/salt) are now downloaded when a site is provisioned
- [basic-wordpress-box](https://github.com/ideasonpurpose/basic-wordpress-box) updated to v0.0.11

## 0.0.11

- Faster and smarter discovery of MySQL dumpfiles
- Remove deprecation error when trying to discover plugins before installation

## 0.0.10

- Update playbooks for Ansible 2.0
- WP Download now works with arbitrary filenames

## 0.0.9

- Update to [basic-wordpress-box](https://github.com/ideasonpurpose/basic-wordpress-box) v0.0.9
- Attempt to install missing plugins from wordpress.org
- generate .htaccess
- other versions of WordPress can be installed
- faster provisioning
- switched to zip archives from tarballs

## 0.0.8

- Public announcement
- preliminary Windows support
