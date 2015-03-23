require_relative 'spec_helper'

describe package('yum-cron'), if: rhel? do
  it { should be_installed }
end

describe file('/etc/sysconfig/yum-cron'), if: rhel6? do
  its(:content) { should match(/CHECK_ONLY=no/) }
  its(:content) { should match(/DOWNLOAD_ONLY=no/) }
end

describe file('/etc/yum/yum-cron.conf'), if: rhel7? do
  its(:content) { should match(/download_updates = yes/) }
  its(:content) { should match(/apply_updates = yes/) }
end

describe service('yum-cron'), if: rhel? do
  it { should be_enabled }
  it { should be_running }
end
