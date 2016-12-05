#
# Cookbook Name:: workflow_inspec_helper
# Recipe:: default
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

include_recipe 'delivery-truck::default'

# Get the delivery-secrets stuff
with_server_config do
  inspec_data = get_project_secrets

  file "#{workflow_workspace}/#{inspec_data['inspec']['ssh-user']}.pem" do
    sensitive true
    content inspec_data['inspec']['ssh-private-key']
  end
end
