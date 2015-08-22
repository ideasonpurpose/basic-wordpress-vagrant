# -*- mode: ruby -*-
# vi: set ft=ruby :

# If no hostname is set, use the sanitized name of the Vagrantfile's containing directory
$hostname ||= File.basename(File.dirname(File.expand_path(__FILE__))).downcase.gsub(/[^a-z0-9]+/,'-').gsub(/^-+|-+$/,'')
# if that fails, fallback to 'vagrant'
$hostname = "vagrant" if $hostname.empty?
# add a fake-TLD '.dev' extension
$hostname = $hostname.gsub(/(\.dev)*$/, '') + '.dev'

Vagrant.configure(2) do |config|
  config.vm.box = "basic-wp"
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "private_network", type: "dhcp"

  config.vm.hostname = $hostname

  if Vagrant.has_plugin? 'vagrant-hostsupdater'
    config.hostsupdater.remove_on_suspend = true
  end

  config.vm.provider "virtualbox" do |v|
    # v.gui = true  # for debugging
    v.customize ["modifyvm", :id, "--memory", 512] # GraphViz fails with less than 4 GB
    v.customize ["modifyvm", :id, "--name", $hostname]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.provision "ansible" do |ansible|
    # ansible.verbose = "vvvv"
    ansible.playbook = "ansible/main.yml"
    # Set all Vagrant dependent vars here to override the playbook defaults
    ansible.extra_vars = {
        site_name: $hostname,
    }
  end


  config.vm.provision "shell", inline: <<-EOF
    echo "Vagrant Box provisioned!"
    echo "Local server address is http://#{$hostname}"
    if hash open 2>/dev/null; then
      open "http://#{$hostname}"
    fi
  EOF

end
