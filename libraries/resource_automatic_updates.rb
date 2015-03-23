#
# Copyright 2015, Rackspace
#
class Chef
  class Resource::AutomaticUpdates < Resource
    include Poise
    actions(:enable, :disable)
  end
end
