define :knob_pull do

  application_name = params[:name]

  include_recipe 'tb-deployer-client'

  directory "/opt/torquebox/apps" do
    owner "torquebox"
    group "torquebox"
    mode 00755
    action :create
    not_if do
      File.exists? "/opt/torquebox/apps"
    end
  end

  template "#{node[:torquebox_env][:user_home]}/apps/#{application_name}_knob_deploy.sh" do
    cookbook "tb-deployer-client"
    source "knob_deploy.sh.erb"
    owner "torquebox"
    group "torquebox"
    mode 0755
    variables(
      :knob_server => params[:server],
      :application_name => application_name,
      :project_environment => node[:torquebox][:role],
      :app_root => "#{node[:torquebox_env][:user_home]}/apps"
    )
  end

  template "#{node[:torquebox_env][:user_home]}/apps/#{application_name}_knob_poll.sh" do
    cookbook "tb-deployer-client"
    source "knob_poll.sh.erb"
    owner "torquebox"
    group "torquebox"
    mode 0755
    variables(
      :knob_server => params[:server],
      :application_name => application_name,
      :project_environment => node[:torquebox][:role],
      :app_root => "#{node[:torquebox_env][:user_home]}/apps"
    )
  end

  #calculate minutes for this entry
  nth_minute = node.ipaddress.split(".").last.to_i % 5
  minute_string = []
  12.times do |n|
    nth_minute_period =  (nth_minute+5)*(n) 
    nth_minute_period = nth_minute if nth_minute_period == 0
    nth_minute_period = nth_minute_period % 60  if nth_minute_period > 59
    minute_string << nth_minute_period
  end

  minute_string = minute_string.join(',')

  cron "run_#{application_name}_poll_service" do
    command "#{node[:torquebox_env][:user_home]}/apps/#{application_name}_knob_poll.sh >> /var/log/#{application_name}-poll.log 2>&1"
    hour "*"
    minute minute_string
  end
end
