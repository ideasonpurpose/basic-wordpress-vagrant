# -*- mode: ruby -*-
# vi: set ft=ruby :
# Version: 0.5.0-0

# Try reading package.name from ./site/package.json
begin
  $hostname = JSON.parse(File.read(__dir__ + '/site/package.json'))['name']
  $themename = $hostname
rescue StandardError
end

# hostname fallback to 'vagrant' if nil or empty
$hostname = 'vagrant' if $hostname.nil? || $hostname.empty?

# clean hostname and add '.test' TLD
$hostname = $hostname
            .downcase
            .gsub(/[^a-z0-9]+/, '-') # sanitize non-alphanumerics to hyphens
            .gsub(/^-+|-+$/, '')     # strip leading or trailing hyphens
            .gsub(/(\.dev|\.test)*$/, '') + '.test'

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
  config.vm.network "private_network", type: "dhcp"

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
    ansible.playbook = "ansible/main.yml"
    ansible.extra_vars = {
      site_name: (Vagrant.has_plugin? 'vagrant-hostmanager') ? $hostname : nil,
      theme_name: $themename,
      vagrant_cwd: File.expand_path(__dir__)
    }
  end

  if Vagrant.has_plugin? 'vagrant-hostmanager'
    server_address = ($ansible_config['use_ssl'] ? 'https://' : 'http://') + $hostname
    config.vm.provision :hostmanager
    config.hostmanager.enabled = false
    config.hostmanager.manage_host = true
    config.hostmanager.ip_resolver = proc do |vm, _resolving_vm|
      if vm.id && !Vagrant::Util::Platform.windows?
        `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split[1]
      end
    end
    config.vm.provision "Summary", type: "shell", privileged: false, inline: <<-EOF
      echo "Vagrant Box provisioned!"
      echo "Basic WordPress Vagrant version: #{$version}"
      echo "Local server addresses is #{server_address}"
    EOF

  else
    $server_address = $ansible_config['use_ssl'] ? 'https://$IP' : 'http://$IP'
    config.vm.provision "Summary", type: "shell", privileged: false, inline: <<-EOF
      echo "Vagrant Box provisioned!"
      echo "Basic WordPress Vagrant version: #{$version}"
      ID=`cat /vagrant/.vagrant/machines/default/virtualbox/id`
      IP=`hostname -I | cut -f2 -d' '`
      echo "Local server address is #{server_address}"
    EOF

  end
end
