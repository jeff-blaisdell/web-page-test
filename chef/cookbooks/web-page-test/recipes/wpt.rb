## Install Web-Page-Test application and configure.
source_file_name = node['web-page-test']['wpt']['source_file_name']
source_file_ext  = node['web-page-test']['wpt']['source_file_ext']
source_url       = node['web-page-test']['wpt']['source_url']
source_file_path = node['web-page-test']['wpt']['source_file_path']
archive_path     = node['web-page-test']['wpt']['archive_path']
extract_path     = node['web-page-test']['wpt']['extract_path']

remote_file archive_path do
  source source_url
  action :create_if_missing
end

bash 'extract_module' do
    cwd ::File.dirname(source_file_path)
    code <<-EOH
      mkdir -p #{extract_path}
      unzip #{source_file_path}/#{source_file_name}.#{source_file_ext} -d #{source_file_path}/#{source_file_name}
      cp -rf #{source_file_path}/#{source_file_name}/www/* #{extract_path}
      EOH
    not_if { ::File.exists?(extract_path) }
end

web_app "wpt" do
   template 'wpt_apache_conf.erb'
   server_name node['web-page-test']['wpt']['server_name']
end

directory "/var/log/wpt" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

template "/var/www/webpagetest/settings/about.inc" do
  source "wpt_about_inc.erb"
  action :create
end

template "/var/www/webpagetest/settings/connectivity.ini" do
  source "wpt_connectivity_ini.erb"
  action :create
end

template "/var/www/webpagetest/settings/custom.css" do
  source "wpt_custom_css.erb"
  action :create
end

template "/var/www/webpagetest/settings/ec2.ini" do
  source "wpt_ec2_ini.erb"
  action :create
end

template "/var/www/webpagetest/settings/feeds.inc" do
  source "wpt_feeds_inc.erb"
  action :create
end

template "/var/www/webpagetest/settings/keys.ini" do
  source "wpt_keys_ini.erb"
  action :create
end

template "/var/www/webpagetest/settings/locations.ini" do
  source "wpt_locations_ini_ec2.erb"
  action :create
end

template "/var/www/webpagetest/settings/settings.ini" do
  source "wpt_settings_ini.erb"
  action :create
end

bash 'set_privs' do
    cwd ::File.dirname("/var/www")
    code <<-EOH
      chown -R #{node['apache']['user']}:#{node['apache']['group']} /var/www/webpagetest
      EOH
end

template "/etc/php5/apache2/php.ini" do
  source "php_ini.erb"
  action :create
end

service "apache2" do
  action :stop
end

service "apache2" do
  action :start
end
