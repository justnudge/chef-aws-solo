#
# Cookbook Name:: rhel
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
directory "/opt/install/db2" do
  action :create
end

cookbook_file "/opt/install/db2/db2.resp" do
  source "db2.resp"
  mode "0700"
end

bash "download_binary_and_expand" do
  code <<-EOL
  mkdir -p /opt/install/db2
  cd /opt/install/db2
  aws s3 cp s3://jnsoftware-software/IBM/tds63-linux-x86-64.iso .
  mnt -o loop /opt/install/db2/tds63-linux-x86-64.iso /mnt
  cd /mnt/db2/db2setup -r /opt/install/db2/db2.resp
  EOL
  not_if do
    File.exists?("/opt/IBM/db2/V9.7")
  end
end
