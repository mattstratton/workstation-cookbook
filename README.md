[![Stories in Ready](https://badge.waffle.io/mattstratton/workstation-cookbook.png?label=ready&title=Ready)](https://waffle.io/mattstratton/workstation-cookbook)
workstation
===================

This cookbook is used to configure an OS X workstation according to my needs. Your needs may differ. Bear in mind that using this cookbook may end up with configurations that make you not a happy person.

Requirements
------------
This cookbook assumes OS X 10.11 "El Capitan". It has only been tested with chef-client 12.

### Cookbooks
* git
* homebrew
* chef-dk
* mac-app-store'

Recipes
-----------------

### default
Wrapper recipe that executes all the smaller bits. It's highly unlikely that you wll run a sub-recipe, or that it will even work.

The default recipe also ensures that homebrew is installed, as well as installing zsh and oh-my-zsh.

### dotfiles
configures the dotfiles


Attributes
-----------------
```default['workstation']['user']``` - the username of the local user. This might vary.

```default['workstation']['AWS_ACCESS_KEY_ID']``` - Access key for AWS. Yeah, I know, don't put it in an attribute. This will be refactored to an encrypted databag.

```default['workstation']['AWS_SECRET_ACCESS_KEY']``` - Secret key for AWS. See above.

```default['mac_app_store']['apps']```- comma-delimited array of apps to install from the Mac App Store

```default['workstation']['teamocil']``` - comma-delimited array of teamocil configuration files

License & Authors
-----------------

- Author:: Matt Stratton (<matt.stratton@gmail.com>)

```text

Copyright:: 2015-2016, Matt Stratton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
