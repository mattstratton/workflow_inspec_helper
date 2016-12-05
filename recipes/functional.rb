#
# Cookbook Name:: automate_inspec_helper
# Recipe:: functional
#
# Copyright 2016 Matt Stratton
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

include_recipe 'delivery-truck::functional'

with_server_config do
  inspec_data = get_project_secrets

  # Search to get nodes
  search_query = "recipes:#{node['delivery']['change']['project']}* AND " \
  "chef_environment:#{delivery_environment}"
  nodes = search('node', search_query.to_s)

  nodes.each do |infra_node|
    case infra_node['os']
    when 'linux'
      ssh_user = inspec_data['inspec']['ssh-user']
      ssh_key_path = "#{workflow_workspace}/"\
      "#{inspec_data['inspec']['ssh-user']}.pem"
      # Execute inspec
      execute 'execute_functional_inspec' do
        command '/opt/chefdk/embedded/bin/inspec ' \
                  "exec #{node['delivery']['workspace']['repo']}/" \
                  'test/recipes/ ' \
                  "-t ssh://#{ssh_user}@#{infra_node['ipaddress']} " \
                  "-i #{ssh_key_path}"
        action :run
        live_stream true
      end
    when 'windows'
      winrm_user = inspec_data['inspec']['winrm-user']
      winrm_password = inspec_data['inspec']['winrm-password']
      file "#{workflow_workspace_repo}/inspec-winrm.sh" do
        content 'Hello'
      end
      execute 'execute_functional_inspec' do
        command '/opt/chefdk/embedded/bin/inspec ' \
                  "exec #{node['delivery']['workspace']['repo']}"\
                  '/test/recipes/ ' \
                  "-t winrm://#{winrm_user}@#{infra_node['ipaddress']} " \
                  "--password '#{winrm_password}'"
        action :run
        live_stream true
      end
    end
  end
end
