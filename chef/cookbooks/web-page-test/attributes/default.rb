# Web Page Test archive metadata.
default['web-page-test']['wpt']['version'] = "2.15"
default['web-page-test']['wpt']['source_file_name'] = "webpagetest_#{node['web-page-test']['wpt']['version']}"
default['web-page-test']['wpt']['source_file_ext'] = "zip"
default['web-page-test']['wpt']['source_url'] = "https://github.com/WPO-Foundation/webpagetest/releases/download/WebPagetest-#{node['web-page-test']['wpt']['version']}/#{node['web-page-test']['wpt']['source_file_name']}.#{node['web-page-test']['wpt']['source_file_ext']}"
default['web-page-test']['wpt']['source_file_path'] = "#{Chef::Config[:file_cache_path]}"
default['web-page-test']['wpt']['archive_path'] = "#{node['web-page-test']['wpt']['source_file_path']}/#{node['web-page-test']['wpt']['source_file_name']}.#{node['web-page-test']['wpt']['source_file_ext']}"
default['web-page-test']['wpt']['extract_path'] = "/var/www/webpagetest"

# server name to be used for Apache 2 WPT context.
# see http://httpd.apache.org/docs/2.2/mod/core.html#servername
default['web-page-test']['wpt']['server_name'] = "www.example.com"

# FFMPEG archive metadata.
default['web-page-test']['ffmpeg']['version'] = '2.3.3-64bit'
default['web-page-test']['ffmpeg']['source_file_name'] = "ffmpeg-#{node['web-page-test']['ffmpeg']['version']}-static"
default['web-page-test']['ffmpeg']['source_file_ext'] = "tar.bz2"
default['web-page-test']['ffmpeg']['source_url'] = "http://johnvansickle.com/ffmpeg/releases/#{node['web-page-test']['ffmpeg']['source_file_name']}.#{node['web-page-test']['ffmpeg']['source_file_ext']}"
default['web-page-test']['ffmpeg']['source_file_path'] = "#{Chef::Config[:file_cache_path]}"
default['web-page-test']['ffmpeg']['archive_path'] = "#{node['web-page-test']['ffmpeg']['source_file_path']}/#{node['web-page-test']['ffmpeg']['source_file_name']}.#{node['web-page-test']['ffmpeg']['source_file_ext']}"
default['web-page-test']['ffmpeg']['extract_path'] = "/usr/local/ffmpeg"
default['web-page-test']['ffmpeg']['bin_path'] = "/usr/local/bin/ffmpeg"

# PHP Cookbook has outdated conf location for PHP5 on Ubuntu Trusty.
default['php']['ext_conf_dir'] = '/etc/php5/apache2/conf.d'




