1 Tổng quan jenkins

2 Cài đặt jenkins

3 Cài đặt 1 vài plugin cần thiết

4 Tạo User, quản lý Role cho các User

5 Tạo và cấu hình Job

6 Kết hợp Jenkins với GIT

7 Automated Deployment

8 Alert mail

**1 Tổng quan jenkins**

    Jenkins là một phần mềm tự động hóa, mã nguồn mở và viết bằng Java. Dự án được tách ra từ dự án ban đầu là Hudson, sau khi xảy ra sự tranh chấp với Oracle.

    Jenkins giúp tự động hóa các quy trình trong phát triển phần mềm, hiện nay được gọi theo thuật ngữ Tích hợp liên tục, và còn được dùng đến trong việc Phân phối liên tục. Jenkins là một phần mềm dạng server, chạy trên nền servlet với sự hỗ trợ của Apache Tomcat. Nó hỗ trợ hầu hết các phần mềm quản lý mã nguồn phổ biến hiện nay như Git, Subversion, Mercurial, ClearCase... Jenkins cũng hỗ trợ cả các mã lệnh của Shell và Windows Batch, đồng thời còn chạy được các mã lệnh của Apache Ant, Maven, Gradle... Người sáng tạo ra Jenkins là Kohsuke Kawaguchi.[3]. Phát hành theo giấy phép MIT nên Jenkins là phần mềm miễn phí.[4]

    Việc kích hoạt build dự án phần mềm bằng Jenkins có thể được thực hiện bằng nhiều cách: dựa theo các lần commit trên mã nguồn, theo các khoảng thời gian, kích hoạt qua các URL, kích hoạt sau khi các job khác được build,...
 
**2 cài đặt jenkins centos7**

   **Prerequisites**

    Minimum hardware requirements:

    256 MB of RAM

    1 GB of drive space (although 10 GB is a recommended minimum if running Jenkins as a Docker container)

    Recommended hardware configuration for a small team:

    1 GB+ of RAM

    50 GB+ of drive space

    Software requirements:

    Java: see the Java Requirements page

    Web browser: see the Web Browser Compatibility page

- Trước khi cài jenkin, cần phải cài java vì jenkins chạy trên nên java

    yum install java-1.8.0-openjdk-devel

- Enable jenkins repo và import GPG key sử dụng lệnh curl

    curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo

- Add repo vào hệ thống

    rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

- Install jenkins

    yum install jenkins

- Sau khi cài đặt xong, nếu muốn thay đổi thư mục home mặc định của jenken cần chỉnh lại file config

    vi /etc/sysconfig/jenkins


![Selection_029](https://user-images.githubusercontent.com/19284401/55050886-90b27e00-5085-11e9-87c3-b345adddaae0.png)


Thay vào đó là thư mục mới VD: JENKINS_HOME="/data" (hãy chắc chắn trong máy của bạn đã có thư mục data)


- start và enable jenkins

    systemctl start jenkins && systemctl enable jenkins


- reboot lại hệ thống

    reboot 

- Nếu firewall của bạn đang bật thì hãy mở port bằng lệnh sau.

    firewall-cmd --permanent --zone=public --add-port=8080/tcp

    firewall-cmd --reload


- **SETUP JENKINS**

    http://your_ip_or_domain:8080
   

Bạn sẽ có 1 giao diện web như hình.

![unlock-jenkins](https://user-images.githubusercontent.com/19284401/55051106-6a411280-5086-11e9-90c2-e136df1de87d.jpg)


Lấy password jenkins random để đăng nhập

    cat /var/lib/jenkins/secrets/initialAdminPassword


![Selection_031](https://user-images.githubusercontent.com/19284401/55052575-0cafc480-508c-11e9-9f24-ca4b3518d6eb.png)

Nếu biết mình cần cài nhưng plugin nào thì bạn chọn SELECT PLUGIN, còn nếu ko biết thì chọn INSTALL SUGGESTED

Quá trình cài đặt plugin bắt đầu.

![Selection_032](https://user-images.githubusercontent.com/19284401/55052729-8a73d000-508c-11e9-916f-240edb6b17d4.png)


_**_chú ý nếu bạn đã thay đổi thư mục home của jenkins trong /etc/sysconfig/jenkins_ thì đường đã sẽ khác hãy đọc ở màn hình đăng nhập của jenkins**_

![unlock-jenkins](https://user-images.githubusercontent.com/19284401/55051237-d4f24e00-5086-11e9-9414-01d9c7acb8c8.jpg)

Sau khi login bằng password có được từ file initialAdminPassword, nó sẽ biến mất và bạn sẽ được chuyển đến trang tạo user.

Nhập đầy đủ các thông tin tài khoản

![Selection_033](https://user-images.githubusercontent.com/19284401/55052815-c6a73080-508c-11e9-80ea-bcc3d9ff70ba.png)

Quá trình cài đặt jenkins đã hoàn tất.

** cài đặt 1 vài plugin cần thiết**
	
    Role-based Authorization Strategy (dùng để phần quyền cho từng jobs)

    Email Extension Template Plugin (dùng để gửi mail sau khi buil vào deploy)

    Promoted Builds (dùng để đánh dấu các phiên bản buil khá có ích khi muốn revert lại các bạn build)


   http://jenkins.local:8080/pluginManager/
   
![Selection_036](https://user-images.githubusercontent.com/19284401/55053480-e17aa480-508e-11e9-9256-0a0a842988ac.png)

- Nhập plugin cần cài vào ổ tìm kiếm.

- Tích vào plugin cẩn cài 

- Click vào install without restart để cài đặt


Cài đặt xong plugin muốn restart lại jenkins 

    http://jenkins.local:8080/restart
    
Chọn yes


**4 Tạo User, quản lý Role cho các User**

    http://jenkins.local:8080/securityRealm/addUser

![Selection_030](https://user-images.githubusercontent.com/19284401/55052980-5220c180-508d-11e9-9aa4-d4f53df08b15.png)

**phân quyền**

- Từ memu chính chọn  Manage Jenkins >> Configure Global Security >> Project-based Matrix Authorization Strategy

    http://jenkins.local:8080/configureSecurity/

![Selection_008](https://user-images.githubusercontent.com/19284401/55063911-97ec8280-50ab-11e9-98f4-634ae70fa790.png)

**5 Tạo và cấu hình Job**

- Từ menu chính chọn **New Item**

![Selection_039](https://user-images.githubusercontent.com/19284401/55057833-eb0b0900-509c-11e9-8619-4323c67b319a.png)

Một trang mới sẽ hiện ra

Nhập tên cho jobs và chọn type rồi click ok

![Selection_041](https://user-images.githubusercontent.com/19284401/55057885-0f66e580-509d-11e9-8c26-a01e146181e7.png)

Tab general

Như đã nói ở trên phần này mình sẽ nhắc đền **Project role**

![Selection_043](https://user-images.githubusercontent.com/19284401/55058475-a1bbb900-509e-11e9-9b1e-019e3bc982c1.png)

![Selection_044](https://user-images.githubusercontent.com/19284401/55058613-070faa00-509f-11e9-9d85-c8f85f759113.png)

Như trong hình mình đã add user 1 và cho user này có quyền buil cancel và workspace (tạo tác với thư mục workspacs)

Click vào Add buil step chọn Execute Shell

![Selection_045](https://user-images.githubusercontent.com/19284401/55058853-d7ad6d00-509f-11e9-82f0-8309ce044333.png)

![Selection_046](https://user-images.githubusercontent.com/19284401/55058855-d7ad6d00-509f-11e9-9de2-519f5ee1241b.png)

Trong phần Shell mình thực hiện 2 lệnh đơn giản.

    touch jenkins.txt (tạo ra file jenkins.txt)

    ls $WORKSPACE       (hiển thị nội trong trong thư mục $WORKSPACE  )

vì sao lại có  $WORKSPACE, bạn có thể xem trong **See the list of available environment variables** ngay phía dưới phần command
![Selection_047](https://user-images.githubusercontent.com/19284401/55059196-f3fdd980-50a0-11e9-8ac8-714044e18ea3.png)

Click save 

Công việc tạo jobs đã xong

Giờ sẽ chạy thử bằng user1 đã phần quyền ở phía trên

Kết quả
![Selection_009](https://user-images.githubusercontent.com/19284401/55064228-311b9900-50ac-11e9-9da8-91d5b0df1e08.png)
![Selection_010](https://user-images.githubusercontent.com/19284401/55064298-50b2c180-50ac-11e9-8437-d171dcf5b6cf.png)

Như vậy là build thành công.

Giờ chúng ta nâng cao lên 1 chút đó là cấu hình buil và deploy từ github

**6 + 7 + 8 Kết hợp Jenkins với GIT && Automated Deployment && alert mail**

- Trước khi bắt đầu bạn cần cài đặt

- Git plugin (nếu chưa có) 

- Cài đặt plugin Publish over SSH 

- Cấu hình phần alert mail

    Cách cài đặt mình đã hướng dẫn ở trên.

Tại menu chính Manage Jenkins >> Configure System >> Extended E-mail Notification

![Selection_011](https://user-images.githubusercontent.com/19284401/55066238-f287dd80-50af-11e9-9dcb-f27671791021.png)


    SMTP server : server mail

    Default user E-mail suffix : dạng tên miền của mail

    Tích vào use SMTP Auth 

    User Name: địa chị mail

    Password: mật khẩu mail

    reply to list: nhập lại địa chị mail ở trên.


**Chú ý:** nếu ban dùng gmail hoặc gsuite thì hãy cho phép tài khoản đăng nhập vào ứng dụng kém an toàn

    Cuộn chuột xuống cuối tìm đến phần  **Publish over SSH**

- Cấu hình Publish over SSH  để deploy lên server.

        Tại phần SSH Servers

        Nhập các thông tin của server cần deploy

![Selection_012](https://user-images.githubusercontent.com/19284401/55067039-90c87300-50b1-11e9-87b7-ada52e78d7a0.png)


    Name: bạn nhập gì cũng được (để gợi nhớ đến server)

    Hostname: nhập ip hoặc hostname

    Username: mặc định là jenkins (hãy chắc chắn rằng user jenkins đã được tạo ở server ssh)

    Remote Diretory: đây là nơi jenkins sẽ deply code (hãy chắc chắn server ssh có thư mục này)

    Tích Use password authentication, or use a different key

    Patch to key là đường dẫn đề file key ssh private

    /var/lib/jenkins đây là thư mục home mặc địch của jenkins

    /.ssh/id_rsa.ppk thư mục .ssh là mình tạo ra để cấu hình cho dễ quản lý

Nếu bạn ko muốn phúc phạp vấn đề bạn có thể paste trực tiếp key private và mục **Key** ngay bên dưới patch to key

Sau khi cấu hình xong hãy click vào **test config**  ở góc bên phải. nếu có thông báo **success** thì cấu hình xong. nếu ngược lại thì các bạn biết phải làm gì rồi đó :D


![Selection_013](https://user-images.githubusercontent.com/19284401/55067836-07b23b80-50b3-11e9-93cf-0e35a7e697ed.png)

Cuối cùng là **SAVE** 

Vậy là cấu hình xong alertmail và SSH

- Giờ đến cấu hình jobs

![Selection_014](https://user-images.githubusercontent.com/19284401/55068094-96bf5380-50b3-11e9-9841-85546f76b6ca.png)

- Add Parameter >> git Parameter 

![Selection_015](https://user-images.githubusercontent.com/19284401/55068241-f3227300-50b3-11e9-8dc1-5449a3323e08.png)


    Name: nhập bất cứ cái gì bạn muốn
 
    Parameter Type: sẽ buil từ branch (mặc định là master nếu git của bạn cảu nhiều brach)
 
**Source Code Management**
    ![Selection_017](https://user-images.githubusercontent.com/19284401/55068429-662be980-50b4-11e9-8c5f-27b88ae6de10.png)

    Repository URL: là địa cảu git server bạn muốn pull (để đây mình dùng clone qua ssh nên sẽ cấu hình Credentials, nếu bạn clone từ http thì ko cần)

    Branch Specifier (blank for 'any') : $BUILD gọi đển biến **Name** bạn vừa đặt ở phần **git Parameter**

**Build Triggers**

![Selection_018](https://user-images.githubusercontent.com/19284401/55068677-f66a2e80-50b4-11e9-8376-9c4e27908dca.png)

    Build when a change is pushed to BitBucket. ý nghĩ của nó là mỗi khi có commit thì jenkins sẽ từ động buil và deploy

**_chú ý: muốn sử dụng tính này năng thì bạn cần cấu hình webhook trên github và server jenkins của bạn phải được public ra ngoài.**_

- Tham khảo cấu hình webhook:

       https://dzone.com/articles/adding-a-github-webhook-in-your-jenkins-pipeline



**Build Environment**

- Send files or execute commands over SSH before the build starts 

- Send files or execute commands over SSH after the build runs

    Tên của 2 tùy chọn này cũng đã nói lên cách nó làm việc rồi

    Gửi file hoặc thực hiện lên shell trước khi build. tức là lệnh shell sẽ được thực thi trước khi clone code từ gitserver về và ngược lại


![Selection_019](https://user-images.githubusercontent.com/19284401/55068912-72647680-50b5-11e9-9b2f-59e5e86219c5.png)

**SSH Publishers**

- SSH server sẽ list và các server ssh mà bạn đã cấu hình trong phần **Publish over SSH** ở trên. nếu bạn cấu hình nhiều server ssh thì hãy chọn chính xác.

- Transfers Source files: là thư mục chứa code clone từ git về mặc địn là **workspace** (các bạn có thể tìm hiểu thêm về workspaces tại http://jenkins.local:8080/env-vars.html/ )

- Remote directory: là thư mục bạn đã cấu hình ở phần **Publish over SSH**

- Exec command : thực hiện lệnh shell gì đó. VD ở đây show ra nội dung của thư mục Remote directory chính /producs/hanv

**Post-build Actions**

    Chọn Editable Email notification

![Selection_022](https://user-images.githubusercontent.com/19284401/55070592-316e6100-50b9-11e9-8d61-5bd50502f31e.png)


    Project Recipient List : nhập vào địa chỉ email nhập thông báo sau khi build

    Attach Build Log : chọn Attach Build Log để đính kèm chi tiết log quá trình build và deploy.

- Click vào **Advance Setting** bên góc phải 

Tìm đến **Triggers** bên góc trái chọn **Add Trigger** chọn tiếp **Always** xóa **Developer** đi chỉ để **Recipient list**

![Selection_021](https://user-images.githubusercontent.com/19284401/55070352-a42b0c80-50b8-11e9-80e1-59e579cc157a.png)

Cuối cùng là **SAVE**

Vậy là đã cấu hình hoàn tất giờ chạy buil để test thành quả thôi. :D


Tài liệu tham khảo: https://vi.wikipedia.org/wiki/Jenkins_(ph%E1%BA%A7n_m%E1%BB%81m)




 











