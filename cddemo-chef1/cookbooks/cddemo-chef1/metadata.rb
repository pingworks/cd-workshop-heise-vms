name             'cddemo-chef1'
maintainer       'Alexander Birk/Christoph Lukas'
maintainer_email 'info@pingworks.de'
license          'Apache License, Version 2.0'
description      'Basic Chef Cookbook'
long_description 'Basic Chef Cookbook'
version '0.1'

supports 'debian'

# we need that so that the system will do an "apt-get update" upfront
depends 'apt'

