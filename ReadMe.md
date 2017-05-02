# Configure Solr / Blacklight / Fedora 

Use the internal IP to get to each resource or the firewalls on the system will block you from the ports, at least locally.  These can be configured out and changed on the host machines.  

## SOLR IP

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' solr 

## FEDORA IP 

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' fedora


# Docker Containers Networking for Fedora and Solr 

By default Docker containers can make connections to the outside world, but the outside world cannot connect to containers. Each outgoing connection will appear to originate from one of the host machine’s own IP addresses thanks to an iptables masquerading rule on the host machine that the Docker server creates when it starts:

https://docs.docker.com/engine/userguide/networking/default_network/binding/