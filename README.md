# CI/CD + Docker
### Scenario: Prepare a dockerized test automation solution as part of CI/CD solution for client needs which needs to include the following things:
1. Create image based on ubuntu with JDK and maven
- Fork git repository containing code for automated tests: https://github.com/mtararujs/ui-automation
- Create new docker network called test-automation-setup
```
docker network create test-automation-setup
```

- Define a new Dockerfile where all the instructions for docker image will be
defined:
  - Use ubuntu:21.04 image as the base for your image
  - Install jdk on your ubuntu:(https://linuxize.com/post/install-java-on-ubuntu-18-04/)
  - Install maven on ubuntu (https://linuxize.com/post/how-to-install-apache-maven-on-ubuntu-18-04/)
- Build docker image named ubuntu-jdk-mvn
```
docker build --no-cache -t ubuntu-jdk-mvn -f ubuntu-jdk-mvn .
```
-Run container based on that image
```
docker run --rm -it --name ubuntu-jdk-mvn ubuntu-jdk-mvn
```
- verify that ```java -version``` and ```mvn -version``` returns expected output

- useful commands when working with this task
```
git clone <repo link>
cd <folder name>
docker network ls
docker pull ubuntu:hirsute
docker images
docker images ps
docker images ps -a
docker rmi <image name>
docker build --build-arg BRANCH=main -t mvn_tests -f mvn_tests .
# to check entrypoint version 
docker run --rm -it --entrypoint mvn --name mvn_tests mvn_tests -version
exit
```

2. Define another Dockerfile that will contain test code and maven dependencies:
- Use ubuntu-jdk-mvn image as base image: ``` in the root directory mvn_tests file created ```
- Create new directory called docker and use that as working directory for following instructions ``` see comments in mvn_tests file ```
- Define instruction to copy all git files in docker directory root (pom, src, testng etc.) ``` see comments in mvn_tests file ```
- Run mvn dependency:resolve to resolve dependencies based on copied pom.xml ``` see comments in mvn_tests file ```
- Run mvn clean install -DskipTests to complete and package application ``` see comments in mvn_tests file ```
- Build image and tag it like {dockerhub_username}/mvn_tests:latest
```
docker build -t acikinovs/mvn_tests:latest -f mvn_tests .
```
- Verify that after running the container
```
docker run --rm -it --name test-m acikinovs/mvn_tests
``` 
with command passed - ```mvn clean test -Dbrowser=chrome``` - fails to attempt to execute 2 test cases (expected if some custom selenium grid is not running for you)
```
docker push acikinovs/mvn_tests:latest
```

3. Setup Selenium Grid and Nodes which is going to be used during execution of automated tests so that you would have containerized environment for tests to run
- Instaling and starting jenkins locally \
Sample commands: \
Install the latest LTS version: ```brew install jenkins-lts``` \
Install a specific LTS version: ```brew install jenkins-lts@YOUR_VERSION``` \
Start the Jenkins service: ```brew services start jenkins-lts``` \
Restart the Jenkins service: ```brew services restart jenkins-lts``` \
Update the Jenkins version: ```brew upgrade jenkins-lts``` \

4. Choose your preferred CI/CD tool (you can also take one outside the scope of our course if you are familiar with others) and set up proof of concept for the client web application CI/CD process
