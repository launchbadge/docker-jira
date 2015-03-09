# https://registry.hub.docker.com/u/phusion/baseimage/
FROM phusion/baseimage:latest
MAINTAINER launchbadge <contact@launchbadge.com>

# Install base system requirements
RUN apt-get update && \
    apt-get install -q -y \
      git-core \
      curl \
      sudo \
      xmlstarlet \
      software-properties-common \
      python-software-properties

# Install Java 8
RUN apt-add-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install oracle-java8-installer -y

# Install Jira
ENV JIRA_VERSION 6.3.3
VOLUME ["/data"]
RUN curl -Lks http://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-${JIRA_VERSION}.tar.gz -o /root/jira.tar.gz && \
    mkdir /opt/jira && \
    tar zxf /root/jira.tar.gz --strip=1 -C /opt/jira && \
    echo "jira.home = /data" > /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties && \
    rm -rf /root/jira.tar.gz

# Configure start
WORKDIR /opt/jira
EXPOSE 8080
ADD start.sh /start.sh
CMD ["/start.sh"]
