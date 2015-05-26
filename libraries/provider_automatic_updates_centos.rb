#
# Copyright 2015, Rackspace
#

require 'poise'

class Chef
  class Provider::AutomaticUpdatesCentOS < Provider
    include Poise
    include Chef::Mixin::ShellOut

    def action_enable
      converge_by('install yum-cron and configure service') do
        notifying_block do
          include_recipe 'chef-sugar'
          require 'chef/sugar'
          unless rhel? && cloud?
            Chef::Log.warn('Not configuring automatic updates, as they are not supported on this platform or this is not a cloud server')
            return
          end

          package 'yum-cron' do
            action :install
          end

          # template any relevant files (gets around checking for versions)
          %w(/etc/sysconfig/yum-cron /etc/yum/yum-cron.conf).each do |settings_file|
            template settings_file do
              owner 'root'
              group 'root'
              mode '0644'
              cookbook 'automatic_updates'
              variables(
                automatic_updates_enabled: 'yes',
                download_only: 'no'
              )
              only_if { rhel? && ::File.exist?(settings_file) }
              notifies :restart, 'service[yum-cron]', :delayed
            end
          end

          service 'yum-cron' do
            service_name 'yum-cron'
            if node['platform_family'] == 'rhel'
              supports restart: true, reload: true, status: true
            end
            action [:enable, :start]
          end
        end
      end
    end

    def action_disable
      converge_by('disable yum-cron service') do
        notifying_block do
          # template any relevant files (gets around checking for versions)
          %w(/etc/sysconfig/yum-cron /etc/yum/yum-cron.conf).each do |settings_file|
            template settings_file do
              owner 'root'
              group 'root'
              mode '0644'
              cookbook 'automatic_updates'
              variables(
                automatic_updates_enabled: 'no',
                download_only: 'yes'
              )
              only_if { rhel? && ::File.exist?(settings_file) }
              notifies :stop, 'service[yum-cron]', :delayed
              # action :nothing
            end
          end

          service 'yum-cron' do
            service_name 'yum-cron'
            if node['platform_family'] == 'rhel'
              supports restart: true, reload: true, status: true
            end
            action [:disable, :stop]
          end
        end
      end
    end
  end
end
