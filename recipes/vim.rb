#
# Cookbook Name:: workstation
# Recipe:: vim
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

# install atom

homebrew_cask "atom"

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
