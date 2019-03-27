**Tổng quan về jenkins**

jenkins là một máy chủ tích hợp liên tục có thể mở rộng. Nó build và test phần mềm của bạn một cách liên tục và theo dõi sự thi hành và trạng thái của các jobs. Nó giúp cho DEV và SA thường xuyên có được code chạy ổn định

**Cài đặt jenkins centos7**

- Trước khi cài jenkin, cần phải cài java vì jenkins chạy trên nên java

yum install java-1.8.0-openjdk-devel

- enable jenkins repo và import GPG key sử dụng lệnh curl

curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo

- add repo vào hệ thống

rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

- install jenkins

yum install jenkins

- sau khi cài đặt xong, nếu muốn thay đổi thư mục home mặc định của jenken cần chỉnh lại file config

vi /etc/sysconfig/jenkins

https://github.com/letran3691/shell/blob/master/Selection_028.png

- start và enable jenkins

systemctl start jenkins && systemctl enbale jenkins