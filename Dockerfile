FROM maven:3.6.0-jdk-8 as maven

WORKDIR /my-project

COPY . .

# build for release
RUN mvn package 

# our final base image
FROM openjdk:8-jre-alpine


# copy over the built artifact from the maven image
COPY --from=maven /my-project/target/hello-0.0.1-SNAPSHOT.jar ./

# set the startup command to run your binary
CMD ["java", "-jar", "./hello-0.0.1-SNAPSHOT.jar"]
