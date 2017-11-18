#
# Cookbook:: workstation-cookbook
# Recipe:: ssh
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

# TODO: Refactor to chef-vault per Timberman's blog post http://jtimberman.housepub.org/blog/2013/09/10/managing-secrets-with-chef-vault/

username = node['workstation']['user']
homedir = "/Users/#{username}/"

directory "#{homedir}/.ssh" do
  user username
  group 'staff'
  mode '0700'
  action :create
end 

secrets = chef_vault_item('secrets', username)

log 'message' do
  message "Hello I am #{secrets}!"
  level :warn
end

file "#{homedir}/.ssh/id_rsa" do
  content secrets["ssh_private_key"]
  owner username
  group 'staff'
  mode 0600
end
