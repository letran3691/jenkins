1 Tổng quan jenkins
2 cài đặt jenkins
3 cài đặt 1 vài plugin cần thiết
4 Tạo User, quản lý Role cho các User
5 Tạo và cấu hình Job
6 Kết hợp Jenkins với GIT
7 Automated Deployment

**1 Tổng quan jenkins**

jenkins là một máy chủ tích hợp liên tục có thể mở rộng. Nó build và test phần mềm của bạn một cách liên tục và theo dõi sự thi hành và trạng thái của các jobs. Nó giúp cho DEV và SA thường xuyên có được code chạy ổn định


**2 cài đặt jenkins centos7**

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


![Selection_029](https://user-images.githubusercontent.com/19284401/55050886-90b27e00-5085-11e9-87c3-b345adddaae0.png)


thay vào đó là thư mục mới VD: JENKINS_HOME="/data" (hãy chắc chắn trong máy của bạn đã có thư mục data)


- start và enable jenkins

systemctl start jenkins && systemctl enbale jenkins


- reboot lại hệ thống

reboot 

- Nếu firewall của bạn đang bật thì hãy mở port bằng lệnh sau.

firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload

- **SETUP JENKINS**

    http://your_ip_or_domain:8080

bạn sẽ có 1 giao diện web như hình.
![unlock-jenkins](https://user-images.githubusercontent.com/19284401/55051106-6a411280-5086-11e9-90c2-e136df1de87d.jpg)


lấy password jenkins random để đăng nhập

cat /var/lib/jenkins/secrets/initialAdminPassword


![Selection_031](https://user-images.githubusercontent.com/19284401/55052575-0cafc480-508c-11e9-9f24-ca4b3518d6eb.png)

nếu biết mình cần cài nhưng plugin nào thì bạn chọn SELECT PLUGIN, còn nếu ko biết thì chọn INSTALL SUGGESTED

quá trình cài đặt plugin bắt đầu.
![Selection_032](https://user-images.githubusercontent.com/19284401/55052729-8a73d000-508c-11e9-916f-240edb6b17d4.png)


_**_chú ý nếu bạn đã thay đổi thư mục home của jenkins trong /etc/sysconfig/jenkins_ thì đường đã sẽ khác hãy đọc ở màn hình đăng nhập của jenkins**_
![unlock-jenkins](https://user-images.githubusercontent.com/19284401/55051237-d4f24e00-5086-11e9-9414-01d9c7acb8c8.jpg)

sau khi login bằng password của có được thì file initialAdminPassword sẽ biến mất và bạn sẽ được chuyển đến trang tạo user.

nhập đầy đủ các thông tin tài khoản
![Selection_033](https://user-images.githubusercontent.com/19284401/55052815-c6a73080-508c-11e9-80ea-bcc3d9ff70ba.png)

quá trình cài đặt jenkins đã hoàn tất.

** cài đặt 1 vài plugin cần thiết**
	
Role-based Authorization Strategy (dùng để phần quyền cho từng jobs)
Email Extension Template Plugin (dùng để gửi mail sau khi buil vào deploy)
Promoted Builds (dùng để đánh dấu các phiên bản buil khá có ích khi muốn revert lại các bạn build)

   http://jenkins.local:8080/pluginManager/
![Selection_036](https://user-images.githubusercontent.com/19284401/55053480-e17aa480-508e-11e9-9256-0a0a842988ac.png)
- nhập plugin cần cài vào ổ tìm kiếm.
- tích vào plugin cẩn cài 
- click vào install without restart để cài đặt

cài đặt xong plugin muốn restart lại jenkins 
    http://jenkins.local:8080/restart
chọn yes


**4 Tạo User, quản lý Role cho các User**

http://jenkins.local:8080/securityRealm/addUser
![Selection_030](https://user-images.githubusercontent.com/19284401/55052980-5220c180-508d-11e9-9aa4-d4f53df08b15.png)

**phân quyền**
từ memu chính chọn  Manage Jenkins >> Configure Global Security >> Project-based Matrix Authorization Strategy

http://jenkins.local:8080/configureSecurity/
![Selection_008](https://user-images.githubusercontent.com/19284401/55063911-97ec8280-50ab-11e9-98f4-634ae70fa790.png)

**5 Tạo và cấu hình Job**

Từ menu chính chọn **New Item**

![Selection_039](https://user-images.githubusercontent.com/19284401/55057833-eb0b0900-509c-11e9-8619-4323c67b319a.png)

1 trang mới sẽ hiện ra
nhập tên cho jobs và chọn type rồi click ok
![Selection_041](https://user-images.githubusercontent.com/19284401/55057885-0f66e580-509d-11e9-8c26-a01e146181e7.png)

tab general
Như đã nói ở trên phần này mình sẽ nhắc đền **Project role**
![Selection_043](https://user-images.githubusercontent.com/19284401/55058475-a1bbb900-509e-11e9-9b1e-019e3bc982c1.png)

![Selection_044](https://user-images.githubusercontent.com/19284401/55058613-070faa00-509f-11e9-9d85-c8f85f759113.png)
như trong hình mình đã add user 1 và cho user này có quyền buil cancel và workspace (tạo tác với thư mục workspacs)
click vào Add buil step chọn Execute Shell
![Selection_045](https://user-images.githubusercontent.com/19284401/55058853-d7ad6d00-509f-11e9-82f0-8309ce044333.png)

![Selection_046](https://user-images.githubusercontent.com/19284401/55058855-d7ad6d00-509f-11e9-9de2-519f5ee1241b.png)
trong phần Shell mình thực hiện 2 lệnh đơn giản.
touch jenkins.txt (tạo ra file jenkins.txt)
ls $WORKSPACE       (hiển thị nội trong trong thư mục $WORKSPACE  )

vì sao lại có  $WORKSPACE, bạn có thể xem trong **See the list of available environment variables** ngay phía dưới phần command
![Selection_047](https://user-images.githubusercontent.com/19284401/55059196-f3fdd980-50a0-11e9-8ac8-714044e18ea3.png)

click save 
công việc tạo jobs đã xong

giờ sẽ chạy thử bằng user1 đã phần quyền ở phía trên
Kết quả
![Selection_009](https://user-images.githubusercontent.com/19284401/55064228-311b9900-50ac-11e9-9da8-91d5b0df1e08.png)
![Selection_010](https://user-images.githubusercontent.com/19284401/55064298-50b2c180-50ac-11e9-8437-d171dcf5b6cf.png)
như vậy là build thành công.
giờ chúng ta nâng cao lên 1 chút đó là cấu hình buil và deploy từ github

**6 +7 Kết hợp Jenkins với GIT && Automated Deployment**
Tạo jobs tượng như như hướng dẫn ở trên.












