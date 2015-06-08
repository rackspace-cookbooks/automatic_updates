#
# Copyright 2015, Rackspace
#

require 'poise'

class Chef
  class Resource
    # Resource definition for automatic_updates
    class AutomaticUpdates < Chef::Resource::LWRPBase
      self.resource_name = :automatic_updates
      actions :enable, :disable
    end
  end
end
