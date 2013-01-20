default[:torquebox][:clustered] = false
default[:torquebox][:cluster_name] = "torquebox_staging"
default[:torquebox][:role] = "toruqebox_staging"
default[:torquebox][:configuration_file] = "standalone.xml"
default[:torquebox][:environment_file] = "/etc/profile.d/torquebox.sh"

default[:torquebox_env][:jboss_user] = "torquebox"
default[:torquebox_env][:home] = "/opt/torquebox/torquebox"
default[:torquebox_env][:user_home] = "/opt/torquebox"
default[:torquebox_env][:jboss_pidfile] = "/var/run/torquebox/torquebox.pid"
default[:torquebox_env][:jboss_console_log] = "/var/log/jboss-as/console.log"
default[:torquebox_env][:jruby_home] = "#{default[:torquebox_env][:home]}/jruby"
default[:torquebox_env][:jboss_home] = "#{default[:torquebox_env][:home]}/jboss"
default[:torquebox_env][:jruby_opts] = "--1.9"
