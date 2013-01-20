#
# Cookbook Name:: mod_cluster
# Recipe:: default
#
# Copyright 2012, y2cf digital media pvt ltd
#
# All rights reserved - Do Not Redistribute
#
#
include_recipe 'httpd'
remote_file "/tmp/mod_cluster-1.2.0.Final-linux2-x64-ssl.tar.gz" do
  source "http://your software server /software/mod_cluster/mod_cluster-1.2.0.Final-linux2-x64-ssl.tar.gz"
  mode 00644
  action :create_if_missing
  notifies :run, "script[install-mod_cluster]"
end

script "install-mod_cluster" do
  Chef::Log.info("Installing jboss-mod_cluster 1.7 tarball...")
  user 'root'
  interpreter "bash"
  cwd "/tmp"
  code <<-EOH 
  echo "Untar mod_cluster..."
  tar zxvf /tmp/mod_cluster-1.2.0.Final-linux2-x64-ssl.tar.gz
  cp /tmp/opt/jboss/httpd/lib/httpd/modules/mod_slotmem.so /etc/httpd/modules/
  cp /tmp/opt/jboss/httpd/lib/httpd/modules/mod_manager.so /etc/httpd/modules/
  cp /tmp/opt/jboss/httpd/lib/httpd/modules/mod_proxy_cluster.so /etc/httpd/modules/
  cp /tmp/opt/jboss/httpd/lib/httpd/modules/mod_advertise.so /etc/httpd/modules/
  EOH
  creates "/tmp/opt/jboss/httpd/lib/httpd/modules"
  not_if do
    File.exists?("/etc/httpd/modules/mod_manager.so")
  end
end

template "/etc/httpd/conf.d/mod_cluster.conf" do
  source "mod_cluster.conf.erb"
  variables(:cluster_name => node[:mod_cluster][:cluster_name], :node_ipaddress => node.ipaddress)
  mode "0644"
  notifies :restart, "service[httpd]"
end
