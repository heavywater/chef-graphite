default[:graphite][:version] = "0.9.9"
default[:graphite][:python_version] = "2.6"

default[:graphite][:carbon][:uri] = "http://launchpadlibrarian.net/82112362/carbon-#{node[:graphite][:version]}.tar.gz"
default[:graphite][:carbon][:checksum] = 'b3d42e3b93c09a82646168d7439e25cfc52143d77eba8a1f8ed45e415bb3b5cb'

default[:graphite][:whisper][:uri] = "http://launchpadlibrarian.net/82112367/whisper-#{node[:graphite][:version]}.tar.gz"
default[:graphite][:whisper][:checksum] = "66c05eafe8d86167909262dddc96c0bbfde199fa75524efa50c9ffbe9472078d"

default[:graphite][:graphite_web][:uri] = "http://launchpadlibrarian.net/82112308/graphite-web-#{node[:graphite][:version]}.tar.gz"
default[:graphite][:graphite_web][:checksum] = "cc78bab7fb26b341a62bbc0360d675147d77cea3075eae16c65db3b63f502419"

default[:graphite][:carbon][:line_receiver_interface] =   "127.0.0.1"
default[:graphite][:carbon][:pickle_receiver_interface] = "127.0.0.1"
default[:graphite][:carbon][:cache_query_interface] =     "127.0.0.1"

default[:graphite][:password] = "change_me"
default[:graphite][:url] = "graphite"

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
