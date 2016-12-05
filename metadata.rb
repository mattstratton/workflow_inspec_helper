name 'automate_inspec_helper'
maintainer 'Matt Stratton'
maintainer_email 'matt.stratton@gmail.com'
license 'apachev2'
description 'Provides helper recipes to enable InSpec tests in Chef Workflow'
long_description 'Provides helper recipes to enable InSpec tests in Chef Workflow'
version '0.1.1'

depends 'delivery-truck'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
issues_url 'https://github.com/mattstratton/automate_inspec_helper/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
source_url 'https://github.com/mattstratton/automate_inspec_helper' if respond_to?(:source_url)
