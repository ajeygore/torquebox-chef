torquebox-chef
==============

managing torquebox with chef on centos 6.x
with little modifications you can install torquebox for ubuntu or debian as well

these cookbooks allow you to install torquebox from a web server - serving torquebox

* apply knob deployer cookbook to the webserver - it will sit thee by default on /var/www/html
 ** to publish a build provide environment (prod/staging) application (app1/2) and build number as command line args to publish_build.rb
 ** tb_deploy_client will schedule appropriate jobs on server matching with roles to fetch these builds

* apply torquebox server cookbook when you want stand alone torquebox, change fetch urls appropriately
* if you want to deploy clustered torquebox - then create a role siimilar to following and provide environment variables
* if you want to deploy an app, create a cookbook for that app (according to sample app) and then enter details
* you can use one cookbook to deploy multiple apps
* if you just want torquebox to setup then just use torquebox-server cookbook.
