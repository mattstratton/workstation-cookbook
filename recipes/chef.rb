#
# Cookbook:: workstation-cookbook
# Recipe:: chef
#
# Copyright:: 2017, Matt Stratton
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

# Create .chef directory

directory "/Users/#{node['workstation']['user']}/.chef/" do
  user node['workstation']['user']
  group 'staff'
  mode '0644'
  recursive true
end

# Create knife.rb

template "/Users/#{node['workstation']['user']}/.chef/knife.rb" do
  user node['workstation']['user']
  group 'staff'
  mode '0644'
  action :create_if_missing
  source 'knife.rb.erb'
end

secrets = chef_vault_item('secrets', username)

file "#{homedir}/.chef/{#node['workstation']['chef']['user']}" do
  content secrets["chef_private_key"]
  owner username
  group 'staff'
  mode 0600
end
