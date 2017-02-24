require 'spec_helper'

describe 'automatic_updates_test::* on Ubuntu 16.04' do
  before do
    stub_resources
  end

  UBUNTU1604_OPTS = {
    log_level: LOG_LEVEL,
    platform: 'ubuntu',
    version: '16.04',
    step_into: ['automatic_updates'],
  }.freeze

  context 'Enable automationc_update' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(UBUNTU1604_OPTS) do |node|
        node_resources(node)
      end.converge('automatic_updates_test::enable')
    end

    it_behaves_like 'enable automatic updates for Ubuntu'
  end

  context 'Disable automationc_update' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(UBUNTU1604_OPTS) do |node|
        node_resources(node)
      end.converge('automatic_updates_test::disable')
    end

    it_behaves_like 'disable automatic updates for Ubuntu'
  end
end
