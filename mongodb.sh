source "common.sh"
print_head "copy configs to yum repos"
cp configs/mongodb.repo  /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head "install mongodb"
yum install mongodb-org -y &>>${log_file}

print_head "enable mongodb"
systemctl enable mongod &>>${log_file}

print_head "update listen address"
sed -i -e "s/127.0.0.1/0.0.0.0" etc/mongod.conf &>>${log_file}

print_head "restart mongodb"
systemctl restart mongod &>>${log_file}

