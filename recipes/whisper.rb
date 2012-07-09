include_recipe 'ark'

version = node[:graphite][:version]
pyver = node[:graphite][:python_version]

ark "whisper" do
  version version
  path "/usr/src"
  url node[:graphite][:whisper][:uri]
  checksum node[:graphite][:whisper][:checksum]
  creates "/usr/local/lib/python#{pyver}/dist-packages/whisper-#{version}-py#{pyver}.egg-info"
  action [:install, :setup_py]
end
