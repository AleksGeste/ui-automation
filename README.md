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

- verify that `java -version` and `mvn -version` returns expected output

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

- Use ubuntu-jdk-mvn image as base image: `in the root directory mvn_tests file created`
- Create new directory called docker and use that as working directory for following instructions `see comments in mvn_tests file`
- Define instruction to copy all git files in docker directory root (pom, src, testng etc.) `see comments in mvn_tests file`
- Run mvn dependency:resolve to resolve dependencies based on copied pom.xml `see comments in mvn_tests file`
- Run mvn clean install -DskipTests to complete and package application `see comments in mvn_tests file`
- Build image and tag it like {dockerhub_username}/mvn_tests:latest

```
docker build -t acikinovs/mvn_tests:latest -f mvn_tests .
```

- Verify that after running the container

```
docker run --rm -it --name test-m acikinovs/mvn_tests
```

with command passed - `mvn clean test -Dbrowser=chrome` - fails to attempt to execute 2 test cases (expected if some custom selenium grid is not running for you)

```
docker push acikinovs/mvn_tests:latest
```

3. Setup Selenium Grid and Nodes which is going to be used during execution of automated tests so that you would have containerized environment for tests to run

- Get familiar with instructions how to run hub and nodes: https://github.com/SeleniumHQ/docker-selenium#selenium-grid-hub-and-nodes
- Define a docker-compose which includes 3 services (selenium-hub, chrome, firefox.
  - Images used for those services - selenium/hub, selenium/node-chrome, selenium/node-firefox - latest image version could be used. Make sure selenium-hub service has container name defined.
  - Hub needs to be exposed on 4444 port (mapped to 4444 port in container).
  - Make sure all docker services defined in docker compose are linked to network
    created before:

```
  networks:
    test-automation-setup:
      external: true
```

- Make chrome and firefox services be dependent on hub service.
- Run docker compose

```
docker-compose up
```

- After docker-compose up you should be able to access `http://localhost:4444/grid/console` in your browser and be able to access your grid console.
- Run container from your previously built image ({dockerhub_username}/mvn_tests:latest) to verify if test container is able to access selenium grid:

```
docker run -it --network=test-automation-setup acikinovs/mvn_tests:latest mvn clean test -Dbrowser=chrome -DgridURL=selenium-hub:4444
```

- Add definition of new service in the compose file called mvn-tests which is going to use build definition as image (so the image needs to be built based on Dockerfile):

  - This service needs to be using the same network as selenium services
  - On docker-compose up it needs to execute

  ```
  mvn clean test -Dbrowser=chrome -DgridURL=selenium-hub:4444
  ```

  - Each test execution produces Allure results for tests in target/allure-results. In order to get an HTML report from those files, you need to execute mvn io.qameta.allure:allure-maven:report. In terminal full command to run tests, generate report and copy report outside target directory could be

  ```
  command: >
  bash -c "
   mvn clean test -Dbrowser=chrome -DgridURL=selenium-hub:4444
   && mvn io.qameta.allure:allure-maven:report
   && rm -rf test-output/*
   && cp -r target/site/allure-maven-plugin test-output"
  ```

  So extend the previous command or add those commands to your docker file (COMMAND/ENTRYPOINT) and it will result in having an HTML report available in your preferred directory outside target when running tests in the container.
  Define shared volume for this service specifying that copied directory from container to some directory on your host so that after test execution you have test results available on your host.

  ```
  volumes:
     - $PWD/test-output:/docker/test-output
  ```

  - If everything is defined properly, then docker-compose up should run all services and tests should be passing. If proper command and shared volume are defined in the compose file, then on host you should be able to see that reports are accessible.

4. Choose your preferred CI/CD tool (you can also take one outside the scope of our course if you are familiar with others) and set up proof of concept for the client web application CI/CD process

- Instaling and starting jenkins locally \
  Sample commands: \
  Install the latest LTS version: `brew install jenkins-lts` \
  Install a specific LTS version: `brew install jenkins-lts@YOUR_VERSION` \
  Start the Jenkins service: `brew services start jenkins-lts` \
  Restart the Jenkins service: `brew services restart jenkins-lts` \
  Update the Jenkins version: `brew upgrade jenkins-lts` \

- Configuration file for simple pipeline is `docker-image-rebuild-pipeline`
- Configuration file for difficult pipeline is `web-application-pipeline`
- Also based on configurations `send_notification.sh` file was changet to be able receive notivication about job runs

Usefull commands: \

```
docker exec <container name> pwd
docker exec <container name> ls
docker container stop <container name>
docker container rm <container name>
```

Thank you! \
Very interesing course!
