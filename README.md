docker run hello-world
cd /Users/home/Projects/Education/TestDevLab/Docker2021/docker_final
git clone https://github.com/AleksGeste/ui-automation.git
cd ui-automation
brew install jenkins-lts
brew services start jenkins-lts
docker ps
docker network ls
docker pull ubuntu:hirsute
docker images
docker network create --driver bridge test-automation-setup
docker network ls
docker build --no-cache -t ubuntu-jdk-mvn -f ubuntu-jdk-mvn .
docker images

# double check commands (not necesarry to execute)
docker ps
docker rmi c967143cad5e
docker images
docker build -t ubuntu-jdk-mvn .
docker images
# end

docker run -it --name ubuntu-jdk-mvn ubuntu-jdk-mvn
docker run -rm -it --name ubuntu-jdk-mvn ubuntu-jdk-mvn

# day 2
# delete image
# create image again with with docker file name ubuntu-jdk-mvn 

clear
docker ps
docker images
docker images
docker rm c967143cad5e
docker rmi c967143cad5e
docker images
docker run --rm -it --name ubuntu-jdk-mvn-tests ubuntu-jdk-mvn-tests
docker images
docker images ps
docker build -t ubuntu-jdk-mvn-tests -f ubuntu-jdk-mvn-tests .
docker images
docker run --rm -it --name ubuntu-jdk-mvn-tests ubuntu-jdk-mvn-tests
docker build -t mvn_tests -f mvn_tests .
docker run --rm -it --name mvn_tests mvn_tests

# delete all unused images and create new with right names
docker build --no-cache -t ubuntu-jdk-mvn -f ubuntu-jdk-mvn .
docker build --build-arg BRANCH=main -t mvn_tests -f mvn_tests .
docker run --rm -it --name mvn_tests mvn_tests

# inside container can check argument
# echo $BRANCH_IS

# to check entrypoint version 
#docker run --rm -it --entrypoint mvn --name mvn_tests mvn_tests -version

# build
docker build --no-cache -t acikinovs/mvn_tests:latest -f mvn_tests .
# push to docker hub
docker push acikinovs/mvn_tests:latest

# list specific images
docker images | grep ubuntu

# create image with no command histore
# docker commit {name_of_running_container}
# that will allow us to run that container with installed stuff


# Day 3
## Setup Selenium Grid and Nodes which is going to be used during execution of automated tests so that you would have containerized environment for tests to run.
- Run commands to see that everything is there where it was left off
```
home@aleks ui-automation % docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
home@aleks ui-automation % docker ps -a
CONTAINER ID   IMAGE         COMMAND    CREATED      STATUS                  PORTS     NAMES
6610735943b0   hello-world   "/hello"   2 days ago   Exited (0) 2 days ago             infallible_swartz
home@aleks ui-automation % docker images
REPOSITORY            TAG       IMAGE ID       CREATED        SIZE
acikinovs/mvn_tests   latest    c50cfd78cf30   27 hours ago   841MB
ubuntu-jdk-mvn        latest    85be2a52c2fe   27 hours ago   790MB
ubuntu                hirsute   d662230a2592   13 days ago    80MB
hello-world           latest    feb5d9fea6a5   2 months ago   13.3kB
```

- Create yml file with name docker-compose.yml in the roo folder
``` code```
- somthig more
- run container from your previously built image
```docker run -it --network=test-automation-setup acikinovs/mvn_tests mvn clean test -Dbrowser=chrome -DgridURL=selenium/hub:4444```

### day 3 task done

# Need to do:
1. Choose your preferred CI/CD tool (you can also take one outside the scope of our course if you are familiar with others) and set up proof of concept for the client web application CI/CD process:
2. Clear and refactor readme file
