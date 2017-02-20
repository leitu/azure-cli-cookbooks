#
# Cookbook Name:: azurecli::_azure_python
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node['platform_family']
when 'rhel'
  package 'openssl-devel'
when 'debain'
  package 'libssl-dev'
end

python_runtime node['azurecli']['azure']['python']['version'] do
  provider node['azurecli']['azure']['python']['provider']
end

unless node['azurecli']['azure']['virtualenv'].nil?
  python_virtualenv node['azurecli']['azure']['virtualenv']

  python_package 'azure-cli' do
    version node['azurecli']['azure']['cli_version'] if node['azurecli']['azure']['cli_version']
    virtualenv node['azurecli']['azure']['virtualenv']
  end
else
  python_package 'azure-cli' do
    version node['azurecli']['azure']['cli_version'] if node['azurecli']['azure']['cli_version']
  end
end
