
include_recipe 'jnwebsphere'

installation_path = node['jnwebsphere']['im_install_path']
installation_file = node['jnwebsphere']['im_filename']
download_url = node['jnwebsphere']['im_url']

Chef::Log.info("Installation Path=#{installation_path}")

bash "download_binary_and_expand" do
  code <<-EOL
  mkdir -p #{installation_path}
  cd #{installation_path}
  aws s3 cp s3://jnsoftware-software/IBM/installation_manager_lin64_latest.zip
  wget #{download_url}
  unzip #{installation_file}
  rm -f #{installation_file}
  ./installc -log /var/log/IBM_InstallationManager_Install.log -acceptLicense
  EOL
  not_if do
    File.exists?(installation_path)
  end
end

bash "download_repo" do
  code <<-EOL
  mkdir -p /opt/install/repo
  cd /opt/install/repo
  aws s3 cp s3://jnsoftware-ibmrepo/* . --recursive
  EOL
  not_if do
    File.exists?("/opt/install/repo")
  end
end
