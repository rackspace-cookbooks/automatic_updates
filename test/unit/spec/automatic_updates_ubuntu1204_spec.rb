require_relative 'spec_helper'

describe 'automatic_updates_test::* on Ubuntu 12.04' do
  before do
    stub_resources
  end

  UBUNTU1204_OPTS = {
    log_level: LOG_LEVEL,
    platform: 'ubuntu',
    version: '12.04',
    step_into: ['automatic_updates']
  }

  context 'Enable automatic_update' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(UBUNTU1204_OPTS) do |node|
        node_resources(node)
      end.converge('automatic_updates_test::enable')
    end

    it_behaves_like 'enable automatic updates for Ubuntu'
  end

  context 'Disable automatic_update' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(UBUNTU1204_OPTS) do |node|
        node_resources(node)
      end.converge('automatic_updates_test::disable')
    end

    it_behaves_like 'disable automatic updates for Ubuntu'
  end
end
