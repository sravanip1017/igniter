#!/bin/bash

#updating the system
sudo yum update

#Installing Chef
sudo curl -L https://www.opscode.com/chef/install.sh | sudo bash 

#creating the directory for recipes and the default.rb file
sudo mkdir -p /home/ec2-user/chef/cookbooks/lamp/recipes
sudo touch /home/ec2-user/chef/cookbooks/lamp/recipes/default.rb

#Giving permissions to the file
sudo chmod -R ugo+rw /home/ec2-user/chef/cookbooks/lamp/recipes/default.rb


#adding content to the default.rb file
sudo echo '#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#Update
execute 'update' do
        command 'sudo yum update -y'
end

#Installing LAMP
execute 'installing-lamp' do
        command 'sudo yum install -y httpd24 php56 mysql55-server php56-mysqlnd'
end

#Start apache web-server
execute 'start apache web-server' do
        command 'sudo service httpd start'
end

#Checking http config
execute 'checking http config' do
        command 'sudo chkconfig httpd on'
end

#Creating index.html
file '/var/www/html/index.html' do
        content 'Hello World'
end

#Creating a simple PHP file
file '/var/www/html/phpinfo.php' do
        content ''<?php echo ''<p>Hello World</p>''; ?>''
end

#Starting mysql service
execute 'starting mysql service' do
        command 'sudo service mysqld start'
end

#Mysql status
execute 'mysql-rootuser' do
        command 'sudo mysql -u root mysql'
end

#Mysql status
execute 'mysql-rootuser' do
	command 'sudo mysql -u root mysql'
end' > /home/ec2-user/chef/cookbooks/lamp/recipes/default.rb

#Creating node.json and giving permissions to it
sudo touch /home/ec2-user/chef/node.json
sudo chmod -R ugo+rw /home/ec2-user/chef/node.json

#adding conntent to node.json
sudo echo '#
{ 
"run_list": [ "recipe[lamp]" ] 
}' > /home/ec2-user/chef/node.json

#creating the solo.rb file and giving permissions
sudo touch /home/ec2-user/chef/solo.rb
sudo chmod -R ugo+rw /home/ec2-user/chef/solo.rb

#adding content to the solo.rb file 
sudo echo '#
file_cache_path "/home/ec2-user/chef" 
cookbook_path "/home/ec2-user/chef/cookbooks" 
json_attribs "/home/ec2-user/chef/node.json"' > /home/ec2-user/chef/solo.rb

# running chef-solo
sudo chef-solo -c /home/ec2-user/chef/solo.rb 