# -*- mode: ruby -*-
# vi: set ft=ruby :

# If no hostname is set, use the sanitized name of the Vagrantfile's containing directory
$hostname ||= File.basename(__dir__)
        .downcase
        .gsub(/(\.dev)*$/, '')  # strip .dev TLD if there
        .gsub(/[^a-z0-9]+/,'-') # sanitize non-alphanumerics to hyphens
        .gsub(/^-+|-+$/,'')     # strip leading or trailing hyphens (Ruby-style trim)

# if that fails, fallback to 'vagrant'
$hostname = "vagrant" if $hostname.empty?

# add a fake-TLD '.dev' extension
$hostname = $hostname.gsub(/(\.dev)*$/, '') + '.dev'

$local_ip = "192.168.125.71"

Vagrant.configure(2) do |config|
  config.vm.box = "ideasonpurpose/basic-wp"
  config.vm.hostname = $hostname

  if Vagrant.has_plugin? 'vagrant-hostsupdater'
    config.hostsupdater.remove_on_suspend = true
  end

  config.vm.network "private_network", ip: $local_ip
  # config.vm.network "private_network", type: "dhcp"

  config.vm.synced_folder ".", "/vagrant", owner:"www-data", group:"www-data", mount_options:["dmode=775,fmode=664"]

  config.vm.provider "virtualbox" do |v|
    # v.gui = true  # for debugging
    v.customize ["modifyvm", :id, "--memory", 512]
    v.customize ["modifyvm", :id, "--name", $hostname]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end


  if Vagrant::Util::Platform.windows?
    config.vm.provision "shell", privileged: false, inline: <<-EOT
      export ANSIBLE_FORCE_COLOR=true
      echo 'localhost ansible_connection=local site_name=#{$hostname}' > /tmp/hosts
      cd /vagrant
      ansible-playbook ansible/main.yml -i /tmp/hosts
      rm -rf /tmp/hosts
    EOT
  else
      config.vm.provision "ansible" do |ansible|
        # ansible.verbose = "vvvv"
        ansible.playbook = "ansible/main.yml"
        # Set all Vagrant dependent vars here to override the playbook defaults
        ansible.extra_vars = {
            site_name: $hostname,
        }
      end
  end


  config.vm.provision "shell", privileged: false, inline: <<-EOF
    echo "Vagrant Box provisioned!"
    echo "Local server address is http://#{host_or_ip}"
  EOF

end


def host_or_ip
  (Vagrant.has_plugin? 'vagrant-hostsupdater') ? $hostname : $local_ip
end
