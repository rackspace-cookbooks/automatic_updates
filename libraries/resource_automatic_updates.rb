#
# Copyright 2015, Rackspace
#

require 'poise'

class Chef
  class Resource::AutomaticUpdates < Resource
    include Poise
    actions(:enable, :disable)
  end
end
