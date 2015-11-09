# provider mappings for Chef 11
# https://www.chef.io/blog/2015/02/10/chef-12-provider-resolver/

#########
# automatic_updates
#########
[:centos, :redhat, :amazon].each do |rh_platform|
  Chef::Platform.set platform: rh_platform, resource: :automatic_updates, provider: Chef::Provider::AutomaticUpdatesCentOS
end

Chef::Platform.set platform: :ubuntu, resource: :automatic_updates, provider: Chef::Provider::AutomaticUpdatesUbuntu
