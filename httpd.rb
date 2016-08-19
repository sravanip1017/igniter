system "sudo which httpd"

if $?.exitstatus > 0
  system "sudo yum install httpd"
else
  puts "Already exists"
end

system "sudo which httpd"

system "sudo service httpd status"

if $?.exitstatus > 0
  system "sudo service httpd start"
else
  puts "http service started"
end
