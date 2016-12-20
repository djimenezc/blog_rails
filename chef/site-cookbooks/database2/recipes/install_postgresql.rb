log 'configuring postgres'

include_recipe 'postgresql::ruby'
include_recipe 'postgresql::server'

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