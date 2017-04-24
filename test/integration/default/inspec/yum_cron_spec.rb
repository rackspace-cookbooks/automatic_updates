if os[:family] == 'redhat'
  %w(yum-cron yum).each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end

  describe file('/etc/sysconfig/yum-cron') do
    its(:content) { should match(/CHECK_ONLY=no/) }
    its(:content) { should match(/DOWNLOAD_ONLY=no/) }
  end

  describe file('/etc/yum/yum-cron.conf') do
    its(:content) { should match(/download_updates = yes/) }
    its(:content) { should match(/apply_updates = yes/) }
    its(:content) { should match(/update_messages = no/) }
  end

  describe service('yum-cron') do
    it { should be_enabled }
    it { should be_running }
  end
end
