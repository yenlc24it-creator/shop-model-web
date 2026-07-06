FROM tomcat:9.0-jdk8

COPY target/ROOT.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]