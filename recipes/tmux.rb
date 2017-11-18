#
# Cookbook:: workstation-cookbook
# Recipe:: tmux
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

package tmux

# tmux config

template "#{homedir}/.tmux.conf" do
  source 'tmux.conf.erb'
  user username
  group 'staff'
  mode '0644'
  action :create_if_missing
end

# install tpm

directory "#{homedir}/.tmux/" do
  user username
  group 'staff'
  recursive true
end

directory "#{homedir}/.tmux/plugins" do
  user username
  group 'staff'
  recursive true
end

git "#{homedir}/.tmux/plugins/tpm" do
  repository 'https://github.com/tmux-plugins/tpm'
  reference 'master'
  user username
  group 'staff'
  action :checkout
  not_if "test -d #{homedir}/.tmux/plugins/tpm/tpm"
end

# install teamocil

execute 'install teamocil' do
  command 'chef gem install teamocil'
  user username
  only_if 'chef', :user => username
end

# teamocil config

directory "#{homedir}/.teamocil" do
  user username
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
    user username
    group 'staff'
    mode '0744'
    action :create
  end
end