# -*- mode: ruby -*-
# vi: set ft=ruby :
# Version: 0.7.1

# Try reading package.name from ./site/package.json
begin
  $hostname = JSON.parse(File.read(__dir__ + "/site/package.json"))["name"]
rescue StandardError
end

# hostname fallback to 'vagrant' if nil or empty
$hostname = "vagrant" if $hostname.nil? || $hostname.empty?

# clean hostname and add '.test' TLD
$hostname = $hostname
  .downcase
  .gsub(/[^a-z0-9]+/, "-") # sanitize non-alphanumerics to hyphens
  .gsub(/^-+|-+$/, "")     # strip leading or trailing hyphens

$devDomain = $hostname.gsub(/(\.dev|\.test)*$/, "") + ".test"

# Explicitly set $hostname here to override everything above
# $hostname = "dev.example.test"

# Read version from package.json
begin
  $version = JSON.parse(File.read(__dir__ + "/package.json"))["version"]
rescue StandardError
end

# Placeholder version if missing, nil or empty
$version = "?.?.?" if $version.nil? || $version.empty?

# Read Ansible config from config.yml, set default for use_ssl
$ansible_config = YAML.load_file("config.yml") if File.file?("config.yml")
$ansible_config ||= {"use_ssl" => false}

if ARGV[0] != "plugin" && ARGV[0] != "destroy"
  required_plugins = %w(vagrant-hostmanager vagrant-bindfs)

  plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
  if not plugins_to_install.empty?
    puts "Installing plugins: #{plugins_to_install.join(" ")}"
    if system "vagrant plugin install #{plugins_to_install.join(" ")}"
      exec "vagrant #{ARGV.join(" ")}"
    else
      abort "Installation of one or more plugins has failed. Aborting."
    end
  end
end

Vagrant.configure(2) do |config|
  config.ssh.insert_key = false
  config.vm.box = "ideasonpurpose/basic-wp"
  config.vm.box_version = ">= 1.7.0"
  # config.vm.box = "basic-wp"
  config.vm.hostname = $hostname
  config.vm.define $devDomain

  if Vagrant.has_plugin? "vagrant-auto_network"
    config.vm.network :private_network, auto_network: true, id: "basic-wordpress-vagrant_#{$hostname}"
  else
    config.vm.network "private_network", type: "dhcp"
  end

  config.vm.synced_folder ".", "/vagrant", owner: "www-data", group: "www-data", mount_options: ["dmode=775,fmode=664"]

  config.vm.provider "virtualbox" do |v|
    # v.gui = true  # for debugging
    v.customize ["modifyvm", :id, "--cpus", 1]
    v.customize ["modifyvm", :id, "--memory", 512]
    v.customize ["modifyvm", :id, "--vram", 4]
    v.customize ["modifyvm", :id, "--name", $devDomain]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--paravirtprovider", "kvm"]
    v.customize ["modifyvm", :id, "--cableconnected1", "on"]
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "ansible/main.yml"
    # ansible.verbose = "vvvv"
    ansible.extra_vars = {
      site_name: (Vagrant.has_plugin? "vagrant-hostmanager") ? $devDomain : nil,
      theme_name: $hostname,
      vagrant_cwd: File.expand_path(__dir__),
    }
  end

  if Vagrant.has_plugin? "vagrant-hostmanager"
    config.vm.provision :hostmanager
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.aliases = [$devDomain]
    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      ip_addr = ""
      cmd = "VBoxControl --nologo guestproperty get /VirtualBox/GuestInfo/Net/1/V4/IP | cut -f2 -d' '"  #" | tee /vagrant/.ip_address"
      vm.communicate.sudo(cmd) do |type, data|
        ip_addr << data.strip
      end
      ip_addr
    end
  end
  # Make sure Apache starts up every time
  config.vm.provision "shell", inline: "service apache2 restart", run: "always"

  # Write the VM's external IP address to /vagrant/.ip_address for use in post_up_message
  cmd = "VBoxControl --nologo guestproperty get /VirtualBox/GuestInfo/Net/1/V4/IP | cut -f2 -d' ' > /vagrant/.ip_address"
  config.vm.provision "shell", inline: cmd, run: "always"

  config.vm.post_up_message = Proc.new {
    begin
      ip = File.read(__dir__ + "/.ip_address").strip
    rescue StandardError
    end

    protocol = $ansible_config["use_ssl"] ? "https://" : "http://"
    msg = "    Local server addresses:\n" if Vagrant.has_plugin? "vagrant-hostmanager"
    msg << "        #{protocol}#{$devDomain}\n" if Vagrant.has_plugin? "vagrant-hostmanager"
    msg << "    Local server address:\n" if not Vagrant.has_plugin? "vagrant-hostmanager"
    msg << "        #{protocol}#{ip}\n"
    msg << "-"
    msg
  }
end
