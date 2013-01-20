require 'yaml'
deployment_settings = YAML.load_file("knob-deployer.yml")


environment = ARGV[0]
project = ARGV[1]
build_number = ARGV[2]

project_env = deployment_settings['projects'][project]

build_url =  project_env['url'] % build_number

puts build_url

f = IO.popen("wget -O /var/www/html/#{environment}/#{project}/#{project}-#{build_number}.knob #{build_url}", "r") { 
|pipe|
  pipe.each do |line|
    sleep 1
    puts line
  end
}

#`wget -o /var/www/html/#{project_env}/#{project_name}/#{project_name}-#{build_number}.knob #{build_url}`
`echo #{build_number} > /var/www/html/#{environment}/#{project}/latest.txt`
