# -*- mode: ruby -*-
# vi: set ft=ruby :
# Version: 0.5.0-0

# Try reading package.name from ./site/package.json
begin
  $hostname = JSON.parse(File.read(__dir__ + '/site/package.json'))['name']
rescue StandardError
end

# hostname fallback to 'vagrant' if nil or empty
$hostname = 'vagrant' if $hostname.nil? || $hostname.empty?

# clean hostname and add '.test' TLD
$hostname = $hostname
            .downcase
            .gsub(/[^a-z0-9]+/, '-') # sanitize non-alphanumerics to hyphens
            .gsub(/^-+|-+$/, '')     # strip leading or trailing hyphens

$devDomain = $hostname.gsub(/(\.dev|\.test)*$/, '') + '.test'

# Explicitly set $hostname here to override everything above
# $hostname = "dev.example.test"

# Read version from package.json
begin
  $version = JSON.parse(File.read(__dir__ + '/package.json'))['version']
rescue StandardError
end

# Placeholder version if missing, nil or empty
$version = '?.?.?' if $version.nil? || $version.empty?

# Read Ansible config from config.yml, set default for use_ssl
$ansible_config = YAML.load_file('config.yml') if File.file?('config.yml')
$ansible_config ||= { "use_ssl" => false }

Vagrant.configure(2) do |config|
  config.ssh.insert_key = false
  config.vm.box = "ideasonpurpose/basic-wp"
  config.vm.box_version = ">= 1.4.0"
  # config.vm.box = "basic-wp"
  config.vm.hostname = $hostname
  config.vm.define $hostname

  if Vagrant.has_plugin? 'vagrant-auto_network'
    config.vm.network :private_network, auto_network: true, id: "basic-wordpress-vagrant_#{$hostname}"
  else
    config.vm.network "private_network", type: "dhcp"
  end

  config.vm.synced_folder ".", "/vagrant", owner:"www-data", group:"www-data", mount_options:["dmode=775,fmode=664"]

  config.vm.provider "virtualbox" do |v|
    # v.gui = true  # for debugging
    v.customize ["modifyvm", :id, "--cpus", 1]
    v.customize ["modifyvm", :id, "--memory", 512]
    v.customize ["modifyvm", :id, "--vram", 4]
    v.customize ["modifyvm", :id, "--name", $hostname]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--paravirtprovider", "kvm"]
    v.customize ["modifyvm", :id, "--cableconnected1", 'on']
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "ansible/main.yml"
    ansible.extra_vars = {
      site_name: (Vagrant.has_plugin? 'vagrant-hostmanager') ? $devDomain : nil,
      theme_name: $hostname,
      vagrant_cwd: File.expand_path(__dir__)
    }
  end

  if Vagrant.has_plugin? 'vagrant-hostmanager'
    config.vm.provision :hostmanager
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      ip_addr = ""
      cmd = "VBoxControl --nologo guestproperty get /VirtualBox/GuestInfo/Net/1/V4/IP | cut -f2 -d' '"
      vm.communicate.sudo(cmd) do |type, data|
        ip_addr << data.strip
      end
      ip_addr
    end

    server_address = ($ansible_config['use_ssl'] ? 'https://' : 'http://') + $hostname
    config.vm.provision "Summary", type: "shell", privileged: false, inline: <<-EOF
      echo "Vagrant Box provisioned!"
      echo "Basic WordPress Vagrant version: #{$version}"
      echo "Local server addresses is #{server_address}"
    EOF

  else
    server_address = $ansible_config['use_ssl'] ? 'https://$IP' : 'http://$IP'
    config.vm.provision "Summary", type: "shell", privileged: true, inline: <<-EOF
      echo "Basic WordPress Vagrant version: #{$version}"
      echo "Vagrant Box provisioned!"
      IP=`VBoxControl --nologo guestproperty get /VirtualBox/GuestInfo/Net/1/V4/IP | cut -f2 -d' '`
      echo "Local server address is #{server_address}"
    EOF

  end
end
