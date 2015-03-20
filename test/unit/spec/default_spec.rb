# Encoding: utf-8

require_relative 'spec_helper'

# this will pass on automatic_updates, fail elsewhere, forcing you to
# write those chefspec tests you always were avoiding
describe 'automatic_updates::default' do
  before { stub_resources }
  supported_platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: platform, version: version) do |node|
            node_resources(node)
          end.converge(described_recipe)
        end

        property = load_platform_properties(platform: platform, platform_version: version)

        it "#{property} chefspec must converge" do
          expect(chef_run).to be_truthy
        end
      end
    end
  end
end
