## Install required libraries

include_recipe "apt::default"
include_recipe "apache2::default"

include_recipe "apache2::mod_expires"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_rewrite"

package "unzip" do
  action :install
end

package "imagemagick" do
  action :install
end

package "libjpeg-progs" do
  action :install
end

package "libimage-exiftool-perl" do
  action :install
end

package "supervisor" do 
  action :install
end

template "/etc/supervisor/conf.d/apache2d.conf" do
  source "apache2d_conf.erb"
  action :create
end

# Install FFMPEG
source_file_name = "ffmpeg-2.3.2-64bit-static"
source_file_ext = "tar.bz2"
source_url = "http://johnvansickle.com/ffmpeg/releases/#{source_file_name}.#{source_file_ext}"
source_file_path = "#{Chef::Config[:file_cache_path]}"
archive_path = "#{source_file_path}/#{source_file_name}.#{source_file_ext}"
extract_path = "/usr/local/ffmpeg"
bin_path = "/usr/local/bin/ffmpeg"

remote_file archive_path do
  source source_url
  action :create_if_missing
end

bash 'extract_module' do
  cwd ::File.dirname(source_file_path)
  code <<-EOH
    mkdir -p #{extract_path}
    tar xjvf #{archive_path} -C #{extract_path}
    mv #{extract_path}/*/* #{extract_path}/
    EOH
  not_if { ::File.exists?(extract_path) }
end

bash 'install_module' do
  cwd ::File.dirname(extract_path)
  code <<-EOH
    ln -sf #{extract_path} #{bin_path}
    EOH
  not_if { ::File.exists?(bin_path) }
end
