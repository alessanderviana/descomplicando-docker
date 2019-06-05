FROM registry.access.redhat.com/jboss-eap-7/eap71-openshift

MAINTAINER "Alessander Viana" "alessander.viana@hotmail.com"

COPY SampleWebApp.war $JBOSS_HOME/standalone/deployments/

# User root to modify war owners
USER root

RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/SampleWebApp.war

# Important, use jboss user to run image
USER jboss
