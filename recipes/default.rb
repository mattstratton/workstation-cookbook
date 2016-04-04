#
# Cookbook Name:: workstation
# Recipe:: default
#
# Copyright 2015 Matt Stratton
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

include_recipe 'homebrew'
include_recipe 'homebrew::cask'

package 'git'
package 'zsh'
# install oh-my-zsh

git "/Users/#{node['workstation']['user']}/.oh-my-zsh" do
  repository "https://github.com/robbyrussell/oh-my-zsh.git"
  reference "master"
  user node['workstation']['user']
  group 'staff'
  action :checkout
  not_if "test -d /Users/#{node['workstation']['user']}/.oh-my-zsh"
end

# oh-my-zsh config

template "/Users/#{node['workstation']['user']}/.zshrc" do
  source 'zshrc.erb'
  user node['workstation']['user']
  group 'staff'
  mode '0644'
  action :create_if_missing
end

include_recipe 'workstation::vim'
# install a bunch of packages

%w[
  vim
  tmux
  tree
  wget
  packer
  cowsay
  fortune
].each do |p|
  package p
end

# install a bunch of Applications

%w[
  atom
  iterm2
  tower
  beyond-compare
  alfred
  dropbox
  textexpander
  bartender
  clarify
  codekit
  omnigraffle
  omnifocus
  visual-studio-code
  rescuetime
].each do |app|
  homebrew_cask app
end

# install tpm

directory "/Users/#{node['workstation']['user']}/.tmux/" do
  user node['workstation']['user']
  group 'staff'
  recursive true
end

directory "/Users/#{node['workstation']['user']}/.tmux/plugins" do
  user node['workstation']['user']
  group 'staff'
  recursive true
end

git "/Users/#{node['workstation']['user']}/.tmux/plugins/tpm" do
  repository "https://github.com/tmux-plugins/tpm"
  reference "master"
  user node['workstation']['user']
  group 'staff'
  action :checkout
  not_if "test -d /Users/#{node['workstation']['user']}/.tmux/plugins/tpm/tpm"
end

include_recipe 'workstation::dotfiles'

chef_dk 'my_chef_dk' do
    version 'latest'
    global_shell_init true
    action :install
end

template '/etc/shells' do
  source 'shells.erb'
  owner 'root'
  group 'wheel'
  mode '0644'
end

execute 'change shell to zsh' do
  command "chsh -s /usr/local/bin/zsh #{node['workstation']['user']}"
  # Should add a guard using dscl . -read /Users/#{node['workstation']['user']} UserShell
end

include_recipe 'mac-app-store::default'
