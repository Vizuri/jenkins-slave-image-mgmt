FROM registry.redhat.io/openshift4/ose-jenkins-agent-base:v4.3

MAINTAINER Kent Eudy <keudy@vizuri.com>

LABEL com.redhat.component="jenkins-slave-image-mgmt" \
      name="skopeojenkinsslave" \
      architecture="x86_64" \
      io.k8s.display-name="Jenkins Slave Image Management" \
      io.k8s.description="Image management tools on top of the jenkins slave base image" \
      io.openshift.tags="openshift,jenkins,slave,copy"
USER root

RUN yum repolist > /dev/null && \
    yum clean all && \
    yum repolist --disablerepo=* && \
    yum-config-manager --disable \* > /dev/null && \
    yum-config-manager --enable rhel-7-server-rpms && \
    yum-config-manager --enable rhel-7-server-extras-rpms  && \
    yum-config-manager --enable rhel-7-server-optional-rpms && \
    yum-config-manager --enable rhel-7-server-ose-3.9-rpms && \
    INSTALL_PKGS="skopeo" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    INSTALL_PKGS="atomic-openshift-clients" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    yum clean all

RUN yum install sshpass -y

USER 1001
