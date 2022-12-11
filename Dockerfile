FROM tomcat:latest

LABEL maintainer="dockersandheep"

ADD ./target/democounterapp-0.1.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"] 
