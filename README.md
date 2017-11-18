# workstation

This cookbook is used to configure an OS X workstation according to my needs. Your needs may differ. Bear in mind that using this cookbook may end up with configurations that make you not a happy person.

##Requirements

This cookbook assumes OS X 10.13 "High Sierra". It has only been tested with chef-client 13.

### Dependent Cookbooks

* git
* homebrew
* chef-dk
* mac-app-store

## Recipes

### default

Wrapper recipe that executes all the smaller bits. It's highly unlikely that you wll run a sub-recipe, or that it will even work.

The default recipe also ensures that homebrew is installed, as well as installing zsh and oh-my-zsh.

### dotfiles

configures the dotfiles

### chef

Sets up the `.chef` directory, including the `USERNAME.pem` and the `knife.rb`.

### mas

Installs applications from the Mac App Store. Set in a different recipe as it's not delightful for automated testing

### ssh

Configures the user's `.ssh` directory, including public and private keys as well as the `config` file.

### tmux

Configures `tmux`.

### vscode

Installs and configures Visual Studio Code, including extensions.

## Attributes
`default['workstation']['user']` - the username of the local user. This might vary.

`default['workstation']['AWS_ACCESS_KEY_ID']` - Access key for AWS. Yeah, I know, don't put it in an attribute. This will be refactored to an encrypted databag.

`default['workstation']['AWS_SECRET_ACCESS_KEY']` - Secret key for AWS. See above.

`default['mac_app_store']['apps']`- comma-delimited array of apps to install from the Mac App Store

`default['workstation']['homebrew']`- comma-delimited array of formulae to install via homebrew

`default['workstation']['cask']`- comma-delimited array of casks to install via homebrew

`default['workstation']['teamocil']` - comma-delimited array of teamocil configuration files

## Data Bags

### keys

### passwords

### users

## Notes

### Private Key

Needs to be converted to a one-liner. Something like this will do the trick:

``` shell

ruby -rjson -e 'puts JSON.generate({"vaultuser-ssh-private" => File.read("vaultuser-ssh")})' > secrets_vaultuser-ssh-private.json

```

*Thanks to [Josh Timberman](http://jtimberman.housepub.org/blog/2013/09/10/managing-secrets-with-chef-vault/) for that one*

## License & Authors

* Author:: Matt Stratton (<matt.stratton@gmail.com>)

```text

Copyright:: 2015-2017, Matt Stratton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
