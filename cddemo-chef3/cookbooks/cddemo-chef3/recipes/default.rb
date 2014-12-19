#
# Cookbook Name:: cddemo-chef1
# Recipe:: default
#
# Copyright 2014 pingworks - Alexander Birk und Christoph Lukas
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
#

include_recipe 'apt'

%w(vim less git wget zip unzip).each do |p|
  package p do
    action :install
  end
end

# configure eth1
cookbook_file 'interfaces' do
  path '/etc/network/interfaces'
  owner 'root'
  group 'root'
  mode '644'
end

execute 'ifup_eth1' do
  command '/sbin/ifup eth1'
end

cookbook_file 'hosts' do
  path '/etc/hosts'
  owner 'root'
  group 'root'
  mode '644'
end

include_recipe 'tomcat'

# Install bundle download script
cookbook_file 'download-bundle.sh' do
  path '/usr/local/bin/download-bundle.sh'
  owner 'root'
  group 'root'
  mode '755'
end

# setup ssh authorization for jenkins
directory '/usr/share/tomcat7/.ssh' do
  owner 'tomcat7'
  group 'tomcat7'
  mode '0700'
  action :create
end

cookbook_file 'authorized_keys' do
  path '/usr/share/tomcat7/.ssh/authorized_keys'
  owner 'tomcat7'
  group 'tomcat7'
  mode '600'
end

# create /var/bundle dir
directory '/var/bundle' do
  owner 'tomcat7'
  group 'tomcat7'
  mode '0755'
  action :create
end

# setup sudo rights for tomcat7 user
cookbook_file 'sudoers_tomcat7' do
  path '/etc/sudoers.d/tomcat7'
  owner 'root'
  group 'root'
  mode '600'
end

# change login shell of user tomcat7 to /bin/bash
user 'tomcat7' do
  shell '/bin/bash'
  action :modify
end

