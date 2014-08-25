## Install required libraries
package "ffmpeg" do
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
