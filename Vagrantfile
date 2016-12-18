Vagrant.require_version '>= 1.5'

# Change these two paths to folders
# FRONTEND  = "../linkip-frontend/"
BACKEND_PATH = '../linkip-backend/' #change this value only!!
BACKEND_NAME = 'linkip-backend' #do not change this value

def require_plugins(plugins = {})
  needs_restart = false
  plugins.each do |plugin, version|
    next if Vagrant.has_plugin?(plugin)
    cmd =
        [
            'vagrant plugin install',
            plugin
        ]
    cmd << "--plugin-version #{version}" if version
    system(cmd.join(' ')) || exit!
    needs_restart = true
  end
  exit system('vagrant', *ARGV) if needs_restart
end

require_plugins \
  'vagrant-bindfs' => '0.4.8',
  #'vagrant-librarian-chef-nochef' => '0.2.0',
  'vagrant-berkshelf' => '5.1.1',
  'vagrant-vbguest' => '0.12.0',
  'vagrant-omnibus' => '1.5.0'

Vagrant.configure('2') do |config|
  # config.vm.box = 'precise64'
  config.vm.box = 'ubuntu/xenial64'

  # config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  # config.vm.box_url = 'https://atlas.hashicorp.com/ubuntu/boxes/trusty64/versions/20150817.0.0/providers/virtualbox.box'

  config.vm.provider 'virtualbox' do |vbox|
    vbox.name = 'trading_app'
    vbox.memory = 2048
    vbox.cpus = 4
  end

  config.vm.network :forwarded_port, guest: 3000, host: 3000 # forward the default rails port
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # forward the MySQL port
  config.vm.network :forwarded_port, guest: 5432, host: 5432 # forward the PostgreSQL port

  config.vm.provision :shell, path: 'bootstrap.sh'
  # config.vm.provision 'shell', inline: "echo hello"
  # config.vm.provision 'chef_solo' do |chef|
  #   chef.add_recipe 'apache'
  # end
  # config.vm.provision "shell" do |s|
  #   s.path = "provision/setup.sh"
  # end

  config.omnibus.chef_version = :latest
  # config.vm.provision :shell, :inline => 'gem install chef --version latest --verbose'

  # config.berkshelf.enabled = true
  # config.berkshelf.berksfile_path = './chef/cookbook'

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = %w(chef/cookbooks chef/site-cookbooks)
    chef.roles_path = [[:host, 'chef/roles']]
    chef.data_bags_path = 'chef/data_bags'
    chef.nodes_path = 'chef/nodes'

    # chef.version = '12.10.40'
    chef.channel = 'stable'

    # Add a recipe
    chef.add_recipe 'main::default'
    chef.add_recipe 'libffi-dev'
    chef.add_recipe 'nodejs'
    chef.add_recipe 'ruby_build'
    chef.add_recipe 'vim'
    chef.add_recipe 'libmysqlclient'
    chef.add_recipe 'ruby_rbenv::user'

    chef.add_role 'rails-dev'

    chef.json = {
        :mysql => {
            :server_root_password => '',
            :server_debian_password => '',
            :server_repl_password => ''
        },
        :postgresql => {
            :password => {
                :postgres => ''
            }
        },
        :rbenv => {
            :global => '2.3.3',
            :rubies => %w(2.3.3),
            :gems => {
                '2.3.3' => [
                    {'name' => 'bundler'},
                    {'name' => 'rake'}
                ]
            }
        }
    }
  end
end