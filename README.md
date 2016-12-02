[![Build Status](https://travis-ci.org/mattstratton/automate_inspec_helper.svg?branch=master)](https://travis-ci.org/mattstratton/automate_inspec_helper)

# automate_inspec_helper

Provides helper recipes to enable [InSpec](https://www.inspec.io) tests in Chef Workflow

## Usage

In your build cookbook, add the following to your `metadata.rb`

`depends 'automate_inspec_helper'`

For now, you will also need to add the following to your build cookbook's `Berksfile`:

`  cookbook 'automate_inspec_helper', git: 'https://github.com/mattstratton/automate_inspec_helper'`

Add the following to your `default.rb` in your build cookbook:

`include_recipe 'automate_inspec_helper::default'`

Add the following to your `functional.rb` in your build cookbook:

`include_recipe 'automate_inspec_helper::functional'`

This cookbook makes heavy use of the `delivery-secrets` databag from `delivery-sugar`. Create an encrypted databag that contains the following item:

```
{
 "id": "<your-enterprise>-<your-organization>",
 "inspec": {
   "ssh-user": "inspec",
   "ssh-private-key": "<YOUR-PRIVATE-KEY-HERE",
   "ssh-public-key": "<YOUR-PUBLIC-KEY-HERE",
   "winrm-user": "inspec",
   "winrm-password": "<YOUR-PASSWORD-HERE>"
 }
}
```

For example, if your Workflow enterprise is "bluth" and the organization is "bananastand", the databag item should be called `bluth-bananastand`.

The key used to encrypt this databag needs to be copied to `/etc/chef/encrypted_data_bag_secret` on all of your builders/runners.

### Linux Infrastructure Nodes
The public key must be added to `authorized_keys` for a user named `inspec` (which needs passwordless sudo) on all of your infrastructure nodes where you wish to run the inspec test (i.e., acceptance, union, rehearsal, and delivered).

### Windows Infrastructure Nodes
The key use to encrypt the databag also must be added to `/etc/chef/encrypted_data_bag_secret` on your Linux infrastructure nodes, or to `c:\chef\encrypted_data_bag_secret` on any Windows infrastructure nodes. A user named 'inspec' with the password set in `winrm-password` must be created on these nodes, and added to the Administrators group. Additionally, WinRM must be allowed to these infrastructure nodes from your builders/runners.



## License & Authors
- Author:: Matt Stratton (<matt.stratton@gmail.com>)

Special thanks to Tom Robinson-Gore for insight and suggestions

```text
Copyright:: 2016 Matt Stratton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
