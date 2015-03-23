require_relative 'spec_helper'

describe file('/etc/apt/apt.conf.d/50unattended-upgrades'), if: ubuntu? do
  its(:content) { should match(/serveragent main/) }
  its(:content) { should match(/cloudmonitoring main/) }
end

%w(unattended-upgrades debconf).each do |pkg|
  describe package(pkg), if: ubuntu? do
    it { should be_installed }
  end
end

describe command('debconf-get-selections'), if: ubuntu?  do
  its(:stdout) { should match(/unattended-upgrades\sunattended-upgrades\/enable_auto_updates\sboolean\strue/) }
end
