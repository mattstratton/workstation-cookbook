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

username = node['workstation']['user']
homedir = "/Users/#{username}/"
secrets = chef_vault_item('secrets', username)

# git config file

template "#{homedir}/.gitconfig" do
  source 'gitconfig.erb'
  user username
  group 'staff'
  mode '0644'
end

# global gitignore

template "#{homedir}/.gitignore_global" do
  source 'gitignore_global.erb'
  user username
  group 'staff'
  mode '0644'
end

# oh-my-zsh config

template "#{homedir}/.zshrc" do
  source 'zshrc.erb'
  owner username
  group 'staff'
  mode 0744
  variables({
    :username => username,
    :aws_access_key_id => secrets['aws_access_key_id'],
    :aws_secret_access_key => secrets['aws_secret_access_key'],
    :github_token => secrets['github_token'],
    :changelog_github_token => secrets['changelog_github_token'],
    :bowie_github_token => secrets['bowie_github_token'],
    :pd_token => secrets['pd_token'],
    :hab_auth_token => secrets['hab_auth_token'],
    :atlas_token => secrets['atlas_token'],
  })
  sensitive true
end
