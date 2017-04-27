# Encoding: utf-8
name 'automatic_updates'
maintainer 'Rackspace'
maintainer_email 'rackspace-cookbooks@rackspace.com'
license 'Apache 2.0'
description 'Installs/Configures automatic_updates'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://github.com/rackspace-cookbooks/automatic_updates'
issues_url 'https://github.com/rackspace-cookbooks/automatic_updates/issues'
version '0.2.2'

depends 'apt'
depends 'chef-sugar'
depends 'yum'
