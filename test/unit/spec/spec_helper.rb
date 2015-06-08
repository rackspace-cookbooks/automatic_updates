require 'chefspec'
require 'chefspec/berkshelf'
require_relative 'automatic_updates_shared'

::LOG_LEVEL = ENV['CHEFSPEC_LOG_LEVEL'] ? ENV['CHEFSPEC_LOG_LEVEL'].to_sym : :fatal

def stub_resources
  allow(File).to receive(:exist?).and_call_original
  allow(File).to receive(:exist?).with('/etc/sysconfig/yum-cron').and_return(true)
  allow(File).to receive(:exist?).with('/etc/yum/yum-cron.conf').and_return(true)
  stub_command('which sudo').and_return('/usr/bin/sudo')
  stub_command('debconf-get-selections | grep unattended-upgrades | grep boolean | grep false').and_return(0)
  stub_command('debconf-get-selections | grep unattended-upgrades | grep boolean | grep true').and_return(0)
end

def node_resources(_node)
end

at_exit { ChefSpec::Coverage.report! }
