#
# Cookbook Name:: workstation
# Recipe:: dotfiles
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

homedir = "/Users/#{node['workstation']['user']}/"

# git config file

template "#{homedir}/.gitconfig" do
  source 'gitconfig.erb'
  user node['workstation']['user']
  group 'staff'
  mode '0644'
end

# global gitignore

template "#{homedir}/.gitignore_global" do
  source 'gitignore_global.erb'
  user node['workstation']['user']
  group 'staff'
  mode '0644'
end

# tmux config

template "#{homedir}/.tmux.conf" do
  source 'tmux.conf.erb'
  user node['workstation']['user']
  group 'staff'
  mode '0644'
  action :create_if_missing
end

# teamocil config

directory "#{homedir}/.teamocil" do
  user node['workstation']['user']
  group 'staff'
  mode '0744'
  action :create
end

## add templates for teamocil once I get them

# .chef config

directory "#{homedir}/.chef" do
  user node['workstation']['user']
  group 'staff'
  mode '0744'
  action :create
end

vault_mattstratton_pem = ChefVault::Item.load("secrets", "mattstratton-pem")

file "#{homedir}/.chef/mattstratton.pem" do
  content vault_mattstratton_pem["mattstratton-pem"]
  owner node['workstation']['user']
  group 'staff'
  mode 0600
end
