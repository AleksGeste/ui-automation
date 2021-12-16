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

# push to docker hub
docker push acikinovs/mvn_tests:latest

# list specific images
docker images | grep ubuntu

# create image with no command histore
# docker commit {name_of_running_container}
# that will allow us to run that container with installed stuff
