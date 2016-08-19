#update
execute ‘update’ do
	command ‘sudo apt-get update -y’
end 

#installing LAMP
execute ‘installing LAMP’ do
	command ‘sudo apt-get install -y httpd24 php56 mysql55-server php56-mysqlnd’
end 
#start apache web-server
execute ‘start apache web-server’ do
	command ‘sudo service httpd start’
end 
# checking http config
execute ‘checking http config’ do
	command ‘sudo chkconfig httpd on’
end 
#creating index.html
file '/var/www/html/index.html' do
content '<html>
 <body>
    <h1>hello world</h1>
  </body>
</html>'
end
#creating a simple php file
execute ‘creating a simple php file’ do
command ‘echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php’
end
#starting mysql service
execute ‘starting mysql service’ do
command ‘sudo service mysqld start’
end
#Mysql status
execute ‘Mysql status’ do
command ‘service mysqld status’
end

