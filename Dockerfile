FROM ubuntu:hirsute
LABEL "Author"="Aleksandrs Cikinovs"
LABEL "Company"="TestDevLab" 
LABEL "email"="aleksandrs.cikinovs@testdevlab.com"
LABEL version="1.0"
LABEL description="This is the Dockerfile for \
the final homework in the cousre CI-CD. \
1. task: Create image based on ubuntu with JDK and maven."
RUN apt update
RUN apt upgrade -y
RUN apt install default-jdk -y
RUN apt install maven -y


