# Encoding: utf-8
require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'
require 'json'

Dir['./test/unit/spec/support/**/*.rb'].sort.each { |f| require f }

::LOG_LEVEL = :fatal
::CHEFSPEC_OPTS = {
  log_level: ::LOG_LEVEL
}

def node_resources(node)
  node.automatic['rackspace'] = true
  node.automatic['cloud'] = true
end

def stub_resources
  stub_command('which sudo').and_return('/usr/bin/sudo')
  stub_command('debconf-get-selections | grep unattended-upgrades | grep boolean | grep false').and_return(0)
end

at_exit { ChefSpec::Coverage.report! }
