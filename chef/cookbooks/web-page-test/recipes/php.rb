## Install PHP and required PHP libs.
include_recipe "php::default"

package "php5-gd" do
  action :install
end

package "libpcre3" do
  action :install
end

package "libpcre3-dev" do
  action :install
end

package "php5-curl" do
  action :install
end

php_pear "sqlite" do
  action :install
end

php_pear "zip" do
  action :install
end

#php_pear "zlib" do
#  action :install
#end


