FROM java:8-jdk-alpine

ENV JMETER_VERSION=3.1
ENV INSTALL_LOCATION=/usr/local
ENV JMETER_HOME=$INSTALL_LOCATION/jmeter
ENV PATH=${JMETER_HOME}/bin:${PATH}

RUN apk add --no-cache --update \
  curl \
  openssl \
  ca-certificates


RUN cd $INSTALL_LOCATION && \
    wget http://mirror.vorboss.net/apache//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
    tar -xzf apache-jmeter-${JMETER_VERSION}.tgz && \
    mv apache-jmeter-${JMETER_VERSION} ${JMETER_HOME} && \ 
    rm -rf apache-jmeter-${JMETER_VERSION}.tgz \
      ${JMETER_HOME}/bin/examples \
      ${JMETER_HOME}/bin/templates \
      ${JMETER_HOME}/bin/*.cmd \
      ${JMETER_HOME}/bin/*.bat \
      ${JMETER_HOME}/docs \
      ${JMETER_HOME}/printable_docs

ENV JMETER_PLUGINS_VERSION=1.4.0
ENV JMETER_CUSTOM_THREADS_VERSION=2.1
RUN cd $JMETER_HOME && \
      wget http://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-${JMETER_PLUGINS_VERSION}.zip && \
      wget http://jmeter-plugins.org/downloads/file/JMeterPlugins-Extras-${JMETER_PLUGINS_VERSION}.zip && \
      wget http://jmeter-plugins.org/downloads/file/JMeterPlugins-ExtrasLibs-${JMETER_PLUGINS_VERSION}.zip && \
      wget http://jmeter-plugins.org/files/packages/jpgc-casutg-${JMETER_CUSTOM_THREADS_VERSION}.zip && \
      unzip -o JMeterPlugins-Standard-${JMETER_PLUGINS_VERSION}.zip && \
      rm JMeterPlugins-Standard-${JMETER_PLUGINS_VERSION}.zip && \
      unzip -o JMeterPlugins-Extras-${JMETER_PLUGINS_VERSION}.zip && \
      rm JMeterPlugins-Extras-${JMETER_PLUGINS_VERSION}.zip && \
      unzip -o JMeterPlugins-ExtrasLibs-${JMETER_PLUGINS_VERSION}.zip && \
      rm JMeterPlugins-ExtrasLibs-${JMETER_PLUGINS_VERSION}.zip && \
      unzip -o jpgc-casutg-${JMETER_CUSTOM_THREADS_VERSION}.zip && \
      rm jpgc-casutg-${JMETER_CUSTOM_THREADS_VERSION}.zip

ENV INFLUX_WRITER_VERSION=1.0
RUN cd $JMETER_HOME/lib/ext && \
    wget https://github.com/ynaa/JMeter-WebSocketSampler/releases/download/version-1.0.2/JMeterWebSocketSampler-1.0.2-SNAPSHOT.jar && \
    wget http://central.maven.org/maven2/org/eclipse/jetty/websocket/websocket-server/9.1.1.v20140108/websocket-server-9.1.1.v20140108.jar && \
    wget http://central.maven.org/maven2/org/eclipse/jetty/jetty-io/9.1.1.v20140108/jetty-io-9.1.1.v20140108.jar && \
    wget http://central.maven.org/maven2/org/eclipse/jetty/jetty-util/9.1.1.v20140108/jetty-util-9.1.1.v20140108.jar && \
    wget http://central.maven.org/maven2/org/eclipse/jetty/websocket/websocket-api/9.1.1.v20140108/websocket-api-9.1.1.v20140108.jar && \
    wget http://central.maven.org/maven2/org/eclipse/jetty/websocket/websocket-client/9.1.1.v20140108/websocket-client-9.1.1.v20140108.jar && \
    wget http://central.maven.org/maven2/org/eclipse/jetty/websocket/websocket-common/9.1.1.v20140108/websocket-common-9.1.1.v20140108.jar && \
    curl -O https://github.com/NovaTecConsulting/JMeter-InfluxDB-Writer/releases/download/v-${INFLUX_WRITER_VERSION}/JMeter-InfluxDB-Writer-plugin-${INFLUX_WRITER_VERSION}.jar


EXPOSE 60000

RUN mkdir /tests

WORKDIR /tests


ENV JMETER_SLAVES=jmeter-slave

# copy entrypoint script
ADD entrypoint.sh  /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
# vim:set ft=dockerfile:
