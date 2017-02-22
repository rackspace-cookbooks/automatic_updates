# automatic_updates Cookbook Modules
module AutomaticUpdates
  # automatic_updates Cookbook Helpers
  module Helpers
    # Helpers for RHEL based systems
    module Rhel
      def enable_auto_updates_rhel
        %w(
          yum
          yum-cron
        ).each do |pkg|
          package pkg do
            action :upgrade
          end
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
            notifies :restart, 'service[yum-cron]', :delayed
          end
        end

        service 'yum-cron' do
          supports restart: true, reload: true, status: true
          action [:enable, :start]
        end
      end

      def disable_auto_updates_rhel
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
            notifies :stop, 'service[yum-cron]', :delayed
          end
        end

        service 'yum-cron' do
          supports restart: true, reload: true, status: true
          action [:disable, :stop]
        end
      end
    end
  end
end
