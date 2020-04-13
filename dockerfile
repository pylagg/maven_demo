FROM tomcat:8.5-alpine
ADD target/HelloWorld.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]