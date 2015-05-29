workstation
===================

This cookbook is used to configure an OS X workstation according to my needs. Your needs may differ. Bear in mind that using this cookbook may end up with configurations that make you not a happy person.

Requirements
------------
This cookbook assumes OS X 10.10 "Yosemite". It has only been tested with chef-client 12.

### Cookbooks
* git
* zsh

Recipes
-----------------

### default
does default things

### dotfiles
configures the dotfiles

Attributes
-----------------
```default['workstation']['user']``` - the username of the local user. This might vary.

License & Authors
-----------------

- Author:: Matt Stratton (<matt.stratton@gmail.com>)

```text

Copyright:: 2015, Matt Stratton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
