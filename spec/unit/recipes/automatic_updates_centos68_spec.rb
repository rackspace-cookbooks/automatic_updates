require 'spec_helper'

describe 'automatic_updates_test::* on Centos 6.8' do
  before do
    stub_resources
  end

  CENTOS68_OPTS = {
    log_level: LOG_LEVEL,
    platform: 'centos',
    version: '6.8',
    step_into: ['automatic_updates'],
  }.freeze

  context 'Enable automationc_update' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(CENTOS68_OPTS) do |node|
        node_resources(node)
      end.converge('automatic_updates_test::enable')
    end

    it_behaves_like 'installs package yum on CentOS'

    it 'calls automatic_updates with the enable action' do
      expect(chef_run).to enable_automatic_updates('default')
    end

    it 'installs yum-cron' do
      expect(chef_run).to upgrade_package('yum-cron')
    end

    it 'enables automatic updates in yum-cron' do
      expect(chef_run).to render_file('/etc/sysconfig/yum-cron').with_content('DOWNLOAD_ONLY=no')
    end
    it 'enables automatic updates in yum-cron.conf' do
      expect(chef_run).to render_file('/etc/yum/yum-cron.conf').with_content('apply_updates = yes')
    end

    it 'enables and starts yum-cron service' do
      expect(chef_run).to enable_service('yum-cron')
      expect(chef_run).to start_service('yum-cron')
    end
  end

  context 'Disable automationc_update' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(CENTOS68_OPTS) do |node|
        node_resources(node)
      end.converge('automatic_updates_test::disable')
    end

    it 'calls automatic_updates with the disable action' do
      expect(chef_run).to disable_automatic_updates('default')
    end

    it 'enables automatic updates in yum-cron' do
      expect(chef_run).to render_file('/etc/sysconfig/yum-cron').with_content('DOWNLOAD_ONLY=yes')
    end
    it 'enables automatic updates in yum-cron.conf' do
      expect(chef_run).to render_file('/etc/yum/yum-cron.conf').with_content('apply_updates = no')
    end

    it 'disables and starts yum-cron service' do
      expect(chef_run).to disable_service('yum-cron')
      expect(chef_run).to stop_service('yum-cron')
    end
  end
end
