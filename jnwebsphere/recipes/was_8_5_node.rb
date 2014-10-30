
include_recipe 'jnwebsphere::was_8_5'

bash "create_node" do
  cwd "/opt/IBM/WebSphere/AppServer/bin"
  code <<-EOL
  ./manageprofiles.sh -create -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/managed -profileName Node01 -federateLater
  EOL
  not_if do
    File.exists?('/opt/IBM/WebSphere/AppServer/profiles/Node01')
  end
end

cookbook_file "/etc/init.d/ibm_websphere_node" do
  source "init/ibm_websphere_node"
  mode "0700"
end

service "ibm_websphere_node" do
  action [:enable,:start]
end
