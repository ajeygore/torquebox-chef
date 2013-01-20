#
# Cookbook Name:: torquebox-server
# Definition:: app_deployer
#
# Copyright 2013 Ajey Gore

define :app_deployer do

  application_name = params[:name]

  
  include_recipe 'torquebox-server'

  directory "/opt/torquebox/apps" do
    owner "torquebox"
    group "torquebox"
    mode 00755
    action :create
    not_if do
      File.exists? "/opt/torquebox/apps"
    end
  end


  template "#{node[:torquebox_env][:user_home]}/apps/#{application_name}_deployer.sh" do
    cookbook "torquebox-server"
    source "application_deployer.sh.erb"
    owner "torquebox"
    group "torquebox"
    mode 0755
    variables(
      :application_name => application_name,
      :user_name => params[:user_name],
      :password => params[:password],
      :server => params[:server],
      :port => params[:port],
      :project_code => params[:project_code]
    )
  end
end
