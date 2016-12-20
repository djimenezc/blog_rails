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