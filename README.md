# automatic_updates

Configures automatic updates using yum-cron or unattended-upgrades. Provides a
resource and providers for platforms listed below. Supports two actions,
`:enable` and `:disable`.

## [Changelog](CHANGELOG.md)

See CHANGELOG.md for additional information about changes to this stack over time.

## Supported Platforms

Ubuntu 14.04

Ubuntu 12.04

CentOS 6.5

CentOS 7.0

## Usage

### automatic_updates::default

Configure automatic updates with the default action of `:enable`.

### automatic_updates LWRP

```
automatic_updates 'default' do
  action :enable
end
```

or, to disable automatic updates:

```
automatic_updates 'default' do
  action :disable
end
```

## Contributing

See [CONTRIBUTING](https://github.com/AutomationSupport/automatic_updates/blob/master/CONTRIBUTING.md).

## Authors

Author:: Rackspace (devops-chef@rackspace.com)

## License
```
# Copyright 2015, Rackspace Hosting
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
```
