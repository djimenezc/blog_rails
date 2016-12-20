# Setup database servers
#
# 1. Setup MySQL and PostgreSQL
# 2. Create a rails user with a blank password with full control

include_recipe 'database2::hello'
# include_recipe 'database2::install_mysql'
include_recipe 'database2::install_postgresql'

