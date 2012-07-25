default[:graphite][:version] = "0.9.10"
default[:graphite][:python_version] = "2.6"

default[:graphite][:carbon][:uri] = 'https://github.com/downloads/graphite-project/carbon/carbon-0.9.10.tar.gz'
default[:graphite][:carbon][:checksum] = '4f37e00595b5b078edb9b3f5cae318f752f4446a82623ea4da97dd7d0f6a5072'

default[:graphite][:whisper][:uri] = 'https://github.com/downloads/graphite-project/whisper/whisper-0.9.10.tar.gz'
default[:graphite][:whisper][:checksum] = '36b5fa917526224678da0a530a6f276d00074f0aa98acd6e2412c79521f9c4ff'

default[:graphite][:graphite_web][:uri] = "https://github.com/downloads/graphite-project/graphite-web/graphite-web-0.9.10.tar.gz"
default[:graphite][:graphite_web][:checksum] = "4fd1d16cac3980fddc09dbf0a72243c7ae32444903258e1b65e28428a48948be"

default[:graphite][:carbon][:line_receiver_interface] =   "127.0.0.1"
default[:graphite][:carbon][:pickle_receiver_interface] = "127.0.0.1"
default[:graphite][:carbon][:cache_query_interface] =     "127.0.0.1"

default[:graphite][:password] = "change_me"
default[:graphite][:url] = "graphite"
default[:graphite][:web][:time_zone] = "UTC"
default[:graphite][:carbon][:max_updates_per_second] = 1000


case platform
when 'ubuntu','debian'
  default[:graphite][:apache_vhost_path] = '/etc/apache2/sites-available/graphite'
  default[:graphite][:package][:python_cairo_dev] = 'python-cairo-dev'
  default[:graphite][:package][:python_django] = 'python-django'
  default[:graphite][:package][:python_django_tagging] = 'python-django-tagging'
  default[:graphite][:package][:python_memcache] = 'python-memcache'
  default[:graphite][:package][:python_rrdtool] = 'python-rrdtool'
when 'redhat','scientific','amazon','fedora','centos'
  default[:graphite][:apache_vhost_path] = '/etc/httpd/sites-available/graphite'
  default[:graphite][:package][:python_cairo_dev] = 'pycairo-devel'
  default[:graphite][:package][:python_django] = 'Django'
  default[:graphite][:package][:python_django_tagging] = 'django-tagging'
  default[:graphite][:package][:python_memcache] = 'python-memcached'
  default[:graphite][:package][:python_rrdtool] = 'python-rrdtool'
end
