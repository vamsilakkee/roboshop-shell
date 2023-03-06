source "common.sh"

print_head "configure nodejs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head "install nodejs"
yum install nodejs -y &>>${log_file}

print_head "add user roboshop"
useradd roboshop &>>${log_file}

print_head "create app directory"
mkdir /app &>>${log_file}

print_head "remove old content"
rm -rf /app/* &>>${log_file}

print_head "download catalogue content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
cd /app


print_head "unzip catalogue file" &>>${log_file}
unzip /tmp/catalogue.zip


print_head "install nodejs dependencies" &>>${log_file}
npm install


print_head "copy configs to catalogue service" &>>${log_file}
cp ${code_dir}/configs/catalogue.service  /etc/systemd/system/catalogue.service


print_head "reload system"
systemctl daemon-reload &>>${log_file}


print_head "start and enable catalogue service"
systemctl enable catalogue &>>${log_file}
systemctl start catalogue  &>>${log_file}

cp  ${code_dir}/configs/mongodb.repo  /etc/yum.repos.d/mongo.repo


print_head "install mongodb client"
yum install mongodb-org-shell -y &>>${log_file}

print_head "load schema"
mongo --host mongodb.devops444.online </app/schema/catalogue.js &>>${log_file}