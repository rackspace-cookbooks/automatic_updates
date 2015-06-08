#
# Copyright 2015, Rackspace
#

require 'poise'

class Chef
  class Provider
    # Provider definition for automatic_updates
    class AutomaticUpdatesUbuntu < Chef::Provider::LWRPBase
      def action_enable
        converge_by('enable unattended upgrade') do
          run_context.include_recipe 'chef-sugar'
          package 'debconf-utils' do
            action :nothing
          end.run_action(:install)

          package 'unattended-upgrades' do
            response_file 'unattended-upgrades.seed.erb'
            action :nothing
          end.run_action(:install)

          unattended_upgrade_file = '/etc/apt/apt.conf.d/50unattended-upgrades'

          # allow agent and cloud monitoring to update as well
          if rackspace?
            execute "perl -pi -e 's/(Allowed-Origins\s*{)/$1\n\t\"serveragent main\";\n\t\"cloudmonitoring main\";/;' #{unattended_upgrade_file}"
            # New format(Currently only Deb 7)
            execute "perl -pi -e 's/(Unattended-Upgrade::Origins-Pattern\s*{)/$1\n\t\"o=serveragent,a=main\";\n\t\"o=cloudmonitoring,a=main\";/;' #{unattended_upgrade_file}"
          end

          # while these are not as pretty as chef resources, they are the recommended way by the OS
          execute 'enable_auto_updates' do
            command 'echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean true | debconf-set-selections'
            only_if 'debconf-get-selections | grep unattended-upgrades | grep boolean | grep false'
            notifies :run, 'execute[dpkg-reconfigure-unattended-upgrades]', :immediately
          end

          execute 'dpkg-reconfigure-unattended-upgrades' do
            command 'dpkg-reconfigure --frontend noninteractive unattended-upgrades'
            action :nothing
          end
        end
      end

      def action_disable
        converge_by('disable unattended upgrade') do
          # while these are not as pretty as chef resources, they are the recommended way by the OS
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
end
