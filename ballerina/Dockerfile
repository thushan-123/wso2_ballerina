FROM ballerina/snowpeak_passthrough:latest

WORKDIR /home/ballerina


COPY target/bin/ballerina.jar /home/ballerina/ballerina.jar

EXPOSE 9090

CMD ["java", "-jar", "/home/ballerina/ballerina.jar"]


