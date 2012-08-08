maintainer       "Heavy Water Software Inc."
maintainer_email "ops@hw-ops.com"
license          "Apache 2.0"
description      "Installs/Configures graphite"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.3"

supports "ubuntu"
supports 'redhat'
supports 'centos'

depends "python"
depends "apache2"
depends "runit"
depends "ark"

suggests "graphiti"
