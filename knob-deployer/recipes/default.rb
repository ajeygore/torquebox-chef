#
# Cookbook Name:: knob-deployer
# Recipe:: default
#
# Copyright 2013, ajeygore@gmail.com
#

include_recipe 'httpd'

template "/var/www/html/knob-deployer.yml" do
  source "knob-deployer.yml.erb"
  mode "00644"
end

cookbook_file "/var/www/html/publish_build.rb" do 
  source "publish_build.rb"
  mode 00755
  owner 'root'
end

project_environments = node[:project_environments]

web_root = "/var/www/html"

#create directory for each enviornment
unless project_environments.nil?
  project_environments.each do |environment|
  environment_root = "#{web_root}/#{environment}"
    directory  environment_root do
      mode 00755
      action :create
      not_if do
        File.exists? environment_root
      end
    end
    #create directory for each project inside environment

    projects = node[:projects]
    unless projects.nil?
      projects.each do |key,value|
      project_root = "#{environment_root}/#{key}"
        directory project_root do
          mode 00755
          action :create
          not_if do
            File.exists? project_root
          end
        end
      end
    end
  end
end
