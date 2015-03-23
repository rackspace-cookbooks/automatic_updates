# provider mappings for Chef 11
# https://www.chef.io/blog/2015/02/10/chef-12-provider-resolver/

#########
# automatic_updates
#########
Chef::Platform.set platform: :centos, resource: :automatic_updates, provider: Chef::Provider::AutomaticUpdatesCentOS
Chef::Platform.set platform: :redhat, resource: :automatic_updates, provider: Chef::Provider::AutomaticUpdatesCentOS
Chef::Platform.set platform: :ubuntu, resource: :automatic_updates, provider: Chef::Provider::AutomaticUpdatesUbuntu
