shared_examples_for 'enable automatic updates for Ubuntu' do
  it 'installs debconf-utils and unattended-upgrades' do
    expect(chef_run).to install_package('unattended-upgrades')
    expect(chef_run).to install_package('debconf-utils')
  end

  it 'enables enable_auto_updates' do
    execute_enable = chef_run.execute('enable_auto_updates')
    expect(execute_enable).to notify('execute[dpkg-reconfigure-unattended-upgrades]').to(:run).immediately
    expect(chef_run).to run_execute('enable_auto_updates')
    execute = chef_run.execute('dpkg-reconfigure-unattended-upgrades')
    expect(execute).to do_nothing
  end
end

shared_examples_for 'disable automatic updates for Ubuntu' do
  it 'disables enable_auto_updates' do
    execute_disable = chef_run.execute('disable_auto_updates')
    expect(execute_disable).to notify('execute[dpkg-reconfigure-unattended-upgrades]').to(:run).immediately
    expect(chef_run).to run_execute('disable_auto_updates')
    execute = chef_run.execute('dpkg-reconfigure-unattended-upgrades')
    expect(execute).to do_nothing
  end
end
