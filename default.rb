#
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
	content '<html>
 			<body>
    				<h1>hello world</h1>
  			</body>
		</html>'
end

#Creating a simple PHP file
execute 'creating a simple PHP file' do
	command 'echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php'
end

#Starting mysql service
execute 'starting mysql service' do
	command 'sudo service mysqld start'
end

#Mysql status
execute 'mysql-rootuser' do
	command 'sudo mysql -u root mysql'
end

