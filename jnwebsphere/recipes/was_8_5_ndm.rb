
include_recipe 'jnwebsphere::was_8_5'

bash "create_deployment_manager" do
  cwd "/opt/IBM/WebSphere/AppServer/bin"
  code <<-EOL
  ./manageprofiles.sh -create -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/dmgr -profileName Dmgr01 -cellName WAS_CELL -serverType DEPLOYMENT_MANAGER -enableService
  EOL
  not_if do
    File.exists?('/opt/IBM/WebSphere/AppServer/profiles/Dmgr01')
  end
end

cookbook_file "/etc/init.d/ibm_websphere_ndm" do
  source "init/ibm_websphere_ndm"
  mode "0700"
end

service "ibm_websphere_ndm" do
  action [:enable,:start]
end
