Vagrant.configure('2') do |config|
  # config.vm.box = 'precise64'
  config.vm.box = 'ubuntu/trusty64'

  # config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  # config.vm.box_url = 'https://atlas.hashicorp.com/ubuntu/boxes/trusty64/versions/20150817.0.0/providers/virtualbox.box'

  config.vm.provider 'virtualbox' do |v|
    v.memory = 2048
    v.cpus = 4
  end

  config.vm.network :forwarded_port, guest: 3000, host: 3000 # forward the default rails port
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # forward the MySQL port
  config.vm.network :forwarded_port, guest: 5432, host: 5432 # forward the PostgreSQL port

  config.vm.provision :shell, path: 'bootstrap.sh'
  # config.vm.provision "shell" do |s|
  #   s.path = "provision/setup.sh"
  # end

  config.omnibus.chef_version = :latest
  # config.vm.provision :shell, :inline => 'gem install chef --version latest --verbose'

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = %w(chef/cookbooks chef/site-cookbooks)
    chef.roles_path = [[:host, 'chef/roles']]

    chef.add_role 'rails-dev'
    chef.json = {
        'mysql' => {
            'server_root_password' => '',
            'server_debian_password' => '',
            'server_repl_password' => ''
        },
        'postgresql' => {
            'password' => {
                'postgres' => ''
            }
        },
        'rbenv' => {
            'global' => '2.1.5',
            'rubies' => %w(2.1.5),
            'gems' => {
                # '2.0.0-p247' => [
                #     {'name' => 'bundler'},
                #     {'name' => 'rake', 'options' => {'force' => true}}
                # ],
                '2.1.5' => [
                    {'name' => 'bundler'},
                    {'name' => 'rake'}
                ]
            }
        }
    }
  end
end