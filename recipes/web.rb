include_recipe "apache2::mod_python"

version = node[:graphite][:version]
pyver = node[:graphite][:python_version]

package "python-cairo-dev"
package "python-django"
package "python-django-tagging"
package "python-memcache"
package "python-rrdtool"

remote_file "/usr/src/graphite-web-#{version}.tar.gz" do
  source node[:graphite][:graphite_web][:uri]
  checksum node[:graphite][:graphite_web][:checksum]
end

execute "untar graphite-web" do
  command "tar xzf graphite-web-#{version}.tar.gz"
  creates "/usr/src/graphite-web-#{version}"
  cwd "/usr/src"
end

execute "install graphite-web" do
  command "python setup.py install"
  creates "#{node[:graphite][:base_dir]}/webapp/graphite_web-#{version}-py#{pyver}.egg-info"
  cwd "/usr/src/graphite-web-#{version}"
end

template "/etc/apache2/sites-available/graphite" do
  source "graphite-vhost.conf.erb"
end

apache_site "graphite"

directory "#{node[:graphite][:base_dir]}/storage" do
  owner node['apache']['user']
  group node['apache']['group']
end

directory "#{node[:graphite][:base_dir]}/storage/log" do
  owner node['apache']['user']
  group node['apache']['group']
end

%w{ webapp whisper }.each do |dir|
  directory "#{node[:graphite][:base_dir]}/storage/log/#{dir}" do
    owner node['apache']['user']
    group node['apache']['group']
  end
end

cookbook_file "#{node[:graphite][:base_dir]}/bin/set_admin_passwd.py" do
  mode "755"
end

cookbook_file "#{node[:graphite][:base_dir]}/storage/graphite.db" do
  action :create_if_missing
  notifies :run, "execute[set admin password]"
end

execute "set admin password" do
  command "#{node[:graphite][:base_dir]}/bin/set_admin_passwd.py root #{node[:graphite][:password]}"
  action :nothing
end

file "#{node[:graphite][:base_dir]}/storage/graphite.db" do
  owner node['apache']['user']
  group node['apache']['group']
  mode "644"
end
