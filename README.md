Description
===========

Installs and configures Graphite http://graphite.wikidot.com/

Requirements
============

* Ubuntu 10.04 (Lucid) - with default settings
* Ubuntu 11.10 (Oneiric) - change node[:graphite][:python_version] to "2.7"

Attributes
==========

* `node[:graphite][:password]` sets the default password for graphite "root" user.
* `node[:graphite][:version]` sets the version to install
* `node[:graphite][:python_version]` sets the version to install
* `node[:graphite][:base_dir]` sets the base directory to install. Defaults to "/opt/graphite"
* `node[:graphite][:graphite_web][:http_port]` sets the port for the vhost to listen on
* `node[:graphite][:graphite_web][:additional_vhost_config` adds the following to the vhost config under the /Location block

For more details look in the attributes/defaults section

Usage
=====

`recipe[graphite]` should build a stand-alone Graphite installation.

`recipe[graphite::ganglia]` integrates with Ganglia. You'll want at
least one monitor node (i.e. recipe[ganglia]) node to be running
to use it.

Caveats
=======

Ships with two default schemas, stats.* (for Etsy's statsd) and a
catchall that matches anything. The catchall retains minutely data for
13 months, as in the default config. stats retains data every 10 seconds
for 6 hours, every minute for a week, and every 10 minutes for 5 years.
