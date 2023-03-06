source common.sh
 print_head "installing nginx"
yum install nginx -y &>>${log_file}

print_head "removing old content"
rm -rf /usr/share/nginx/html/*  &>>${log_file}

 print_head "download frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>${log_file}
cd /usr/share/nginx/html

 print_head "unzip frontend content"
unzip /tmp/frontend.zip &>>${log_file}

 print_head "copy nginx config to roboshop conf"
cp ${code_dir}/configs/nginx-roboshop.conf  etc/nginx/default.d/roboshop.conf &>>${log_file}

  print_head "enable nginx"
systemctl enable nginx &>>${log_file}

 print_head "starting nginx"
systemctl start nginx &>>${log_file}'