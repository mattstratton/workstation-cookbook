#
# Cookbook Name:: workstation
# Recipe:: dotfiles
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

teamocil = (node['workstation']['teamocil'] || []).map do |t|
  if t.is_a?(Hash)
    t
  elsif t.is_a?(String)
    { name: t }
  else
    fail(Chef::Exceptions::ValidationFailed, "Invalid teamocil entry '#{t}'")
  end
end

teamocil.each do |t|
  file "#{homedir}/.teamocil/#{t[:name]}.yml" do
    user node['workstation']['user']
    group 'staff'
    mode '0744'
    action :create
  end
end

# zsh config
template "#{homedir}/.zshrc" do
  source 'zshrc.erb'
  owner node['workstation']['user']
  group 'staff'
  mode 0744
  variables({
    :username => node['workstation']['user']
  })
