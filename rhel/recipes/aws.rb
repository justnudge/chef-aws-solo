

yum_package "python-pip" do
  action :install
end

python_pip "awscli" do
  action :install
end
