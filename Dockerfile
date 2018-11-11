FROM openjdk:latest
EXPOSE 8000
RUN mkdir /opt/application
COPY ./build/libs/itau-hello*.jar /opt/application/itau-hello.jar
CMD ["java","-jar","/opt/application/itau-hello.jar"]