
version = '5.7'
# node['mysql']['server_root_password'] = 'change me'

# node.default['mysql'] = {
#     'server_root_password' => 'change me'
# }

mysql_service 'default' do
  version version
  port '3306'
  initial_root_password node['mysql']['server_root_password']
  action [:create, :start]
end

mysql_config 'default' do
  instance 'default'
  source 'my.conf.erb'
  # notifies :restart, 'mysql_service[default]'
  version version
  action :create
end

mysql_client 'default' do
  version version
  action [:create]
end

# install mysql gem
mysql2_chef_gem 'default' do
  action :install
end