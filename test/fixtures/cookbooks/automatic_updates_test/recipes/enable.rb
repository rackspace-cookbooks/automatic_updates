# comments!
include_recipe 'disable_ipv6'

automatic_updates 'default' do
  action :enable
end
