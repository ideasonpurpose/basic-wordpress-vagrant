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

Vagrant.configure(2) do |config|
  config.vm.box = "ideasonpurpose/basic-wp"
  config.vm.box_version = ">= 0.0.9"
  config.vm.hostname = $hostname
  config.vm.network "private_network", type: "dhcp"

  config.vm.synced_folder ".", "/vagrant", owner:"www-data", group:"www-data", mount_options:["dmode=775,fmode=664"]

  config.vm.provider "virtualbox" do |v|
    # v.gui = true  # for debugging
    v.customize ["modifyvm", :id, "--memory", 512]
    v.customize ["modifyvm", :id, "--name", $hostname]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  if Vagrant::Util::Platform.windows?
    $site_name = (Vagrant.has_plugin? 'vagrant-hostmanager') ? 'site_name=#{$hostname}' : ''
    config.vm.provision "Running Ansible inside the VM", type: "shell", privileged: false, inline: <<-EOT
      export ANSIBLE_FORCE_COLOR=true
      echo 'localhost ansible_connection=local #{$site_name}' > /tmp/hosts
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
          site_name: (Vagrant.has_plugin? 'vagrant-hostmanager') ? $hostname : nil,
          vagrant_cwd: File.expand_path(__dir__)
        }
      end
    end

  if Vagrant.has_plugin? 'vagrant-hostmanager'
    config.vm.provision :hostmanager
    config.hostmanager.enabled = false
    config.hostmanager.manage_host = true
    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      if vm.id
        %x(VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP").split()[1]
      end
    end
    config.vm.provision "Summary", type: "shell", privileged: false, inline: <<-EOF
      echo "Vagrant Box provisioned!"
      echo "Local server address is http://#{$hostname}"
    EOF

  else
    config.vm.provision "Summary", type: "shell", privileged: false, inline: <<-EOF
      echo "Vagrant Box provisioned!"
      ID=`cat /vagrant/.vagrant/machines/default/virtualbox/id`
      IP=`hostname -I | cut -f2 -d' '`
      echo "Local server address is http://$IP"
    EOF

  end

end
