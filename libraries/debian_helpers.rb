# automatic_updates Cookbook Modules
module AutomaticUpdates
  # automatic_updates Cookbook Helpers
  module Helpers
    # Helpers for Debian based systems
    module Debian
      def enable_auto_updates_debian
        package 'debconf-utils' do
          action :upgrade
        end
        package 'unattended-upgrades' do
          response_file 'unattended-upgrades.seed.erb'
          action :upgrade
        end
        unattended_upgrades_file = '/etc/apt/apt.conf.d/50unattended-upgrades'
        execute 'rackspace_allowed_origins' do
          command "perl -pi -e 's/(Allowed-Origins\s*{)/$1\n\t\"serveragent main\";\n\t\"cloudmonitoring main\";/;' #{unattended_upgrades_file}"
          only_if { rackspace? }
          action :run
        end
        # New format(Currently only Deb 7)
        execute 'rackspace_unattended_upgrade' do
          command "perl -pi -e 's/(Unattended-Upgrade::Origins-Pattern\s*{)/$1\n\t\"o=serveragent,a=main\";\n\t\"o=cloudmonitoring,a=main\";/;' #{unattended_upgrades_file}"
          only_if { rackspace? }
          action :run
        end
        execute 'enable_auto_updates' do
          command 'echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean true | debconf-set-selections'
          notifies :run, 'execute[dpkg-reconfigure-unattended-upgrades]', :immediately
        end
        execute 'dpkg-reconfigure-unattended-upgrades' do
          command 'dpkg-reconfigure --frontend noninteractive unattended-upgrades'
          action :nothing
        end
      end

      def disable_auto_updates_debian
        execute 'disable_auto_updates' do
          command 'echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean false | debconf-set-selections'
          only_if 'debconf-get-selections | grep unattended-upgrades | grep boolean | grep true'
          notifies :run, 'execute[dpkg-reconfigure-unattended-upgrades]', :immediately
        end
        execute 'dpkg-reconfigure-unattended-upgrades' do
          command 'dpkg-reconfigure --frontend noninteractive unattended-upgrades'
          action :nothing
        end
      end
    end
  end
end
