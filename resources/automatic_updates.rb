resource_name :automatic_updates

property :name, name_property: true

default_action :enable

action_class do
  include AutomaticUpdates::Helpers::Debian
  include AutomaticUpdates::Helpers::Rhel
end

action :enable do
  include_recipe 'chef-sugar'
  enable_auto_updates_rhel if rhel?
  enable_auto_updates_debian if debian?
end

action :disable do
  disable_auto_updates_rhel if rhel?
  disable_auto_updates_debian if debian?
end
