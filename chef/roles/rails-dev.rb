name 'rails-dev'
description 'setup for ruby on rails core development'

# override_attributes(
#     "mysql" => {
#         "server_root_password" => 'iloverandompasswordsbutthiswilldo',
#         "server_repl_password" => 'iloverandompasswordsbutthiswilldo',
#         "server_debian_password" => 'iloverandompasswordsbutthiswilldo'
#     }
# )

run_list(
    'recipe[apt]',
    'recipe[git]',
    'recipe[sqlite]',
    'recipe[mysql_config]',
    'recipe[vim]',
    # 'recipe[mysql::client]',
    # 'recipe[mysql::ruby]',
    # 'recipe[mysql::server]',
    'recipe[postgresql::ruby]',
    'recipe[postgresql::server]',
    'recipe[nodejs::nodejs_from_binary]',
    'recipe[ruby_build]',
    'recipe[rbenv::system]',
    'recipe[rbenv::vagrant]',
    'recipe[database]',
    'recipe[postinstall]'
)
default_attributes(
    'build_essential' => {
        'compiletime' => true
    }
)