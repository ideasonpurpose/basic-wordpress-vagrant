# basic-wordpress-vagrant changelog

## 0.1.0
- Configuration overrides moved into top-level `config.yml` file.
- Subdirectory installations and custom naming structures are now supported
- WordPress downloads are naively cached, refreshing hourly.
- All WordPress debugging settings now enabled by default
- Fresh [WordPress salts](https://api.wordpress.org/secret-key/1.1/salt) are now downloaded when a site is provisioned
- basic-wordpress-box updated to v0.0.11

## 0.0.11

- Faster and smarter discovery of MySQL dumpfiles
- Remove deprecation error when trying to discover plugins before installation

## 0.0.10

- Update playbooks for Ansible 2.0
- WP Download now works with arbitrary filenames

## 0.0.9

- Update to basic-wordpress-box v0.0.9
- Attempt to install missing plugins from wordpress.org
- generate .htaccess
- other versions of WordPress can be installed
- faster provisioning
- switched to zip archives from tarballs

## 0.0.8

- Public announcement 
- preliminary Windows support
