include_recipe "apache2::mod_python"

version = node[:graphite][:version]
pyver = node[:graphite][:python_version]

package node[:graphite][:package][:python_cairo_dev]
package node[:graphite][:package][:python_django]
package node[:graphite][:package][:python_django_tagging]
package node[:graphite][:package][:python_memcache]

if platform? 'redhat','scientific','amazon','fedora','centos'
  package 'bitmap-fixed-fonts'
else
  # can't find this package in any rhel-related repository
  package "python-rrdtool"
end

ark 'graphite-web' do
  version node[:graphite][:version]
  path '/usr/src'
  url node[:graphite][:graphite_web][:uri]
  checksum node[:graphite][:graphite_web][:checksum]
  creates "/opt/graphite/lib/graphite_web-#{version}-py#{pyver}.egg-info"
  action [:install, :setup_py]
end

template node[:graphite][:apache_vhost_path] do
  source "graphite-vhost.conf.erb"
end

apache_site "graphite"

directory "/opt/graphite/storage" do
  owner node['apache']['user']
  group node['apache']['group']
end

directory '/opt/graphite/storage/log' do
  owner node['apache']['user']
  group node['apache']['group']
end

%w{ webapp whisper }.each do |dir|
  directory "/opt/graphite/storage/log/#{dir}" do
    owner node['apache']['user']
    group node['apache']['group']
  end
end

cookbook_file "/opt/graphite/bin/set_admin_passwd.py" do
  mode "755"
end

cookbook_file "/opt/graphite/storage/graphite.db" do
  action :create_if_missing
  notifies :run, "execute[set admin password]"
end

execute "set admin password" do
  command "/opt/graphite/bin/set_admin_passwd.py root #{node[:graphite][:password]}"
  action :nothing
end

file "/opt/graphite/storage/graphite.db" do
  owner node['apache']['user']
  group node['apache']['group']
  mode "644"
end
