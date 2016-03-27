# Setup database servers
#
# 1. Setup MySQL and PostgreSQL
# 2. Create a rails user with a blank password with full control

instance_name = 'default'

# MySQL
mysql_connection_info = {
    :host => "localhost",
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

# PostgreSQL
template "#{node[:postgresql][:dir]}/pg_hba.conf" do
  source 'pg_hba.conf.erb'
  notifies :restart, 'service[postgresql]', :immediately
end

postgresql_connection_info = {
    :host => 'localhost',
    :password => node['postgresql']['password']['postgres']
}

postgresql_database_user 'rails' do
  connection postgresql_connection_info
  password ''
  # role_attributes :superuser => true, :createdb => true
  privileges [:all]
  action :grant
  action :create
end