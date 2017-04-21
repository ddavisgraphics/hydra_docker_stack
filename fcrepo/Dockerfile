FROM java:8
# Set Environment Variables
ENV FCREPO_VERSION=4.5.1 \
    APP_DIR=/opt/fcrepo \
    FCREPO_HOME=/opt/fcrepo/data \
    FCREPO_PORT=8984
# Download the FCREPO Jar
RUN export FCREPO_JAR=fcrepo-webapp-${FCREPO_VERSION}-jetty-console.jar && \
    mkdir -p ${APP_DIR} && \
    curl -L https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-${FCREPO_VERSION}/${FCREPO_JAR} \
        > ${APP_DIR}/${FCREPO_JAR}
EXPOSE ${FCREPO_PORT}
# Create the fcrepo_home directory and run the app.
CMD mkdir -p ${FCREPO_HOME} && \
    java -Dfcrepo.home=${FCREPO_HOME} \
    -jar ${APP_DIR}/fcrepo-webapp-${FCREPO_VERSION}-jetty-console.jar \
    --port ${FCREPO_PORT} \
    --headless 2>&1 \
    | tee -a ${FCREPO_HOME}/fcrepo.log
