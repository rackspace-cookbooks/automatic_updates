shared_examples_for 'enable automatic updates for Ubuntu' do
  it 'installs debconf-utils and unattended-upgrades' do
    expect(chef_run).to upgrade_package('unattended-upgrades')
    expect(chef_run).to upgrade_package('debconf-utils')
  end

  it 'enables enable_auto_updates' do
    execute_enable = chef_run.execute('enable_auto_updates')
    expect(execute_enable).to notify('execute[dpkg-reconfigure-unattended-upgrades]').to(:run).immediately
    expect(chef_run).to run_execute('enable_auto_updates')
    execute = chef_run.execute('dpkg-reconfigure-unattended-upgrades')
    expect(execute).to do_nothing
  end

  it 'updates allowed origins and enables unattended_upgrades on rackspace systems' do
    expect(chef_run).to_not run_execute('rackspace_allowed_origins')
    expect(chef_run).to_not run_execute('rackspace_unattended_upgrade')
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

shared_examples_for 'installs package yum on CentOS' do
  it 'installs yum' do
    expect(chef_run).to upgrade_package('yum')
  end
end
