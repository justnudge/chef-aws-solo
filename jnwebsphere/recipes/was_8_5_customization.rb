
include_recipe 'jnwebsphere::installation-manager'

directory "/opt/install" do
  action :create
end

directory "/opt/install/silent" do
  action :create
end

cookbook_file "/opt/install/silent/was_85_customization.xml" do
  source "was_85_customization.xml"
  mode "0700"
end

bash "install_websphere_customization_toolbox" do
  cwd "/opt/IBM/InstallationManager/eclipse"
  code <<-EOL
  ./IBMIM --launcher.ini silent-install.ini -input /opt/install/silent/was_85_customization.xml
  EOL
  not_if do
    File.exists?('/opt/IBM/WebSphere/Toolbox')
  end
end
