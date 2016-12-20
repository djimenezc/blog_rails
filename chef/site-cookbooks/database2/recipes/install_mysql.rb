log 'configuring mysql'

instance_name = 'default'

# MySQL
mysql_connection_info = {
    :host => 'localhost',
    :username => 'root',
    :password => node['mysql']['server_root_password'],
    :socket => "/var/run/mysql-#{instance_name}/mysqld.sock"
}

# 'rails'@'localhost'
mysql_database_user 'rails' do
  connection mysql_connection_info
  password ''
  host 'localhost'
  privileges ['ALL PRIVILEGES']
  grant_option true
  action :grant
end

# 'rails'@'%'
mysql_database_user 'rails' do
  connection mysql_connection_info
  password ''
  host '%'
  privileges ['ALL PRIVILEGES']
  grant_option true
  action :grant
end

mysql_database 'ruby_test' do
  connection mysql_connection_info
  action :create
end

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