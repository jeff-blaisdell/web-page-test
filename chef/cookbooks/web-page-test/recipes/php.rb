## Install PHP and required PHP libs.
# PHP5.5.x conf.d directory moved.
node.default['php']['ext_conf_dir'] = '/etc/php5/apache2/conf.d'
## Install PHP and required PHP libs.
include_recipe "apt::default"
include_recipe "php::default"
include_recipe "apache2::mod_php5"

# pcre lib is dependency of some PHP modules.
package "libpcre3-dev" do
  action :install
end

php_pear "zip" do
  action :install
end

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

package "php5-sqlite" do
  action :install
end

#php_pear "zlib" do
#  action :install
#end


