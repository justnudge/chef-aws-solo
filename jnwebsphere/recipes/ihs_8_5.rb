
directory "/opt/install" do
  action :create
end

directory "/opt/install/silent" do
  action :create
end

cookbook_file "/opt/install/silent/ihs_85.xml.xml" do
  source "ihs_85.xml"
  mode "0600"
end

bash "install_websphere_application_server" do
  cwd "/opt/IBM/InstallationManager/eclipse"
  code <<-EOL
  ./IBMIM --launcher.ini silent-install.ini -input /opt/install/silent/ihs_85.xml.xml
  EOL
  not_if do
    File.exists?('/opt/IBM/HTTPServer')
  end
end

cookbook_file "/opt/IBM/HTTPServer/conf/httpd.conf" do
  source "ihs.conf"
  mode "0600"
end

cookbook_file "/etc/init.d/ibm_http_server" do
  source "init/ibm_http_server"
  mode "0700"
end

service "ibm_http_server" do
  action [:enable,:start]
end

include_recipe 'jnwebsphere::was_8_5_customization'
