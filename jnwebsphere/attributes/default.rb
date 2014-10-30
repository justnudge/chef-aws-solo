
default['jnwebsphere']['nas_hostname'] = 'http://nas.justnudge.com/'
default['jnwebsphere']['repository_location'] = node['jnwebsphere']['nas_hostname'] + 'ibmrepo/'

default['jnwebsphere']['im_filename'] = 'installation_manager_lin64_latest.zip'
default['jnwebsphere']['im_url'] = node['jnwebsphere']['nas_hostname'] + 'software/IBM_FREE/' + node['jnwebsphere']['im_filename']
default['jnwebsphere']['im_install_path'] = '/opt/install/installation_manager'

default['jnwebsphere']['was_install_path'] = '/opt/IBM/WebSphere/AppServer'

default['jnwebsphere']['appclient_install_path'] = '/opt/IBM/WebSphere/AppClient'
