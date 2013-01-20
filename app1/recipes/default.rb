#
# Cookbook Name:: app
# Recipe:: default
#
# Copyright 2013, y2cf digital media pvt ltd
#
# All rights reserved - Do Not Redistribute
#
#
include_recipe 'torquebox-server'
include_recipe 'tb-deployer-client'

begin
  t = resources(:template => "/etc/profile.d/torquebox.sh")
  t.variables.merge!({ :app_enable => node[:app][:enabled], :app_env => node[:app]})
  Chef::Log.info "modified template with new variables"
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template /etc/profile.d/torquebox.sh"
end

#using definitions from torquebox-server
app_deployer "app1" do
  project_code "prod"
  user_name "your admin user name"
  password "your admin password"
  server "your ci server"
  port "ci server port"
end

#using definitions from tb-deployer-client
knob_pull "app" do
  server "web push server name or ip address"
end

