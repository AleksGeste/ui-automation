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
docker build --no-cache . -f ubuntu-jdk-mvn
docker build . -f ubuntu-jdk-mvn
docker images
docker ps
docker rmi c967143cad5e
docker images
docker build -t ubuntu-jdk-mvn .
docker images
docker run -it --name ubuntu-jdk-mvn ubuntu-jdk-mvn
docker run -rm -it --name ubuntu-jdk-mvn ubuntu-jdk-mvn
