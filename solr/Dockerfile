FROM        solr:6.1.0-alpine
MAINTAINER  David J. Davis <djdavis@mail.wvu.edu>
ADD         ./config/schema.xml conf/
ADD         ./config/solrconfig.xml conf/
USER        root
RUN         /bin/chown -R solr:solr conf
