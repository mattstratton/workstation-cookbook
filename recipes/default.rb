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

include_recipe 'workstation::vim'
include_recipe 'workstation::dotfiles'

# install iterm
remote_file "#{Chef::Config[:file_cache_path]}/iTerm2_v2_0.zip" do
  source 'https://iterm2.com/downloads/stable/iTerm2_v2_0.zip'
end

execute 'Install iTerm' do
  command "unzip #{Chef::Config[:file_cache_path]}/iTerm2_v2_0.zip -d /Applications"
  not_if { ::File.exists?('/Applications/iTerm.app') }
end
