#
# Cookbook Name:: workstation
# Recipe:: default
#
# Copyright 2017 Matt Stratton
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

username = node['workstation']['user']
homedir = "/Users/#{username}/"

include_recipe 'homebrew'
include_recipe 'homebrew::cask'

package 'git'
package 'zsh'

# install oh-my-zsh

git "#{homedir}/.oh-my-zsh" do
  repository 'https://github.com/robbyrussell/oh-my-zsh.git'
  reference 'master'
  user username
  group 'staff'
  action :checkout
  not_if "test -d #{homedir}/.oh-my-zsh"
end

# install a bunch of homebrew formulae - remove vim from lists because of stupid bug

node['workstation']['homebrew'].to_h.each do |k, v|
  next unless v == true
  package k do
  end
end

# Install casks

node['workstation']['cask'].to_h.each do |k, v|
  next unless v == true
  homebrew_cask k
  end
end

include_recipe 'workstation::dotfiles'

chef_dk 'my_chef_dk' do
  version 'latest'
  global_shell_init false
  action :install
end

execute 'set chefdk permissions' do
  command "sudo chown -R  #{username}:staff #{homedir}/.chefdk"
end

template '/etc/shells' do
  source 'shells.erb'
  owner 'root'
  group 'wheel'
  mode '0644'
end

execute 'change shell to zsh' do
  command "chsh -s /usr/local/bin/zsh #{username}"
  not_if "dscl . -read /Users/#{username} UserShell | grep zsh"
end

include_recipe 'workstation::chef'
include_recipe 'workstation::ssh'

# add battery script

cookbook_file "#{homedir}/battery" do
  source 'battery'
  owner username
  group 'staff'
  mode 0744
end
