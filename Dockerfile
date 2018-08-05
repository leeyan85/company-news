from registry.cn-hangzhou.aliyuncs.com/leey/tomcat:v1 
MAINTAINER yangaofeng leeyan85@gmail.com
COPY ./target/hello.war /usr/local/tomcat/webapps/
