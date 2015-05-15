[![Circle CI](https://circleci.com/gh/rackspace-cookbooks/automatic_updates.svg?style=svg)](https://circleci.com/gh/rackspace-cookbooks/automatic_updates)

# automatic_updates

Configures automatic updates using yum-cron or unattended-upgrades. Provides a
resource and providers for platforms listed below. Supports two actions,
`:enable` and `:disable`.

## [Changelog](CHANGELOG.md)

See CHANGELOG.md for additional information about changes to this stack over time.

## Supported Platforms

* Ubuntu 14.04
* Ubuntu 12.04
* CentOS 6.5
* CentOS 7.0

## Usage	

### Recipe

#### automatic_updates::default

Enable automatic updates

### Resources

#### automatic_updates

Enable or disable automatique update

#### Actions

* `:enable` enable automatique updates

```
automatic_updates 'default' do
  action :enable
end
```

* `:disable` disable automatique updates
 

```
automatic_updates 'default' do
  action :disable
end
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

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
