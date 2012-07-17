package "python-twisted"
package "python-simplejson"

version = node[:graphite][:version]
pyver = node[:graphite][:python_version]

ark 'carbon' do
  version node[:graphite][:version]
  path '/usr/src'
  url node[:graphite][:carbon][:uri]
  checksum node[:graphite][:carbon][:checksum]
  creates "/opt/graphite/lib/carbon-#{version}-py#{pyver}.egg-info"
  action [:install, :setup_py]
end

template "/opt/graphite/conf/carbon.conf" do
  owner node['apache']['user']
  group node['apache']['group']
  variables( :line_receiver_interface => node[:graphite][:carbon][:line_receiver_interface],
             :pickle_receiver_interface => node[:graphite][:carbon][:pickle_receiver_interface],
             :cache_query_interface => node[:graphite][:carbon][:cache_query_interface] )
  notifies :restart, "service[carbon-cache]"
end

template "/opt/graphite/conf/storage-schemas.conf" do
  owner node['apache']['user']
  group node['apache']['group']
end

execute "carbon: change graphite storage permissions to apache user" do
  command "chown -R #{node['apache']['user']}:#{node['apache']['group']} /opt/graphite/storage"
  only_if do
    f = File.stat("/opt/graphite/storage")
    f.uid == 0 and f.gid == 0
  end
end

directory "/opt/graphite/lib/twisted/plugins/" do
  owner node['apache']['user']
  group node['apache']['group']
end

if platform? 'ubuntu', 'debian'
  runit_service "carbon-cache" do
    finish_script true
  end
else
  # redhat disables shell access for apache user by default
  user node['apache']['user'] do
    shell "/bin/bash"
  end

  template "/etc/init.d/carbon-cache" do
    source "init.el.erb"
    owner "root"
    group "root"
    mode "0774"
  end

  service "carbon-cache" do
    supports :restart => true, :reload => true, :status => true
    action [:enable, :start]
  end

end

